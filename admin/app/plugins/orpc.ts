import { defineNuxtPlugin, useRuntimeConfig } from '#app'
import type { RouterClient } from '@orpc/server'
import type { appRouter } from '../../../server/src/routers/index'
import { createORPCClient } from '@orpc/client'
import { RPCLink } from '@orpc/client/fetch'
import { createORPCVueQueryUtils } from '@orpc/vue-query'

export default defineNuxtPlugin((): ORPCVueQueryUtils => {
  const config = useRuntimeConfig()
  const serverUrl = config.public.serverURL

  const rpcUrl = `${serverUrl}/rpc`

  const rpcLink = new RPCLink({
    url: rpcUrl,
    fetch(url, options) {
      return fetch(url, {
        ...options,
        credentials: 'include',
      })
    },
  })

  const client: RouterClient<typeof appRouter> = createORPCClient(rpcLink)
  const orpc = createORPCVueQueryUtils(client)

  return {
    provide: {
      orpc,
    },
  }
})
