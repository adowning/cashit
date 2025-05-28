import { createAuthClient } from 'better-auth/vue'
import { usernameClient } from 'better-auth/client/plugins'

// export const authClient = createAuthClient({
//   baseURL: 'http://localhost:3000', // The base URL of your auth server
// })

export const authClient = createAuthClient({
  baseURL: 'http://localhost:3000', // The base URL of your auth server

  plugins: [usernameClient()],
})

export const useAuthClient = () => {
  return authClient
}
