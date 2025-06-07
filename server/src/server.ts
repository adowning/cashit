// Core Framework Imports
import { Scalar } from '@scalar/hono-api-reference'
import { Hono } from 'hono'

// Middleware Imports
import { serveStatic } from 'hono/bun'
import { cors } from 'hono/cors'
import { logger } from 'hono/logger'

// RPC and WebSocket Imports
// import { RPCHandler } from '@orpc/server/fetch'
import { WebSocketRouter } from './routers/index'

// Authentication Imports
import { auth } from './lib/auth'

// Context and Services
import { createContext } from './lib/context'
import { RealtimeService } from './services/realtime.service'

// Router Imports
import performanceRoutes from '@/routers/performance.routes'
import { RtgApi } from '@/routers/rtg.routes'
import { appRouter } from './routers/index'

// Handler Imports
import {
  kagamingProxyCloseHandler,
  kagamingProxyOpenHandler,
  nolimitProxyCloseHandler,
  nolimitProxyOpenHandler,
} from './handlers/index'
import { setupTournamentWebSocketListeners } from './handlers/tournament.handler'
// import {
//   initializeGlobalEventListeners,
//   userEventsOpenHandler,
// } from '@/handlers/user-events.handler'

// Services and Utilities
import { jackpotJobs } from '@/jobs/jackpot.jobs'
import { OpenAPIHandler } from '@orpc/openapi/fetch'
import { ZodSmartCoercionPlugin } from '@orpc/zod'
import { AppWsData, HonoEnv } from 'shared'
import {
  initializeGlobalEventListeners,
  userEventsOpenHandler,
} from './handlers/php-slots.handler.js'
import { PgRealtimeClientOptions } from './services/dbupdates/types.js'
import { initTournamentScheduler } from './services/tournament.service.js'
// File System Imports
// const path = require('path')
// const { readFileSync } = require('fs')
// const ejs = require('ejs')
// const resthandler = new OpenAPIHandler(appRouter)
const resthandler = new OpenAPIHandler(appRouter, {
  plugins: [new ZodSmartCoercionPlugin()],
})
// const resthandler = new RPCHandler(appRouter)

const app = new Hono<HonoEnv>()
app.use(logger())
app.get('/scalar', Scalar({ url: '/doc' }))
const rtgApi = new RtgApi(app)
console.log(rtgApi)
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
app.all('/api/auth/*', async (c) => {
  const response = await auth.handler(c.req.raw)
  return response
})

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
app.get('/nolimit/*', serveStatic({ root: './public' }))
app.use('/games/*', serveStatic({ root: './public' }))
app.use('/games/:game', serveStatic({ root: './public/' }))
app.use('/game', serveStatic({ root: './public', path: '/games' }))
// app.use(
//   '/game/:game/server',
//   serveStatic(() => phpHandler())
// )
// app.get('/:gameName.html', serveStatic({ root: './public' }))
app.get('/launcher', serveStatic({ root: './public', path: '/index.html' }))

// Function to render EJS templates
// function renderTemplate(templateName, data = {}) {
//   const templatePath = path.join(__dirname, '../public/views/gs2c', `${templateName}.ejs`)
//   const template = readFileSync(templatePath, 'utf-8')
//   return ejs.render(template, data)
// }

// WebSocket router
const ws = new WebSocketRouter<AppWsData>()
// ws.addRoutes() // Add routes from another file

const serverInstance = Bun.serve<AppWsData, {}>({
  port: 3000,
  async fetch(req: Request, server) {
    const parsedUrl = new URL(req.url)
    switch (parsedUrl.pathname) {
      case '/slots':
        ws.data.isphpProxy = true
        break
      case '/nolimit':
        ws.data.isNoLimitProxy = true
        break
      case '/kagaming':
        ws.data.isKaGamingProxy = true
        break
      default:
        let token
        // let gameName

        if (parsedUrl.pathname.startsWith('/rtg')) {
          const platformSplit = parsedUrl.pathname.split('platform/')
          if (platformSplit.length > 1 && platformSplit[1]) {
            const gameSplit = platformSplit[1].split('/game')
            if (gameSplit.length > 0) {
              token = gameSplit[0]
              // If you want to extract gameName from somewhere else, add logic here
            }
          }
        }
        if (token) req.headers.set('Authorization', token)
        // let user

        const authSession = await auth.api.getSession({
          headers: req.headers,
        })
        // user = authSession
        // if (authSession != null) user = authSession.user
        let result
        if (parsedUrl.pathname.startsWith('/rpc')) {
          if (authSession !== null) {
            result = await resthandler.handle(req, {
              prefix: '/rpc',
              context: await createContext({
                context: {
                  session: authSession.session,
                  req,
                },
              }),
            })
          }
          if (
            result &&
            typeof result === 'object' &&
            'matched' in result &&
            result.matched &&
            result.response instanceof Response
          ) {
            return result.response
          }
          // If not matched, fall through to app.fetch
        }

        return await app.fetch(req, {
          context: authSession,
        })
        break
    }

    const token = parsedUrl.searchParams.get('token')
    if (token != null) req.headers.set('Authorization', token)
    const authSession = await auth.api.getSession({
      headers: req.headers,
    })
    let user
    let wsUpgrade
    if (authSession != null) user = authSession.user
    if (authSession === null || authSession.session === undefined)
      if (user)
        wsUpgrade = ws.upgrade({
          server,
          request: req,
          data: {
            user,
            token: token as string,
            username: user.username,
            clientId: Math.random().toString(36),
          },
        })
    console.log(wsUpgrade)
    if (wsUpgrade && typeof wsUpgrade === 'object' && (wsUpgrade as any) instanceof Response)
      return wsUpgrade
    return new Response('Not Found', { status: 404 })
  },
  websocket: ws.websocket,
})
ws.setServer(serverInstance)
const pgOptions: PgRealtimeClientOptions = {
  user: process.env['DB_USER'] || 'postgres.acqrudqzutnwrvmvlshc',
  password: process.env['DB_PASSWORD'] || 'acqrudqzutnwrvmvlshc',
  host: process.env['DB_HOST'] || 'aws-0-us-east-2.pooler.supabase.com',
  port: process.env['DB_PORT'] ? parseInt(process.env['DB_PORT'], 10) : 6543,
  database: process.env['DB_NAME'] || 'postgres',
  channel: process.env['DB_LISTEN_CHANNEL'] || 'spec_data_change',
  onError: (error: Error) => console.error('[DB Listener Error]', error),
}

