import { Hono } from 'hono'
import { appRouter, socketRouter, WebSocketRouter } from './routers/index'
import { auth } from './lib/auth'
import { cors } from 'hono/cors'
import { logger } from 'hono/logger'
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
import { AppWsData, UserProfile } from 'shared'
import prisma from 'prisma'
import uid from 'short-uuid'
import { Scalar } from '@scalar/hono-api-reference'
import { Server } from 'bun'
import { Session } from 'better-auth'
import { jackpotJobs } from '@/jobs/jackpot.jobs'
import { GameAPI } from '@/services/pragmatic/pragmatic.routes'
const path = require('path')
const { readFileSync } = require('fs')
const ejs = require('ejs')
import { RtgApi } from '@/routers/rtg.routes'
import { userEventsOpenHandler } from '@/handlers/user-events.handler'
import performanceRoutes from '@/routers/performance.routes'

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
export type HonoEnv = {
  Bindings: {
    serverInstance?: Server // Make serverInstance known to Hono's Env
  }
  Variables: {
    skipAuthMiddleWare: boolean
    session: Session | null
    user_with_profile: UserProfile | null
    user: any | null
    serverInstance?: Server // Make serverInstance known for c.set/c.get
    gameSymbol: string | null
    mgckey: string | null
    pagination: {
      skip: number
      take: number
    }
  }
}
const app = new Hono()
app.use(logger())
app.get('/scalar', Scalar({ url: '/doc' }))
const gameApi = new GameAPI(app)
const rtgApi = new RtgApi(app)

// Add performance monitoring routes
app.route('/performance', performanceRoutes)

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
// app.use('/rtg/*', async (c, next) => {
//   const context = await createContext({ context: c })
//   const authSession = await auth.api.getSession({
//     headers: c.req.raw.headers,
//   })
//   if (authSession === null || authSession.session === undefined)
//     return c.json({ error: 'Unauthorized' }, 401)
//   context.session = authSession
//   console.log('session id ', context.session.session.id)
//   const { matched, response } = await resthandler.handle(c.req.raw, {
//     prefix: '/rtg',
//     context, // Ensure context is never null
//   })
//   console.log('matched', matched)
//   if (matched) {
//     console.log('response', response)

