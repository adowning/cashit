// import { ORPCError, os } from '@orpc/server'
// import type { Context } from './context'

// export const o = os.$context<Context>()

// export const publicProcedure = o

// const requireAuth = o.middleware(async ({ context, next }) => {
//   if (!context.session?.user) {
//     throw new ORPCError('UNAUTHORIZED')
//   }
//   return next({
//     context: {
//       ...context,
//       session: context.session,
//     },
//   })
// })

// export const protectedProcedure = publicProcedure.use(requireAuth)
// import { ORPCError, os } from '@orpc/server'
// import type { Context } from './context' // Ensure this Context is appropriate

// export const o = os.$context<Context>()

// export const publicProcedure = o

// const requireAuth = o.middleware(async ({ context, next }) => {
//   // Ensure context.session and context.session.user are populated correctly
//   // from the WebSocket connection's authentication step (e.g., token in URL)
//   if (!context.session?.user) {
//     throw new ORPCError('UNAUTHORIZED')
//   }
//   return next({
//     context: {
//       ...context,
//       session: context.session, // contains authenticated user
//     },
//   })
// })

// export const protectedProcedure = publicProcedure.use(requireAuth)

// File: server/src/lib/orpc.ts
import { ORPCError, os } from '@orpc/server'
import { Session } from 'better-auth'
import type { Server, ServerWebSocket } from 'bun'
import type { AppWsData } from 'shared' // Your shared ws.data type from the `shared` package

// Define the comprehensive context ORPC procedures will receive
export interface OrpcContext {
  session:
    | (Session & { user?: { id: string; username?: string; name?: string; [key: string]: any } })
    | null
  req?: Request // Provided by ORPC for HTTP, and for WS during upgrade
  // res?: Response; // Typically not used directly in procedure logic
  // honoContext?: HonoContext; // If you're integrating with Hono and need its context
  server?: Server // Bun server instance, automatically injected by ORPC WS Handler
  ws?: ServerWebSocket<AppWsData> // Bun WebSocket instance, data typed with AppWsData, injected by ORPC WS Handler
}

// Initialize ORPC with the defined context
export const o = os.$context<OrpcContext>()

// Base procedure
// export const publicProcedure = o.procedure; // CORRECTED: Use o.procedure
export const publicProcedure = o
// Middleware for authentication
const requireAuth = o.middleware(async ({ context, next }) => {
  console.log('middleware')
  console.log(context.session)
  if (!context.session?.user?.id) {
    throw new ORPCError('UNAUTHORIZED')
  }
  return next({
    context: {
      ...context,
      // Ensure the session type is narrowed after this middleware
      session: context.session as NonNullable<
        typeof context.session & { user: NonNullable<typeof context.session.user> }
      >,
    },
  })
})

// Protected procedure that requires authentication
export const protectedProcedure = publicProcedure.use(requireAuth)
