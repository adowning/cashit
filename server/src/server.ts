import { Hono } from 'hono'
import { appRouter, socketRouter, WebSocketRouter } from './routers/index'
import { auth } from './lib/auth'
import { cors } from 'hono/cors'
import { RPCHandler } from '@orpc/server/fetch'
import { createContext } from './lib/context'
import {
  kagamingProxyOpenHandler,
  kagamingProxyCloseHandler,
} from './handlers/kagaming-proxy.handler'
import { nolimitProxyOpenHandler, nolimitProxyCloseHandler } from './handlers/nolimit-proxy.handler'
import { setupTournamentWebSocketListeners } from './handlers/tournament.handler'
import * as tournamentService from './services/tournament.service'
import { RealtimeService } from './services/realtime.service' // Adjust path
import { PgRealtimeClientOptions } from './lib/utils'
import { AppWsData } from 'shared'
import prisma from 'prisma'
import uid from 'short-uuid'
import { Scalar } from '@scalar/hono-api-reference'

// Define the user type based on your authSession.user structure
type User = {
  id: string
  clientId: string
  name: string
  updatedAt: Date
  image?: string | null
  username?: string | null
  displayUsername?: string | null
}
const resthandler = new RPCHandler(appRouter)

const app = new Hono()
// app.use(logger())
app.get('/scalar', Scalar({ url: '/doc' }))

app.use(
  '/*',
  cors({
    origin: 'http://localhost:3001', // || '',
    allowMethods: ['GET', 'POST', 'OPTIONS'],
    allowHeaders: ['Content-Type', 'Authorization'],
    credentials: true,
  })
)
app.on(['POST', 'GET'], '/api/auth/**', (c) => auth.handler(c.req.raw))

app.use('/rpc/*', async (c, next) => {
  const context = await createContext({ context: c })
  const authSession = await auth.api.getSession({
    headers: c.req.raw.headers,
  })
  context.session = authSession
  console.log('session ', context.session)
  if (context.session === null) return c.json({ error: 'Unauthorized' }, 401)
  const { matched, response } = await resthandler.handle(c.req.raw, {
    prefix: '/rpc',
    //@ts-ignore
    context: context, // Ensure context is never null
  })
  console.log('matched', matched)
  if (matched) {
    console.log('response', response)

    return c.newResponse(response.body, response)
  }
  await next()
})
app.get('/', (c) => c.text('Welcome to Hono!'))
// const sockethandler = new experimental_RPCHandler(socketRouter)

// WebSocket router
const ws = new WebSocketRouter<AppWsData>()
// ws.addRoutes() // Add routes from another file

const serverInstance = Bun.serve<AppWsData, {}>({
  port: 3000,

  async fetch(req, server) {
    const parsedUrl = new URL(req.url)

    if (parsedUrl.pathname.startsWith('/rpc')) {
      const authSession = await auth.api.getSession({
        headers: req.headers,
      })
      let user
      if (authSession != null) user = authSession.user
      const res = await app.fetch(req, {
        prefix: '/rpc',
        context: authSession,
      })
      // Ensure always returning a Response
      return res instanceof Response ? res : new Response(String(res))
    }
    // Handle WebSocket upgrade requests
    if (parsedUrl.pathname === '/') {
      const clientAuthToken = parsedUrl.searchParams.get('token')
      if (clientAuthToken != null) req.headers.set('Authorization', clientAuthToken)
      const authSession = await auth.api.getSession({
        headers: req.headers,
      })
      let user
      if (authSession != null) user = authSession.user
      const clientId = uid()

      if (user !== undefined) {
        user = await prisma.userProfile.findUnique({
          where: { id: user.id },
        })
        if (user !== null) {
          console.log(user)
          // const u = { ...user,  }
          const wsUpgrade = ws.upgrade({
            server,
            request: req,
            data: {
              user,
              token: clientAuthToken as string,
              username: user.username,
              isNoLimitProxy: false,
              isKaGamingProxy: false,
              clientId,
            },
          })
          console.log(wsUpgrade)
          // ws.upgrade may return undefined/null, so ensure Response
          if (wsUpgrade && typeof wsUpgrade === 'object' && (wsUpgrade as any) instanceof Response)
            return wsUpgrade
          return new Response('WebSocket upgrade failed', { status: 400 })
        }
      }
    }
    const authSession = await auth.api.getSession({
      headers: req.headers,
    })
    let user
    if (authSession != null) user = authSession.user
    const res = await app.fetch(req, { server, user })
    return res instanceof Response ? res : new Response(String(res))
  },

  // Handle WebSocket connections
  websocket: ws.websocket,
})
ws.setServer(serverInstance)
const pgOptions: PgRealtimeClientOptions = {
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || 'password',
  host: process.env.DB_HOST || '127.0.0.1',
  port: process.env.DB_PORT ? parseInt(process.env.DB_PORT, 10) : 5432,
  database: process.env.DB_NAME || 'testapp',
  channel: process.env.DB_LISTEN_CHANNEL || 'spec_data_change',
  onError: (error: Error) => console.error('[DB Listener Error]', error),
}
const realtimeService = new RealtimeService(pgOptions)
realtimeService.setServer(serverInstance)
realtimeService.startListening().catch((err) => {
  console.error('[Server] FATAL: Failed to start RealtimeService listening, exiting.', err)
  serverInstance.stop(true)
  process.exit(1)
})
setupTournamentWebSocketListeners(serverInstance)
tournamentService.initTournamentScheduler()
ws.addOpenHandler(nolimitProxyOpenHandler)
ws.addOpenHandler(kagamingProxyOpenHandler)
ws.addCloseHandler(nolimitProxyCloseHandler)
ws.addCloseHandler(kagamingProxyCloseHandler)
console.log(`WebSocket server listening on ws://localhost:3000/`)
