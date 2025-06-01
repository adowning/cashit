// File: ai/server/src/routers/index.ts
import { protectedProcedure, publicProcedure } from '../lib/orpc'
import { userRouter } from './user.router'
import { vipRouter } from './vip.router'
import { gameRouter } from './game.router'
import { transactionRouter } from './transaction'
import { tournamentRouter } from './tournament.router' // Added import

export { WebSocketRouter } from './socket.router'

export const appRouter = {
  healthCheck: publicProcedure.handler(() => {
    return 'OK'
  }),
  privateData: protectedProcedure.handler(({ context }) => {
    return {
      message: 'This is private',
      // user: context.session?.user,
    }
  }),
  user: userRouter,
  vip: vipRouter,
  transaction: transactionRouter,
  tournament: tournamentRouter, // Added tournament router
  game: gameRouter, // Added tournament router
}
export type AppRouter = typeof appRouter

// Assuming socketRouter mirrors appRouter for now
export const socketRouter = {
  healthCheck: publicProcedure.handler(() => {
    return 'OK'
  }),
  privateData: protectedProcedure.handler(({ context }) => {
    return {
      message: 'This is private',
      user: context.session?.user,
    }
  }),
  user: userRouter,
  vip: vipRouter,
  transaction: transactionRouter,
  tournament: tournamentRouter, // Added tournament router
  game: gameRouter, // Added tournament router
}
export type SocketRouter = typeof appRouter
