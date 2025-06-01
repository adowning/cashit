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
      if (initialAuthCheckComplete.value && isAuthenticated.value) {
        return
      }
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
        return authClient.signUp.email(actualPayload) as any // Using 'as any' for now
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

// Example of how to use the store outside a component (if needed, e.g., in a boot file)
// import { store } from '@/stores'; // Assuming your main Pinia instance is exported as 'store'
// export function useAuthStoreOutside() {
//   return useAuthStore(store);
// }

// // apps/client/src/stores/auth.ts
// import { computed, ref } from 'vue'
// import { defineStore } from 'pinia'
// import { store } from '@/stores'
// // import { useRouter } from 'vue-router' // Import useRouter if not globally available
// import { router } from '@/router'
// import type {
//   AuthCredentials,
//   AuthResponseDto,
//   GoogleSignInDto,
//   GoogleSignInResponse,
//   RefreshTokenDto, // Used for logout payload type
//   SignUpPayload,
// } from '@/interfaces' // Adjust the import path as needed
// import { useAuthClient } from '@/composables/useBetterAuth'
// import { orpcManager } from '@/utils/orpc.client'
// import type { UserProfile } from 'shared'

// // It's good practice to define these keys centrally if they are used elsewhere,
// // but for a store, keeping them here is fine too.
// const DEFAULT_AVATAR_FALLBACK = 'avatar-default.webp' // Example default

// interface AuthErrorState {
//   message: string
//   error: string | null
//   code?: number | string // HTTP status code or custom error code
//   details?: any // Optional additional error details
// }

// export const useAuthStore = defineStore(
//   'auth',
//   () => {
//     // const router = useRouter() // Initialize router instance
//     const api = useApiClient()
//     const restClient = orpcManager.getRestClient()

//     // --- State ---
//     // These will be automatically hydrated from localStorage if pinia-plugin-persistedstate is configured
//     // to persist these specific refs.
//     const accessToken = ref<string | null>(null)
//     const refreshToken = ref<string | null>(null) // Consistent with accessToken (string | null)
//     const currentUser = ref<UserProfile | null>(null)

//     const isLoading = ref<boolean>(false) // For UI feedback during auth operations
//     const isBusy = ref<boolean>(false) // For UI feedback during auth operations
//     const isSignUpMode = ref<boolean>(false) // For UI feedback during auth operations
//     const authError = ref<AuthErrorState | null>(null) // Stores the last auth-related error
//     const initialAuthCheckComplete = ref<boolean>(false) // Tracks if the initial auth check has run
//     const authModalType = ref<string | null>(null)
//     const authDialogVisible = ref<boolean>(false)

//     // --- Getters ---
//     const isAuthenticated = computed(() => !!accessToken.value && !!currentUser.value)
//     const userAvatar = computed(() => currentUser.value?.avatar || DEFAULT_AVATAR_FALLBACK)

//     function toggleSignUp() {
//       isSignUpMode.value = !isSignUpMode.value
//     }
//     function setAuthenticated() {
//       isSignUpMode.value = !isSignUpMode.value
//     }
//     // --- Actions ---

//     /**
//      * Sets the authentication data in the store and persists tokens.
//      * This function is critical and should be the single source of truth for updating auth state.
//      * It's also typically called by the apiClient after a successful token refresh.
//      */
//     function setAuthData(data: UserProfile | string) {
//       if (typeof data === 'string') {
//         return (accessToken.value = data)
//       }
//       // accessToken.value = data.accessToken
//       // refreshToken.value = data.refreshToken || null // Ensure null if undefined/empty
//       if (data.avatar === null) data.avatar = 'avatar-10.webp'
//       currentUser.value = data //? { ...data.user } : null // Store a copy
//       authError.value = null // Clear previous errors on successful auth data set
//       // localStorage management is handled by pinia-plugin-persistedstate
//       // if configured for these refs. Manual calls are removed.
//     }

//     function setGoogleAuthData(data: GoogleSignInResponse) {
//       accessToken.value = data.accessToken
//       // refreshToken.value = data.refreshToken || null // Ensure null if undefined/empty
//       if (data.user.avatar === null) data.user.avatar = 'avatar-10.webp'
//       currentUser.value = data.user //? { ...data.user } : null // Store a copy
//       authError.value = null // Clear previous errors on successful auth data set
//       // localStorage management is handled by pinia-plugin-persistedstate
//       // if configured for these refs. Manual calls are removed.
//     }
//     /**
//      * Clears authentication data from the store and persisted storage.
//      */
//     function clearAuthData() {
//       accessToken.value = null
//       refreshToken.value = null
//       currentUser.value = null
//       // Consider if 'error' should be cleared here. Usually, logout clears errors.
//       // Specific action failures might leave the error for the UI to display.