//     return c.newResponse(response.body, response)
//   }
//   await next()
// })
app.use('/rpc/*', async (c, next) => {
  const context = await createContext({ context: c })
  const authSession = await auth.api.getSession({
    headers: c.req.raw.headers,
  })
  if (authSession === null || authSession.session === undefined)
    return c.json({ error: 'Unauthorized' }, 401)
  context.session = authSession
  console.log('session id ', context.session.session.id)
  const { matched, response } = await resthandler.handle(c.req.raw, {
    prefix: '/rpc',
    context, // Ensure context is never null
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
function serveStatic(urlPath: string) {
  const relativePath = urlPath.startsWith('/') ? urlPath.slice(1) : urlPath
  const filePath = path.join(__dirname, '../public', relativePath)

  try {
    const fileRef = Bun.file(filePath)

    // If favicon is not found, return a default response
    if (relativePath === 'favicon.ico') {
      return new Response(null, { status: 204 }) // No content
    }

    return new Response(fileRef)
  } catch (error) {
    // Handle other static file errors
    const html = renderTemplate('error', { status: 404, message: 'File Not Found' })
    return new Response(html, {
      status: 404,
      headers: { 'Content-Type': 'text/html' },
    })
  }
}

// Function to render EJS templates
function renderTemplate(templateName, data = {}) {
  const templatePath = path.join(__dirname, '../public/views/gs2c', `${templateName}.ejs`)
  const template = readFileSync(templatePath, 'utf-8')
  return ejs.render(template, data)
}

// WebSocket router
const ws = new WebSocketRouter<AppWsData>()
// ws.addRoutes() // Add routes from another file

const serverInstance = Bun.serve<AppWsData, {}>({
  port: 3000,

  async fetch(req, server) {
    const parsedUrl = new URL(req.url)
    // if (req.method === 'POST') {
    //   console.log('posting')
    //   const authSession = await auth.api.getSession({
    //     headers: req.headers,
    //   })
    //   let user
    //   if (authSession != null) user = authSession.user
    //   const res = await app.fetch(req, {
    //     prefix: '/rpc',
    //     context: authSession,
    //   })
    //   // Ensure always returning a Response
    //   return res instanceof Response ? res : new Response(String(res))
    // }
    // if (parsedUrl.pathname.startsWith('/assets')) {
    //   return serveStatic(parsedUrl.pathname)
    // }
    // if (parsedUrl.pathname.startsWith('/gs2c')) {
    //   return serveStatic(parsedUrl.pathname)
    // }
    if (parsedUrl.pathname.startsWith('/game')) {
      const html = renderTemplate('index', {
        status: 200,
        title: 'Pragmatic Play',
        currency: 'KRW',
        lang: 'en',
        gameName: 'vs243mwarrior',
        token: 'asdfasdf',
        serviceApi: 'http://localhost:3000/rpc',
        gameHost: 'http://localhost:3000',
        replayHost: 'http://localhost:3000',
        resourceName: 'http://localhost:3000',
      })
      return new Response(html, {
        status: 200,
        headers: { 'Content-Type': 'text/html' },
      })
    }
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
    // console.log('parsedUrl.pathname', parsedUrl.pathname)
    if (parsedUrl.pathname.startsWith('/rtg')) {
      let token: string | undefined
      let gameName: string | undefined
      const platformSplit = parsedUrl.pathname.split('platform/')
      if (platformSplit.length > 1 && platformSplit[1] !== undefined) {
        const gameSplit = platformSplit[1].split('/game')
        if (gameSplit.length > 0) {
          token = gameSplit[0]?.split('/')[0]
          gameName = gameSplit[0]?.split('/')[1]
        }
      }
      console.log(token)
      if (token != null) req.headers.set('Authorization', token)

      const authSession = await auth.api.getSession({
        headers: req.headers,
      })
      let user
      if (authSession != null) user = authSession.user
      console.log(authSession)
      console.log(parsedUrl.pathname)
      ///rtg/games/rtg/platform/0Fnal8tl5RQwjg2nHZXkeD2jNTBnJiPO/777Strike/game/settings

      const res = await app.fetch(req, {
        prefix: '/rtg',
        context: authSession,
      })
      // Ensure always returning a Response
      return res instanceof Response ? res : new Response(String(res))
    }
    // Handle WebSocket upgrade requests
    if (parsedUrl.pathname === '/') {
      console.log('w t f mate ?')
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
  user: process.env.DB_USER || 'postgres.acqrudqzutnwrvmvlshc',
  password: process.env.DB_PASSWORD || 'acqrudqzutnwrvmvlshc',
  host: process.env.DB_HOST || 'aws-0-us-east-2.pooler.supabase.com',
  port: process.env.DB_PORT ? parseInt(process.env.DB_PORT, 10) : 6543,
  database: process.env.DB_NAME || 'postgres',
  channel: process.env.DB_LISTEN_CHANNEL || 'spec_data_change',
  onError: (error: Error) => console.error('[DB Listener Error]', error),
}
console.log(pgOptions)
const realtimeService = new RealtimeService(pgOptions)
realtimeService.setServer(serverInstance)
realtimeService.startListening().catch((err) => {
  console.error('[Server] FATAL: Failed to start RealtimeService listening, exiting.', err)
  serverInstance.stop(true)
  process.exit(1)
})
async function main() {
  console.log('Starting server...')
  setupTournamentWebSocketListeners(serverInstance)
  tournamentService.initTournamentScheduler()
  ws.addOpenHandler(nolimitProxyOpenHandler)
  // ws.addOpenHandler(userEventsOpenHandler)

  ws.addOpenHandler(kagamingProxyOpenHandler)
  ws.addCloseHandler(nolimitProxyCloseHandler)
  ws.addCloseHandler(kagamingProxyCloseHandler)
  await jackpotJobs.startJobs()
  console.log(`WebSocket server listening on ws://localhost:3000/`)
}
main()
// If you want to use the Bun server instance directly, you can cast it as 'any' or the appropriate type expected by socket.io.
// Alternatively, if you want to use Node's http.Server, you need to create and use it instead of Bun.serve.
// Here, we cast as 'any' to avoid the error, but you should ensure compatibility with socket.io.
// const napp = new Hono()

// const server = serve(
//   {
//     fetch: napp.fetch,
//     hostname: 'localhost',
//     port: 3444,
//   },
//   (info) => {
//     console.log(`Socket.io Server is running: http://${info.address}:${info.port}`)
//   }
// )

// const ioServer = new SocketServer(server as any, {
//   // path: '/socket.io',
//   serveClient: false,
// })
// ioServer.on('error', (err) => {
//   console.log(err)
// })

// ioServer.on('connection', (socket) => {
//   console.log('client connected')
// })

// setInterval(() => {
//   ioServer.emit('hello', 'world')
//   ioServer.emit('hello', 'world')
//   ioServer.emit('hello', 'world')
//   ioServer.emit('hello', 'world')
//   ioServer.emit('hello', 'world')
// }, 1000)