async function main() {
  console.log('Starting server...')
  const realtimeService = new RealtimeService(pgOptions)
  realtimeService.setServer(serverInstance)
  realtimeService.startListening().catch((err) => {
    console.error('[Server] FATAL: Failed to start RealtimeService listening, exiting.', err)
    serverInstance.stop(true)
    process.exit(1)
  })
  setupTournamentWebSocketListeners(serverInstance)
  initTournamentScheduler()
  initializeGlobalEventListeners(serverInstance)
  // initializeLaravelConnector(serverInstance)
  ws.addOpenHandler(nolimitProxyOpenHandler)
  ws.addOpenHandler(userEventsOpenHandler)
  // ws.addOpenHandler(nolimitProxyOpenHandler)
  ws.addOpenHandler(kagamingProxyOpenHandler)
  ws.addCloseHandler(nolimitProxyCloseHandler)
  ws.addCloseHandler(kagamingProxyCloseHandler)
  await jackpotJobs.startJobs()
  // await cashAppWatcherJobs.startJobs() // Start the new CashApp watcher
  console.log(`WebSocket server listening on ws://localhost:3000/`)
}
main()
process.on('SIGINT', async () => {
  console.log('Gracefully shutting down server...')
  // cashAppWatcherJobs.stopJobs()
  jackpotJobs.stopJobs() // [cite: uploaded:jackpot.jobs.ts]
  console.log('Server shut down.')
  process.exit(0)
})

//     // Handle WebSocket upgrade requests

//     const clientAuthToken = parsedUrl.searchParams.get('token')
//     if(clientAuthToken != null) req.headers.set('Authorization', clientAuthToken)
// const authSession = await auth.api.getSession({
//   headers: req.headers,
// })
// let user
// if (authSession != null) user = authSession.user
// const clientId = uid()

// if (user !== undefined) {
//   user = await prisma.userProfile.findUnique({
//     where: { id: user.id },
//   })
//   if (user !== null) {
//     console.log(user)
//     const wsUpgrade = ws.upgrade({
//       server,
//       request: req,
//       data: {
//         user,
//         token: clientAuthToken as string,
//         username: user.username,
//         clientId,
//       },
//     })
//     console.log(wsUpgrade)
//     if (wsUpgrade && typeof wsUpgrade === 'object' && (wsUpgrade as any) instanceof Response)
//       return wsUpgrade
//     return new Response('WebSocket upgrade failed', { status: 400 })
//   }
// }
// const authSession = await auth.api.getSession({
//   headers: req.headers,
// })
// let user
// if (authSession != null) user = authSession.user
// const res = await app.fetch(req, { server, user })
// return res instanceof Response ? res : new Response(String(res))
// }
// Handle WebSocket after upgrade (socket router)

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
// if (parsedUrl.pathname.startsWith('/game')) {
//   const html = renderTemplate('index', {
//     status: 200,
//     title: 'Pragmatic Play',
//     currency: 'KRW',
//     lang: 'en',
//     gameName: 'vs243mwarrior',
//     token: 'asdfasdf',
//     serviceApi: 'http://localhost:3000/rpc',
//     gameHost: 'http://localhost:3000',
//     replayHost: 'http://localhost:3000',
//     resourceName: 'http://localhost:3000',
//   })
//   return new Response(html, {
//     status: 200,
//     headers: { 'Content-Type': 'text/html' },
//   })
// }
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
// const sockethandler = new experimental_RPCHandler(socketRouter)
// function serveStatic() {
//   const relativePath = c.req.path.startsWith('/') ? c.req.path.slice(1) : c.req.path
//   console.log(relativePath)
//   const filePath = path.join(__dirname, '../public', relativePath)

//   try {
//     const fileRef = Bun.file(filePath)

//     // If favicon is not found, return a default response
//     if (relativePath === 'favicon.ico') {
//       return new Response(null, { status: 204 }) // No content
//     }

//     return new Response(fileRef)
//   } catch (error) {
//     // Handle other static file errors
//     const html = renderTemplate('error', { status: 404, message: 'File Not Found' })
//     return new Response(html, {
//       status: 404,
//       headers: { 'Content-Type': 'text/html' },
//     })
//   }
// }