//       // localStorage removal is handled by pinia-plugin-persistedstate
//     }

//     /**
//      * Attempts to initialize authentication state, typically on application startup.
//      * It checks for existing tokens and validates them by fetching the user profile.
//      */
//     async function initializeAuth() {
//       if (initialAuthCheckComplete.value && isAuthenticated.value) {
//         // Already initialized and authenticated, no need to re-run unless forced.
//         // Potentially add a force flag if needed.
//         return
//       }
//       const authClient = useAuthClient() // Access the auth client from Nuxt app context

//       isLoading.value = true // Should be set at the start of the attempt
//       initialAuthCheckComplete.value = false // Reset if re-initializing
//       // console.log(isLoading.value, initialAuthCheckComplete.value)
//       // console.log(accessToken.value)
//       console.log(accessToken.value)
//       // pinia-plugin-persistedstate should have already loaded tokens into accessToken and refreshToken refs.
//       if (accessToken.value) {
//         try {
//           // apiClient.auth.getMe() should ideally handle transparent token refresh.
//           // If getMe() succeeds, it means the token is valid or was refreshed.
//           // The apiClient's interceptor should call `setAuthData` upon successful refresh.
//           const response = await authClient.getSession() // Fetches user, implicitly validates/refreshes token
//           // const response =    async function fetchCurrentUser() {

//           // If apiClient's refresh logic correctly calls setAuthData,
//           // currentUser and tokens would already be updated.
//           // This is more of a reconciliation if getMe returns data slightly different
//           // from what setAuthData received from login/refresh.
//           console.log(response)
//           console.log(isAuthenticated.value)
//           if (response.data !== null) {
//             // currentUser.value = { ...response.user }

//             accessToken.value = response.data.session.token // Ensure accessToken is set
//             setAuthData(response.data.session.token) // Set user data, which includes avatar
//             console.log('here')
//             // const health = await realtimeClient.user.getCurrentUser()
//             // console.log(health)
//           } else {
//             // This case implies getMe succeeded (2xx) but returned no user,
//             // AND the store isn't marked as authenticated (which is odd).
//             // This might indicate an issue with the getMe response or apiClient's refresh flow.
//             // For safety, if not authenticated after getMe, clear.
//             console.warn(
//               'AuthStore: getMe succeeded but no user data returned and not authenticated. Clearing auth.'
//             )
//             await logoutUser(false) // Don't navigate, just clear state
//             clearAuthData() // Clear state to ensure no stale data
//             // }
//           }
//         } catch (e: any) {
//           // If api.auth.getMe() fails (e.g., 401 after refresh attempt, network error),
//           // the apiClient's error handler or interceptor should ideally trigger logout.
//           console.warn('AuthStore: Initialization - getMe failed.', e.message)
//           // No need to call clearAuthData() here if the apiClient's global error handler / interceptor
//           // calls logoutUser() on unrecoverable auth errors (like final 401).
//           // If it doesn't, then: await logoutUser(false);
//           authError.value = {
//             message: e.message || 'Session validation failed.',
//             error: e.error || null,
//             code: e.code,
//             details: e.details,
//           }
//         }
//       } else {
//         // No access token found by the persistence plugin. User is not logged in.
//         // Ensure state is clean, though persistence plugin should handle initial nulls.
//         console.info('AuthStore: Clearing auth.')
//         clearAuthData()
//       }
//       isLoading.value = false
//       initialAuthCheckComplete.value = true
//     }

//     /**
//      * Fetches the current user's profile. Assumes tokens are already handled.
//      * Useful for explicit user data refresh without full re-initialization.
//      */
//     async function fetchCurrentSession() {
//       if (!isAuthenticated.value) {
//         // No point fetching if not authenticated
//         return
//       }
//       isLoading.value = true
//       try {
//         const response = await restClient.user.getCurrentUser()
//         if (response) {
//           currentUser.value = { ...response }
//         }
//         authError.value = null
//       } catch (e: any) {
//         console.error('AuthStore: Failed to fetch current user', e)
//         authError.value = {
//           message: e.message || 'Failed to refresh user data.',
//           error: e.error || null,
//           code: e.code,
//           details: e.details,
//         }
//         // Potentially logout if this implies token invalidity not caught by apiClient
//         if (e.code === 401) {
//           await logoutUser(false) // Don't navigate, just clear state
//         }
//       } finally {
//         isLoading.value = false
//       }
//     }

//     async function fetchCurrentUser() {
//       // if (!isAuthenticated.value) {
//       //   // No point fetching if not authenticated
//       //   return
//       // }
//       isLoading.value = true
//       try {
//         const response = await restClient.user.getCurrentUser()
//         console.log('response ', response)
//         if (response) {
//           currentUser.value = { ...response }
//         }
//         authError.value = null
//         isBusy.value = false
//         setAuthData(response) // Set token in orpcManager

