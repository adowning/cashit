import 'dotenv/config'
import { RPCHandler } from '@orpc/server/fetch'
import { createContext, createWsContext } from './lib/context'
import { appRouter } from './routers/index'
import { AppWsData, WebSocketRouter } from './routers/socket.router'
import { auth } from './lib/auth'
import { Context, Hono, type ExecutionContext } from 'hono'
import { cors } from 'hono/cors'
import { logger } from 'hono/logger'

const app = new Hono()

app.use(logger())
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

const resthandler = new RPCHandler(appRouter)
app.use('/rpc/*', async (c, next) => {
  const context = await createContext({ context: c })
  const { matched, response } = await resthandler.handle(c.req.raw, {
    prefix: '/rpc',
    context: context,
  })
  if (matched) {
    return c.newResponse(response.body, response)
  }
  await next()
})

// app.get('/', (c) => {
//   return c.text('OK')
// })

export default app
// import { experimental_RPCHandler } from '@orpc/server/bun-ws'
// import type { Server } from 'bun'

// const wsHandler = new experimental_RPCHandler(appRouter)

// async function handleWsUpgrade(req: Request, server: Server): Promise<Response> {
//   let clientAuthToken: string | null = null
//   const parsedUrl = new URL(req.url)
//   clientAuthToken = parsedUrl.searchParams.get('token')
//   const key = parsedUrl.searchParams.get('data')
//   if (!clientAuthToken) {
//     return new Response('Unauthorized: Authentication token required.', {
//       status: 401,
//     })
//   }
//   req.headers.set('Authorization', clientAuthToken)

//   try {
//     const authSession = await auth.api.getSession({
//       headers: req.headers,
//     })
//     const session = authSession
//     if (!authSession || !session || !session.user.id) {
//       return new Response('Unauthorized: Invalid session.', {
//         status: 401,
//       })
//     }
//     const upgradeResponse = wsRouter.upgrade({
//       server,
//       request: req,
//       data: { session: session, key },
//     })
//     // The following 'instanceof' check (TS2358) and the subsequent return (TS2322)
//     // have been persistently flagged by TypeScript in your environment.
//     // The (value as unknown) instanceof Constructor pattern is a standard workaround for TS2358.
//     // Adding 'as Response' to the return is a final attempt to satisfy TS2322.
//     // If these errors continue, they strongly indicate a tooling or environment-specific issue.
//     if (upgradeResponse && (upgradeResponse as unknown) instanceof Response) {
//       return new Response(upgradeResponse) //as unknown as Response // Explicit cast added
//     }
//     return new Response(null, { status: 101 })
//   } catch (error: any) {
//     if (error?.message === 'AUTH_INVALID_SESSION_ID') {
//       return new Response('Unauthorized: Invalid session.', {
//         status: 401,
//       })
//     }
//     console.error('[handleWsUpgrade Error]', error)
//     return new Response('Internal Server Error during upgrade.', {
//       status: 500,
//     })
//   }
// }

// // Declare serverInstance with the correct type first
// let serverInstance: Bun.Server
// const wsRouter = new WebSocketRouter<AppWsData>()

// serverInstance = Bun.serve<AppWsData, {}>({
//   fetch(req, server) {
//     console.log('Incoming request URL:', req.url)
//     const requestPath = new URL(req.url).pathname
//     console.log(requestPath)
//     // // Handle WebSocket upgrades first
//     if (requestPath.startsWith('/ws')) {
//       return handleWsUpgrade(req, server)
//     }
//     // if (requestPath.startsWith('/api')) {
//     //   return app.fetch(req, { server }, {} as ExecutionContext)
//     // }
//     // // // Handle RPC requests through Hono app
//     // if (requestPath.startsWith('/rpc')) {
//     //   console.log('here')
//     //   return app.fetch(req, { server }, {} as ExecutionContext)
//     // }
//     return app.fetch(req, { server }, {} as ExecutionContext)
//     // Add a default response for other routes to prevent recursion
//     return new Response('Not Found', {
//       status: 404,
//       headers: {
//         'Content-Type': 'text/plain',
//       },
//     })
//     // return new Response('Upgrade failed', { status: 500 })
//   },
//   websocket: {
//     async message(ws, message) {
//       // Create a mock HonoContext for WebSocket messages, or refactor createContext to handle this case
//       // Here, we create a minimal mock context with required properties
//       const mockContext = {
//         req: new Request('http://localhost/'),
//         env: {},
//         finalized: false,
//         error: undefined,
//         get: () => undefined,
//         set: () => {},
//         header: () => undefined,
//         status: () => 200,
//         text: (t: string) => new Response(t),
//         json: (j: any) =>
//           new Response(JSON.stringify(j), { headers: { 'Content-Type': 'application/json' } }),
//         // Add other required properties/methods as needed
//       } as any

//       // const context = await createWsContext({ context: ws.data })
//       // const context = await createContext({
//       //   context: {
//       //     ...ws.data,
//       //     env: process.env,
//       //     finalized: false,
//       //     error: undefined,
//       //     req: new Request('http://localhost/'),
//       //     header: () => undefined,
//       //     status: () => ({ json: () => {} }),
//       //     json: (data: any) => new Response(JSON.stringify(data)),
//       //   } as Context & AppWsData,
//       // })
//       wsHandler.message(ws, message, mockContext)
//     },
//     close(ws) {
//       wsHandler.close(ws)
//     },
//   },
// })

// export default serverInstance

// // import 'dotenv/config'
// // import { RPCHandler } from '@orpc/server/fetch'
// // import { createContext } from './lib/context'
// // import { appRouter } from './routers/index'
// // import { auth } from './lib/auth'
// // import { Hono } from 'hono'
// // import { cors } from 'hono/cors'
// // import { logger } from 'hono/logger'

// // const app = new Hono()

// // app.use(logger())
// // app.use(
// //   '/*',
// //   cors({
// //     origin: process.env.CORS_ORIGIN || '',
// //     allowMethods: ['GET', 'POST', 'OPTIONS'],
// //     allowHeaders: ['Content-Type', 'Authorization'],
// //     credentials: true,
// //   })
// // )

// // app.on(['POST', 'GET'], '/api/auth/**', (c) => auth.handler(c.req.raw))

// // const handler = new RPCHandler(appRouter)
// // app.use('/rpc/*', async (c, next) => {
// //   const context = await createContext({ context: c })
// //   const { matched, response } = await handler.handle(c.req.raw, {
// //     prefix: '/rpc',
// //     context: context,
// //   })
// //   if (matched) {
// //     return c.newResponse(response.body, response)
// //   }
// //   await next()
// // })

// // app.get('/', (c) => {
// //   return c.text('OK')
// // })

// export default app
