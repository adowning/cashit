// import { useAuthStore } from '@/stores/auth.store'
// import { useUserStore } from '@/stores/user.store'
// // import { ApiAuthError } from 'shared/dist'
// import { logToPage } from './logger'

// export async function fetchApi(endpoint: string, options: RequestInit = {}): Promise<any> {
//   const authStore = useAuthStore()
//   authStore.isLoading = true
//   authStore.error = null
//   console.log(endpoint)
//   const completeUrl = endpoint.startsWith('http') ? endpoint : `${endpoint}` // Assuming /api prefix for Hono
//   logToPage('debug', `WorkspaceApi: Calling ${options.method || 'GET'} ${completeUrl}`)

//   try {
//     const token = authStore.accessToken
//     const headers = new Headers(options.headers || {})
//     if (token && !headers.has('Authorization')) {
//       headers.set('Authorization', `Bearer ${token}`)
//     }
//     if (!options.body || (options.body && !(options.body instanceof FormData))) {
//       if (!headers.has('Content-Type')) headers.set('Content-Type', 'application/json')
//     }
//     options.method = 'POST'
//     const response = await fetch(completeUrl, { ...options, headers })

//     if (!response.ok) {
//       let errorData = {
//         message: `HTTP error! Status: ${response.status} ${response.statusText}`,
//         code: response.status,
//         details: null,
//         error: response.statusText,
//       }
//       try {
//         const jsonError = await response.json()
//         errorData = { ...errorData, ...jsonError } // Merge server error message if available
//       } catch (e) {
//         /* Ignore if response is not JSON */
//       }
//       logToPage('error', `WorkspaceApi: Error on ${completeUrl}:`, errorData)
//       authStore.error = errorData
//       throw errorData
//     }

//     if (response.status === 204) {
//       // No Content
//       logToPage('debug', `WorkspaceApi: Received 204 No Content from ${completeUrl}`)
//       return null
//     }
//     const data = await response.json()
//     logToPage('debug', `WorkspaceApi: Received data from ${completeUrl}`)
//     return data
//   } catch (e: any) {
//     logToPage('error', `WorkspaceApi: Exception during call to ${completeUrl}:`, e)
//     // Ensure error in store is an ApiAuthError
//     if (e.message && e.code) {
//       authStore.error = e
//     } else {
//       authStore.error = {
//         message: e.message || 'Network or unexpected error during API call',
//       }
//     }
//     throw e // Re-throw for the calling function to handle
//   } finally {
//     authStore.isLoading = false
//   }
// }