//         return true
//       } catch (e: any) {
//         console.error('AuthStore: Failed to fetch current user', e)
//         authError.value = {
//           message: e.message || 'Failed to refresh user data.',
//           error: e.error || null,
//           code: e.code,
//           details: e.details,
//         }
//         isBusy.value = false

//         // Potentially logout if this implies token invalidity not caught by apiClient
//         if (e.code === 401) {
//           await logoutUser(false) // Don't navigate, just clear state
//         }
//         return false
//       } finally {
//         isBusy.value = false

//         isLoading.value = false
//       }
//     }
//     async function signInWithPassword(payload: AuthCredentials) {
//       // return handleAuthAction(api.auth.login, payload)
//       // isLoading.value = true

//       const authClient = useAuthClient() // Access the auth client from Nuxt app context
//       const notificationStore = useNotificationStore()
//       console.log(payload)
//       try {
//         const { data, error } = await authClient.signIn.username({
//           username: 'test',
//           password: 'password1234',
//         })
//         if (data === undefined || data === null) {
//           const errPayload: AuthErrorState = {
//             message: error?.message || `Action failed`,
//             code: 500, // responseData.error,
//             // details: responseData.error,
//             error: error?.message || null,
//           }
//           authError.value = errPayload
//           console.log(errPayload)

//           console.log('error')
//           // No need to call clearAuthData here on every auth action failure.
//           // Only clear if the failure implies total invalidation of any prior state (e.g. bad creds on login).
//           // For instance, if a token refresh fails within an action, apiClient should handle logout.
//           // If it's a form validation type error from backend, user might still be "logged in".
//           notificationStore.addNotification('error', errPayload.message)
//           return { success: false, error: errPayload }
//           // notificationStore.addNotification('error', error?.message as string)
//           // return { success: false, error: { message: error?.message as string } }
//         } else {
//           notificationStore.addNotification('info', 'Login successful')
//           orpcManager.setToken(data.token) // Set token in orpcManager
//           // router.push('/dashboard')
//           return { success: true, data: data }
//         }
//       } catch (e: any) {
//         console.error(`AuthStore: Action signInWithPassword failed`, e)
//         const errPayload: AuthErrorState = {
//           message: e.error || `Action signInWithPassword failed`,
//           code: e.error,
//           error: e.error,
//         }
//         return { success: false, error: e as ApiError | AuthErrorState } // Return structured error
//       } finally {
//         isLoading.value = false
//       }
//     }

//     async function signUpNewUser(payload: SignUpPayload) {
//       // return handleAuthAction(api.auth.register, payload)
//       const authClient = useAuthClient() // Access the auth client from Nuxt app context
//       const notificationStore = useNotificationStore()
//       console.log(payload)
//       console.log(isBusy.value)
//       if (isBusy.value == false)
//         try {
//           const { data, error } = await authClient.signUp.email({
//             email: payload.email,
//             name: payload.username,
//             password: payload.password,
//             username: payload.username,
//           })
//           isBusy.value = true

//           console.log('data', data)
//           console.log('error', error)
//           if (data !== undefined && data !== null && data.token !== null) {
//             orpcManager.setToken(data.token) // Set token in orpcManager
//             setAuthData(data.token) // Set token in orpcManager
//             // setAuthData(data)
//             return await fetchCurrentUser().then((result) => {
//               if (result == true) {
//                 notificationStore.addNotification('success', 'Registration successful')

//                 // router.push('/dashboard') // Redirect to dashboard or desired page
//                 // notificationStore.addNotification('error', error?.message as string)
//                 return { success: true, error: null, data }
//               } else {
//                 notificationStore.addNotification('error', 'Registration failed')
//                 return { success: false, error: 'Registration failed', data: null }
//               }
//             })
//           } else {
//             const errPayload: AuthErrorState = {
//               message: error?.message || `Action failed`,
//               code: 500, // responseData.error,
//               // details: responseData.error,
//               error: error?.message || null,
//             }
//             authError.value = errPayload
//             console.log(errPayload)

//             console.log('error')
//             // No need to call clearAuthData here on every auth action failure.
//             // Only clear if the failure implies total invalidation of any prior state (e.g. bad creds on login).
//             // For instance, if a token refresh fails within an action, apiClient should handle logout.
//             // If it's a form validation type error from backend, user might still be "logged in".
//             notificationStore.addNotification('error', errPayload.message)

