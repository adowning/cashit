import type { Context as HonoContext } from 'hono'
import { auth } from './auth'
import { AppWsData } from 'shared'

export type CreateContextOptions = {
  context: HonoContext
}
export type CreateWsContextOptions = {
  context: AppWsData
}

export async function createContext({ context }: CreateContextOptions) {
  const session = await auth.api.getSession({
    headers: context.req.raw.headers,
  })
  return {
    session,
  }
}
export async function createWsContext({ context }: CreateWsContextOptions) {
  const session = await auth.api.getSession({
    headers: new Headers({ Authorization: context.token }),
  })
  return {
    session,
  }
}

export type Context = Awaited<ReturnType<typeof createContext>>
