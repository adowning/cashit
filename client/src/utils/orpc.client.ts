import { createORPCClient } from '@orpc/client'
// import { getContractRouter } from '@orpc/contract'
import { RPCLink } from '@orpc/client/fetch'
import { RouterClient } from '@orpc/server'
// import { ContractRouterClient } from '@orpc/contract'
import type { appRouter as appRouterType } from '../../../server/src/routers/index'
import { appRouter } from '../../../server/src/routers/index'
import { experimental_RPCLink as SocketRPCLink } from '@orpc/client/websocket'
import { WebSocket } from 'partysocket'
import { createORPCVueQueryUtils } from '@orpc/vue-query'
import { createORPCVueColadaUtils } from '@orpc/vue-colada'
import destr from 'destr'
export class OrpcManager {
  // private static instance: Orpc
  static isInitialized = false
  private token: string | null = null
  constructor() {}
  // public static getInstance(): Orpc {
  //   if (!Orpc.instance) {
  //     Orpc.instance = new Orpc()
  //   }
  //   return Orpc.instance
  // }

  public setToken(token: string) {
    // const authStore = useAuthStore()
    // console.log('Setting token:', token)
    if (token == undefined) {
      throw new Error('No access token found. Please log in.')
    }
    this.token = token

    return this.token
  }
  private getToken() {
    // const authStore = useAuthStore()
    let token = this.token
    if (token == null || token == undefined) {
      token = localStorage.getItem('auth')
      if (token !== null) {
        let jtoken = JSON.parse(token)
        token = jtoken?.accessToken
      }
    }
    // console.log('getting token:', token)
    if (token == undefined || token === null) {
      throw new Error('No access token found. Please log in.')
    }
    this.token = token
    console.log('Token get:', this.token)
    return this.token
  }
  getClients = () => {
    // const token = this.getToken()
    return this.restClient
  }
  getRestClient = () => {
    // const token = this.getToken()
    return this.restClient
  }
  // getRealtimeClient = () => {
  //   return this.clientB
  // }

  getColadaClient = () => {
    // const authStore = useAuthStore()
    // const token = authStore.accessToken
    // if (!token) {
    //   throw new Error('No access token found. Please log in.')
    // }
    return this.orpcColadaClient
  }
  private link = new RPCLink({
    url: 'http://localhost:3000/rpc',
    headers: () => ({
      authorization: `Bearer ${this.getToken()}`,
    }),
    // fetch: <-- provide fetch polyfill fetch if needed
  })

  // Create a client for your router
  // Or, create a client using a contract
  // export const contractClient: ContractRouterClient<typeof contract> = createORPCClient(link)
  //
  private orpcClient: RouterClient<typeof appRouterType> = createORPCClient(this.link)
  //   const contractClient: ContractRouterClient<typeof appRouterType> = getContractRouter(appRouter, ['/rpc'])
  // export const orpcUtils = createORPCVueQueryUtils(client)
  //  export const contractOrpcUtils = createORPCVueQueryUtils(contractClient)
  // private websocket = new WebSocket(`ws://localhost:3000?token=${this.getToken()}`)

  // private socketLink = new SocketRPCLink({
  //   websocket: this.websocket,
  // })

  // Create a client for your router
  // private socketClient: RouterClient<typeof appRouter> = createORPCClient(this.socketLink)

  // Or, create a client using a contract
  // export const contractSocketClient: ContractRouterClient<typeof contract> =
  // public createORPCClient = createORPCClient(this.socketLink)
  private vueQueryClient = createORPCVueQueryUtils(this.orpcClient)
  private orpcColadaClient = createORPCVueColadaUtils(this.orpcClient)

  public restClient: RouterClient<typeof appRouter> = this.orpcClient
  // private clientB: RouterClient<typeof appRouter> = this.socketClient

  // public client = {
  //   restClient: this.clientA,
  //   // realtimeClient: this.clientB,
  // }
}
export const orpcManager = new OrpcManager()
// export const orpc = orpcManager.getClient()
