// import type { Context as HonoContext } from 'hono'
import { Session } from 'better-auth'
import { BunRequest, ServerWebSocket } from 'bun'
import { UserProfile } from '@/types'
import { auth } from './auth'
// import { AppWsData } from '@/types'
// import { UserProfile } from 'prisma/index.js'
// import { Session } from 'better-auth'
// import { BunRequest, ServerWebSocket } from 'bun'

// export type CreateContextOptions = {
//   context: HonoContext
// }
// export type CreateWsContextOptions = {
//   context: AppWsData
// }
export type CreateMyContextOptions = {
  context: {
    req: Request
    res?: Response
    ws?: ServerWebSocket
    user?: UserProfile
    token?: string // Automatically added by the router
    key?: string // Generic key, purpose defined by handler (e.g. client's original 'data' param)
    session?: Session
    // [key: string]?: unknown // A
  }
}
export type CreateMyWsContextOptions = {
  context: {
    req: BunRequest
    res: Response
    ws?: ServerWebSocket
    user: UserProfile
    clientId: string // Automatically added by the router
    userId?: string // Made optional for flexibility (e.g. proxy before auth)
    key?: string // Generic key, purpose defined by handler (e.g. client's original 'data' param)
    currentRoomId?: string
    [key: string]: unknown // A
    username?: string
    token: string
    isNoLimitProxy?: boolean
    nolimitSessionKey?: string
    nolimitRemoteWs?: WebSocket
    nolimitMessageCounter?: number
    nolimitRememberedData?: { extPlayerKey?: string }
    nolimitGameCodeString?: string
    nolimitClientString?: string
    nolimitLanguage?: string
    nolimitToken?: string
    subscribedTournamentTopics?: Set<string>
    mode?: string
    gameCodeString?: string
    kaToken?: string
    gameId?: string
    isKaGamingProxy?: boolean
    session: Session
  }
}

export async function createContext({ context }: CreateMyContextOptions) {
  const session = await auth.api.getSession({
    headers: context.req.headers,
  })
  return { ...context, session }
}
// export async function createWsContext({ context }: CreateWsContextOptions) {
//   const session = await auth.api.getSession({
//     headers: new Headers({ Authorization: context.token }),
//   })
//   return {
//     session,
//   }
// }

export type Context = Awaited<ReturnType<typeof createContext>>