//             return { success: false, error: errPayload, data: null }
//           }
//         } catch (e: any) {
//           console.error(`AuthStore: Action signUpWithPassword failed`, e)
//           const errPayload: AuthErrorState = {
//             message: e.error || `Action signUpWithPassword failed`,
//             code: e.error,
//             // details: responseData.error,
//             error: e.error,
//           }
//           return { success: false, error: errPayload, data: null }
//         } finally {
//           isLoading.value = false
//           isBusy.value = false
//         }
//       isBusy.value = false
//       return { success: false, error: 'Registration failed', data: null }
//     }

//     async function signInWithGoogleIdToken(idToken: string) {
//       // Google Sign-In might have a slightly different response structure initially,
//       // ensure api.auth.signInWithGoogle standardizes it or adapt here.
//       // The original code had `responseData.accessToken` etc., implying it does.
//       isLoading.value = true
//       authError.value = null
//       try {
//         const googleSignInPayload: GoogleSignInDto = { idToken }
//         const responseData = await api.auth.signInWithGoogle(googleSignInPayload)
//         setGoogleAuthData(responseData) // Assuming signInWithGoogle returns AuthResponseDto
//         return { success: true, data: responseData }
//       } catch (e: any) {
//         console.error('AuthStore: Google Sign-in failed', e)
//         authError.value = {
//           message: e.message || 'Google Sign-in failed',
//           code: e.code,
//           error: e.error || null,
//           details: e.details,
//         }
//         // clearAuthData(); // Potentially, if Google Sign-In implies no prior valid session
//         return { success: false, error: e as ApiError | AuthErrorState }
//       } finally {
//         isLoading.value = false
//       }
//     }

//     async function logoutUser(navigate = true) {
//       console.log('logoutu called')
//       // Renamed to logoutUser to avoid conflict with Vue's internal logout name if this were a component.
//       isLoading.value = true // Set loading state for logout process
//       const tokenToInvalidate = refreshToken.value

//       // Clear local auth data immediately
//       clearAuthData()

//       try {
//         if (tokenToInvalidate) {
//           await api.auth.logout({ refreshToken: tokenToInvalidate } as RefreshTokenDto)
//         }
//       } catch (e: any) {
//         // Log API error but don't let it stop the local logout process.
//         // The token might have already been invalid on the server.
//         console.warn('AuthStore: Server-side logout call failed:', e.message)
//       } finally {
//         isLoading.value = false
//         authError.value = null // Clear any auth errors on logout
//         initialAuthCheckComplete.value = true // Logout means the auth check is "complete" - user is not auth'd

//         // if (navigate) {
//         router.push('/login') // Or your desired logout destination
//         // }
//       }
//     }

//     // Manual error management if needed from outside
//     function setAuthError(newError: AuthErrorState | null) {
//       authError.value = newError
//     }
//     function clearAuthError() {
//       authError.value = null
//     }
//     function setAuthModalType(type: string | null) {
//       authModalType.value = type
//     }
//     function setAuthDialogVisible(visible: boolean) {
//       authDialogVisible.value = visible
//     }

//     // Watchers for localStorage are removed as pinia-plugin-persistedstate should handle this.
//     // If persist:true is not using a plugin, then the watchers are needed,
//     // but it's highly recommended to use the plugin.

//     return {
//       // State
//       accessToken,
//       refreshToken,
//       currentUser,
//       isLoading,
//       error: authError,
//       initialAuthCheckComplete,
//       authDialogVisible,
//       // Getters
//       isAuthenticated,
//       userAvatar,

//       // Actions
//       initializeAuth, // Renamed for clarity
//       fetchCurrentUser, // Renamed from refreshUser
//       fetchCurrentSession,
//       signInWithPassword,
//       signUpNewUser,
//       signInWithGoogleIdToken,
//       logout: logoutUser, // Expose as 'logout'
//       setAuthData, // Crucial for apiClient integration
//       clearAuthData, // Useful for apiClient or manual reset
//       setAuthError,
//       clearAuthError,
//       setAuthModalType,
//       setAuthDialogVisible,
//       isSignUpMode,
//       toggleSignUp,
//     }
//   },
//   {
//     // Configuration for pinia-plugin-persistedstate
//     // This tells the plugin to persist these specific state properties.
//     persist: {
//       storage: localStorage, // or `sessionStorage` if you prefer
//       // Use 'paths' only if your pinia-plugin-persistedstate version supports it.
//       // If not, remove 'paths' and persist the whole store or upgrade the plugin.
//       // For most recent versions, use 'paths' as below:
//       pick: ['accessToken', 'refreshToken', 'currentUser'],
//       // If you get a type error, remove the 'paths' property:
//     },
//   }
// )

// function createORPCVueColadaUtils(client: any) {
//   throw new Error('Function not implemented.')
// }
// // Helper type for external use if needed (though ApiError from types is better)
// // export type { AuthErrorState, ApiError };
// // export function useAuthStoreOutside() {
// //   console.log(store)
// //   return useAuthStore(store)
// // }
