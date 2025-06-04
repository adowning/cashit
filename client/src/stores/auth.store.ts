// apps/client/src/stores/auth.ts
import { computed, ref, readonly } from 'vue' // Added readonly
import { defineStore } from 'pinia'
import { router } from '@/router'
import type {
  AuthCredentials,
  AuthResponseDto, // Assuming this includes accessToken, refreshToken, user: UserProfile
  GoogleSignInDto,
  GoogleSignInResponse, // Assuming this includes accessToken, refreshToken, user: UserProfile
  RefreshTokenDto,
  SignUpPayload as OriginalSignUpPayload, // Rename to avoid conflict if we redefine locally
} from '@/interfaces' // Adjust the import path as needed
import { useAuthClient } from '@/composables/useBetterAuth' // Returns { signIn, signUp, getSession, etc. }
import { orpcManager } from '@/utils/orpc.client'
import type { UserProfile } from 'shared' // This should be the definitive UserProfile type
// Assuming useNotificationStore is available and provides an addNotification method
import { useNotificationStore } from '@/stores/notification.store'
// Assuming useApiClient is available and provides api.auth methods
import useApiClient from '@/composables/useApiClient' // Corrected import
import destr from 'destr'

const DEFAULT_AVATAR_FALLBACK = 'avatar-default.webp'

interface AuthErrorState {
  message: string
  error?: string | null
  code?: number | string
  details?: any
}

// Helper type for the common { data, error } response structure from useAuthClient
// R is the type of the 'data' field within the successful response from authClient
interface AuthClientResponse<RData> {
  data: RData | null
  error: { message: string; code?: number | string; status?: number; [key: string]: any } | null
}

// Define a type for the user object returned by better-auth if it's simpler
type BetterAuthUser = {
  id: string
  email: string
  username?: string // username might be part of better-auth user
  name?: string // name might be part of better-auth user
  image?: string | null // image might be part of better-auth user
  // other fields from better-auth user if known
}

// Define what AuthResponse-like objects might contain, accommodating different user types
type AuthApiResponseData = Partial<{
  token?: string
  accessToken?: string
  refreshToken?: string
  user?: UserProfile | BetterAuthUser // User can be full UserProfile or simpler BetterAuthUser
}>

// Define SignUpPayload to include name, as better-auth expects it
interface SignUpPayload extends OriginalSignUpPayload {
  name?: string // Add name, make it optional if username can be used as fallback
  username: string // Ensure username is present from OriginalSignUpPayload
}

