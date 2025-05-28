import { betterAuth } from 'better-auth'
import { prismaAdapter } from 'better-auth/adapters/prisma'
import { username, bearer, createAuthMiddleware } from 'better-auth/plugins'

import prisma from '../../prisma'

export const auth = betterAuth({
  database: prismaAdapter(prisma, {
    provider: 'postgresql',
  }),
  trustedOrigins: [process.env.CORS_ORIGIN || ''],
  emailAndPassword: {
    enabled: true,
    requireEmailVerification: false,
  },
  plugins: [username(), bearer()],
  hooks: {
    after: createAuthMiddleware(async (ctx) => {
      if (ctx.path.startsWith('/sign-up')) {
        const newSession = ctx.context.newSession
        if (newSession) {
          await prisma.userProfile.create({
            data: {
              id: newSession.user.id, // Assuming user.id is the unique identifier
              userId: newSession.user.id,
              avatar: newSession.user.image || 'avatar-10.webp',
              username: newSession.user.name,
              // Set other default values as needed
              balance: 0,
              totalXpFromOperator: 0,
              activeCurrencyType: 'USD',
              lastDailySpin: new Date('1970-01-01T00:00:00Z'),
              isActive: true,
              role: 'USER', // Assuming 'USER' is a valid role in your schema
              vipInfo: {
                create: {
                  id: newSession.user.id, // Assuming user.id is the unique identifier
                  userId: newSession.user.id,
                  avatar: newSession.user.image || 'avatar-10.webp',
                  username: newSession.user.name,
                },
              },
            },
          })
        }
      }
    }),
  },
})