export const useAuthStore = defineStore(
  'auth',
  () => {
    const apiClient = useApiClient() // For Google Sign-In, logout
    const authClient = useAuthClient() // For email/password auth, session
    const restClient = orpcManager.getRestClient() // For fetching current user via ORPC
    const notificationStore = useNotificationStore()

    // --- State ---
    const accessToken = ref<string | null>(null)
    const refreshToken = ref<string | null>(null)
    const currentUser = ref<UserProfile | null>(null)
    const isLoading = ref<boolean>(false)
    const authError = ref<AuthErrorState | null>(null)
    const initialAuthCheckComplete = ref<boolean>(false)
    const isSignUpMode = ref<boolean>(false)
    const authModalType = ref<string | null>(null)
    const authDialogVisible = ref<boolean>(false)

    // --- Getters ---
    const isAuthenticated = computed(() => !!accessToken.value && !!currentUser.value)
    const userAvatar = computed(() => currentUser.value?.avatar || DEFAULT_AVATAR_FALLBACK)

    // --- Internal Core Logic Functions ---

    function _setAccessToken(token: string | null) {
      accessToken.value = token
      if (token) {
        orpcManager.setToken(token)
      } else {
        // orpcManager.clearToken(); // If exists
      }
    }

    function _setRefreshToken(token: string | null) {
      refreshToken.value = token
    }

    function _setCurrentUser(user: UserProfile | null) {
      if (user) {
        user.avatar = user.avatar || DEFAULT_AVATAR_FALLBACK
        currentUser.value = { ...user }
        authError.value = null
      } else {
        currentUser.value = null
      }
    }

    function _isFullUserProfile(user: any): user is UserProfile {
      // Add a more robust check if possible, e.g., checking for a property unique to UserProfile
      return (
        user &&
        (typeof user.balance !== 'undefined' ||
          typeof user.cashtag !== 'undefined' ||
          typeof user.avatar === 'string')
      )
    }

    function _processAuthResponse(responseData: AuthApiResponseData | null) {
      if (!responseData) return

      const tokenToSet = responseData.token || responseData.accessToken
      if (tokenToSet) {
        _setAccessToken(tokenToSet)
      }
      if (responseData.refreshToken) {
        _setRefreshToken(responseData.refreshToken)
      }
      // Only set user if it's a full UserProfile. Otherwise, rely on fetchCurrentUser.
      if (responseData.user && _isFullUserProfile(responseData.user)) {
        _setCurrentUser(responseData.user as UserProfile)
      }
    }

    function _clearAuthCoreLogic() {
      _setAccessToken(null)
      _setRefreshToken(null)
      _setCurrentUser(null)
    }

    async function _handleAuthApiCall<P, RApi extends AuthApiResponseData>(
      apiCall: (payload: P) => Promise<AuthClientResponse<RApi>>,
      payload: P,
      options: {
        successMessage?: string
        errorMessagePrefix: string
        fetchUserAfterSuccessIfNotProvided?: boolean
      }
    ): Promise<{ success: boolean; data: RApi | null; error: AuthErrorState | null }> {
      if (isLoading.value) {
        const busyError: AuthErrorState = {
          message: 'An authentication process is already in progress.',
        }
        return { success: false, data: null, error: busyError }
      }

      isLoading.value = true
      authError.value = null
      let resultData: RApi | null = null
      let operationError: AuthErrorState | null = null

      try {
        const response = await apiCall(payload)
        if (response.error || !response.data) {
          operationError = {
            message: `${options.errorMessagePrefix}: ${response.error?.message || 'Unknown error'}`,
            error: response.error?.message,
            code: response.error?.code || response.error?.status,
            details: response.error,
          }
          authError.value = operationError
          notificationStore.addNotification('error', operationError.message)
        } else {
          resultData = response.data
          _processAuthResponse(resultData) // Sets tokens, and user if it's UserProfile

          if (
            options.fetchUserAfterSuccessIfNotProvided &&
            !currentUser.value &&
            accessToken.value
          ) {
            // If user wasn't set by _processAuthResponse (e.g., was simpler type), fetch full profile.
            const userFetchSuccess = await fetchCurrentUser()
            if (!userFetchSuccess) {
              console.warn('AuthStore: Token received, but subsequent user fetch failed.')
              // Consider how to handle this: partial auth or clear all?
              // authError.value = { message: "Session established but user profile could not be loaded." };
              // notificationStore.addNotification('warning', authError.value.message);
              // Potentially return error or a specific status
            }
          }
          if (options.successMessage) {
            notificationStore.addNotification('success', options.successMessage)
          }
        }
      } catch (e: any) {
        console.error(`AuthStore: Unexpected error during ${options.errorMessagePrefix}`, e)
        operationError = {
          message:
            `${options.errorMessagePrefix}: An unexpected error occurred. ${e.message || ''}`.trim(),
          error: e.message,
          code: e.code || e.status,
          details: e,
        }
        authError.value = operationError
        notificationStore.addNotification('error', operationError.message)
      } finally {
        isLoading.value = false
      }
      return { success: !operationError, data: resultData, error: operationError }
    }

    function setAuthData(data: AuthApiResponseData | string | UserProfile) {
      if (typeof data === 'string') {
        _setAccessToken(data)
      } else if (_isFullUserProfile(data)) {
        // Check if it's UserProfile
        _setCurrentUser(data as UserProfile)
      } else {
        // Assumed to be AuthApiResponseData
        _processAuthResponse(data as AuthApiResponseData)
      }
    }

    function clearAuthData() {
      _clearAuthCoreLogic()
    }

    async function initializeAuth() {
      console.log(initialAuthCheckComplete.value && isAuthenticated.value)
      if (initialAuthCheckComplete.value && isAuthenticated.value) {
        return
      }
      console.log(accessToken.value)
      if (!accessToken.value) {
        let authData = localStorage.getItem('auth')
        authData = destr(authData)
        if (authData !== null) {
          accessToken.value = authData.accessToken
          console.log(accessToken.value)
        } else {
          _clearAuthCoreLogic()
          initialAuthCheckComplete.value = true
          return
        }
      }
      console.log(accessToken.value)
      if (!accessToken.value) {
        _clearAuthCoreLogic()
        initialAuthCheckComplete.value = true
        return
      }

      isLoading.value = true
      initialAuthCheckComplete.value = false

      try {
        // Assuming getSession returns { data: { session?: { token: string }, user?: BetterAuthUser | UserProfile  } }
        // Adjust based on actual structure of authClient.getSession()
        const response = await authClient.getSession() // This needs to conform to AuthClientResponse

        if (response.data) {
          const sessionToken = (response.data as any).session?.token || (response.data as any).token
          const userFromSession = (response.data as any).user

          _processAuthResponse({
            token: sessionToken,
            user: userFromSession,
          })

          if (!currentUser.value && accessToken.value) {
            await fetchCurrentUser()
          }
        } else {
          console.warn('AuthStore: Initialization - getSession returned no data.')
          await logoutUser(false)
        }
      } catch (e: any) {
        console.error('AuthStore: Initialization - getSession failed.', e.message)
        authError.value = {
          message: e.message || 'Session validation failed during initialization.',
          error: e.error || e.message,
          code: e.code,
          details: e.details,
        }
        await logoutUser(false)
      } finally {
        isLoading.value = false
        initialAuthCheckComplete.value = true
      }
    }

    async function fetchCurrentUser(): Promise<boolean> {
      if (!accessToken.value) {
        return false
      }
      isLoading.value = true
      let success = false
      try {
        const userProfile = await restClient.user.getCurrentUser() // Assumed to return UserProfile
        if (userProfile) {
          _setCurrentUser(userProfile)
          success = true
        } else {
          console.warn('AuthStore: fetchCurrentUser succeeded but returned no user data.')
          authError.value = { message: 'User profile could not be loaded.' }
        }
      } catch (e: any) {
        console.error('AuthStore: Failed to fetch current user.', e)
        const errorObj = e as {
          code?: number
          status?: number
          message?: string
          error?: string
          details?: any
        }
        authError.value = {
          message: errorObj.message || 'Failed to refresh user data.',
          error: errorObj.error || errorObj.message,
          code: errorObj.code || errorObj.status,
          details: errorObj.details || e,
        }
        if (errorObj.code === 401 || errorObj.status === 401) {
          await logoutUser(false)
        }
      } finally {
        isLoading.value = false
      }
      return success
    }

    async function fetchCurrentSession() {
      if (!isAuthenticated.value) return
      return fetchCurrentUser()
    }

    async function signInWithPassword(payload: AuthCredentials) {
      // authClient.signIn.username is expected to return Promise<AuthClientResponse<RApi>>
      // RApi here is AuthApiResponseData
      const apiCall = (
        creds: AuthCredentials
      ): Promise<AuthClientResponse<AuthApiResponseData>> => {
        // The actual call to authClient might need casting or a proper adapter if its direct return type
        // doesn't exactly match AuthClientResponse<AuthApiResponseData>, especially the 'user' field structure.
        return authClient.signIn.username(creds) as any // Using 'as any' for now due to potential deep type mismatches from better-auth
      }
      return _handleAuthApiCall(apiCall, payload, {
        successMessage: 'Login successful!',
        errorMessagePrefix: 'Sign-in failed',
        fetchUserAfterSuccessIfNotProvided: true,
      })
    }

    async function signUpNewUser(payload: SignUpPayload) {
      const apiCall = (creds: SignUpPayload): Promise<AuthClientResponse<AuthApiResponseData>> => {
        const actualPayload = {
          email: creds.email,
          password: creds.password,
          username: creds.username,
          name: creds.name || creds.username, // Ensure 'name' is provided to better-auth
        }
        return authClient.signUp.email(actualPayload) as any // Use email signup with username data
      }
      return _handleAuthApiCall(apiCall, payload, {
        successMessage: 'Registration successful! Welcome.',
        errorMessagePrefix: 'Sign-up failed',
        fetchUserAfterSuccessIfNotProvided: true,
      })
    }

    async function signInWithGoogleIdToken(idToken: string) {
      if (isLoading.value) {
        return { success: false, data: null, error: { message: 'Process already in progress.' } }
      }
      isLoading.value = true
      authError.value = null
      let responseData: GoogleSignInResponse | null = null

      try {
        const googleSignInPayload: GoogleSignInDto = { idToken }
        responseData = await apiClient.auth.signInWithGoogle(googleSignInPayload)
        if (responseData) {
          // Null check for responseData
          _processAuthResponse(responseData)
        }
        notificationStore.addNotification('success', 'Successfully signed in with Google!')
        return { success: true, data: responseData, error: null }
      } catch (e: any) {
        console.error('AuthStore: Google Sign-in failed', e)
        const errorObj = e as {
          code?: number
          status?: number
          message?: string
          error?: string
          details?: any
        }
        const err: AuthErrorState = {
          message: errorObj.message || 'Google Sign-in failed.',
          code: errorObj.code || errorObj.status,
          error: errorObj.error || errorObj.message,
          details: errorObj.details || e,
        }
        authError.value = err
        notificationStore.addNotification('error', err.message)
        return { success: false, data: null, error: err }
      } finally {
        isLoading.value = false
      }
    }

    async function logoutUser(navigate = true) {
      isLoading.value = true
      const tokenToInvalidate = refreshToken.value
      _clearAuthCoreLogic()
      authError.value = null
      try {
        if (tokenToInvalidate) {
          await apiClient.auth.logout({ refreshToken: tokenToInvalidate } as RefreshTokenDto)
        }
      } catch (e: any) {
        console.warn('AuthStore: Server-side logout call failed:', (e as Error).message)
      } finally {
        isLoading.value = false
        initialAuthCheckComplete.value = true
        if (navigate) {
          router.push('/login')
        }
      }
    }

    function toggleSignUpMode() {
      isSignUpMode.value = !isSignUpMode.value
    }

    function setAuthError(newError: AuthErrorState | null) {
      authError.value = newError
    }
    function clearAuthErrorAndResetSignUpToggle() {
      authError.value = null
      isSignUpMode.value = false
    }
    function setAuthModalType(type: string | null) {
      authModalType.value = type
    }
    function setAuthDialogVisible(visible: boolean) {
      authDialogVisible.value = visible
    }
    /**
     * Updates the balance for the current user.
     * It's crucial this is reactive so TopBarMobile updates.
     * @param newBalance - The new balance amount.
     */
    function updateUserBalance(newBalance: number): void {
      if (currentUser.value) {
        currentUser.value.balance = newBalance // { ...currentUser.value, ...profileUpdates }
        console.log(`AuthStore: User ${currentUser.value.id} profile updated.`)
      } else {
        console.warn(
          'AuthStore: updateUserProfile called, but no currentUser or profile is available.'
        )
      }
    }
    return {
      accessToken: readonly(accessToken),
      refreshToken: readonly(refreshToken),
      currentUser: readonly(currentUser),
      isLoading: readonly(isLoading),
      authError: readonly(authError),
      initialAuthCheckComplete: readonly(initialAuthCheckComplete),
      isSignUpMode: readonly(isSignUpMode),
      authModalType: readonly(authModalType),
      authDialogVisible: readonly(authDialogVisible),
      isAuthenticated,
      userAvatar,
      updateUserBalance,
      initializeAuth,
      fetchCurrentUser,
      fetchCurrentSession,
      signInWithPassword,
      signUpNewUser,
      signInWithGoogleIdToken,
      logout: logoutUser,
      setAuthData,
      clearAuthData,
      toggleSignUpMode,
      setAuthError,
      clearAuthErrorAndResetSignUpToggle,
      setAuthModalType,
      setAuthDialogVisible,
    }
  },
  {
    persist: {
      storage: localStorage,
      pick: ['accessToken', 'refreshToken', 'currentUser', 'isSignUpMode'], // Corrected 'paths' to 'pick'
    },
  }
)
