// File: ai/server/src/routers/user.routes.ts
import z from 'zod/v4'
import prisma from '../../prisma/index' // Your extended Prisma client
import { protectedProcedure, publicProcedure } from '../lib/orpc'
import type { ExtendedPrismaClient } from '../../prisma' // Import Prisma namespace for input types
import {
  PrismaUserProfile as PrismaUserProfileType,
  UpdateUserInput as UpdateUserInputTypeShared, // Type from shared/dist for input structure
  SetReferrerDto as SetReferrerDtoTypeShared, // Type from shared/dist
  PaginatedResponse as PaginatedResponseType,
} from 'shared/dist'
import { Prisma } from 'prisma/generated'

const _prisma: ExtendedPrismaClient = prisma

// --- Define Simpler Return Types for Procedures ---
// These Pick<> types create subsets of PrismaUserProfileType for procedure return values.
// Ensure field names match your Prisma schema EXACTLY (e.g., cashtag vs. cash_tag)
type UserProfileBasicUpdateResponse = Pick<
  PrismaUserProfileType,
  'id' | 'username' | 'avatar' | 'userId'
>
type UserProfileAvatarUpdateResponse = Pick<PrismaUserProfileType, 'id' | 'avatar' | 'userId'>
type UserProfileCashtagUpdateResponse = Pick<PrismaUserProfileType, 'id' | 'cashtag' | 'userId'>
type ReferredUserProfileSubset = Pick<
  PrismaUserProfileType,
  'id' | 'username' | 'avatar' | 'createdAt' | 'userId'
>
type LeaderboardUserSubset = Pick<
  PrismaUserProfileType,
  'id' | 'username' | 'avatar' | 'totalXpFromOperator'
>

// --- Zod Schemas for Inputs ---
// This Zod schema should align with UpdateUserInputTypeShared
const UpdateUserInputSchema = z.object({
  username: z.string().optional(),
  avatar_url: z.string().url().optional(),
  // Add other fields from UpdateUserInputTypeShared if they exist on PrismaUserProfile or User model
  // e.g., if UpdateUserInputTypeShared has firstName, and PrismaUserProfile has firstName:
  // firstName: z.string().optional(),
})

const SetReferrerDtoSchema = z.object({
  // Ensure this aligns with SetReferrerDtoTypeShared
  referrerCode: z.string(),
})

export const userRouter = {
  getCurrentUser: protectedProcedure.handler(
    async ({ context }): Promise<PrismaUserProfileType> => {
      console.log(context.session)
      if (!context.session?.user?.id) {
        throw new Error('User not authenticated')
      }
      const userProfile = await _prisma.userProfile.findUnique({
        where: { id: context.session.user.id },
        include: {
          wallets: true, // Example: include necessary relations for the full user context
        },
      })
      if (!userProfile) {
        throw new Error('UserProfile not found for authenticated user.')
      }
      return userProfile
    }
  ),

  updateProfile: protectedProcedure
    .input(UpdateUserInputSchema)
    .handler(async ({ context, input }): Promise<UserProfileBasicUpdateResponse> => {
      if (!context.session?.user?.id) {
        throw new Error('User not authenticated')
      }

      // Prepare data for Prisma update, ensuring type compatibility
      const userProfileUpdateData: Prisma.UserProfileUpdateInput = {}
      if (input.username !== undefined) userProfileUpdateData.username = input.username
      if (input.avatar_url !== undefined) userProfileUpdateData.avatar = input.avatar_url
      // Map other fields from 'input' to 'userProfileUpdateData' based on your Prisma schema for UserProfile

      const updatedProfileSubset = await _prisma.userProfile.update({
        where: { userId: context.session.user.id },
        data: userProfileUpdateData, // Prisma will validate this against UserProfileUpdateInput
        select: {
          id: true,
          username: true,
          avatar: true,
          userId: true,
          // Add other scalar fields here that are part of UserProfileBasicUpdateResponse
        },
      })

      const coreUserUpdateData: Prisma.UserUpdateInput = {}
      if (input.username !== undefined) {
        coreUserUpdateData.name = input.username // Assuming User model has 'name'
        coreUserUpdateData.displayUsername = input.username // Assuming User model has 'displayUsername'
      }
      if (input.avatar_url !== undefined) {
        coreUserUpdateData.image = input.avatar_url // User.image for better-auth
      }
      if (Object.keys(coreUserUpdateData).length > 0) {
        await _prisma.user.update({
          where: { id: context.session.user.id },
          data: coreUserUpdateData,
        })
      }
      return updatedProfileSubset
    }),

  updateAvatar: protectedProcedure
    .input(z.object({ avatarUrl: z.string().url() }))
    .handler(async ({ context, input }): Promise<UserProfileAvatarUpdateResponse> => {
      if (!context.session?.user?.id) {
        throw new Error('User not authenticated')
      }
      await _prisma.user.update({
        where: { id: context.session.user.id },
        data: { image: input.avatarUrl },
      })
      return await _prisma.userProfile.update({
        where: { userId: context.session.user.id },
        data: { avatar: input.avatarUrl },
        select: { id: true, avatar: true, userId: true },
      })
    }),

  updateCashtag: protectedProcedure
    .input(z.object({ cashtag: z.string().min(3) }))
    .handler(async ({ context, input }): Promise<UserProfileCashtagUpdateResponse> => {
      if (!context.session?.user?.id) {
        throw new Error('User not authenticated')
      }
      return await _prisma.userProfile.update({
        where: { userId: context.session.user.id },
        data: { cashtag: input.cashtag },
        select: { id: true, cashtag: true, userId: true },
      })
    }),

  setReferrer: protectedProcedure
    .input(SetReferrerDtoSchema)
    .handler(async ({ context, input }): Promise<{ success: boolean; message: string }> => {
      if (!context.session?.user?.id) {
        throw new Error('User not authenticated')
      }
      // ... (Your implementation for setting referrer)
      console.log(`User ${context.session.user.id} set referrer with code: ${input.referrerCode}`)
      return { success: true, message: 'Set referrer logic TBD' }
    }),

  getMyReferrals: protectedProcedure.handler(
    async ({ context }): Promise<ReferredUserProfileSubset[]> => {
      if (!context.session?.user?.id) {
        throw new Error('User not authenticated')
      }
      // Example: Query UserProfiles where their 'referrerId' (assuming such a field exists on the User model,
      // and UserProfile has a relation to User) matches the current user's ID.
      // This query is conceptual and depends heavily on your actual schema relationship for referrals.
      // const referrals = await _prisma.userProfile.findMany({
      //   where: {
      //     user: { // Assuming a 'user' relation on UserProfile that links back to the User model
      //       referrerId: context.session.user.id // And User model has 'referrerId'
      //     }
      //   },
      //   select: {
      //     id: true,
      //     username: true,
      //     avatar: true,
      //     createdAt: true,
      //     userId: true,
      //   }
      // });
      // return referrals;
      return [] // Placeholder: Replace with your actual query
    }
  ),

  getLeaderboard: publicProcedure
    .input(
      z.object({
        page: z.number().min(1).optional().default(1),
        limit: z.number().min(1).max(100).optional().default(10),
      })
    )
    .handler(async ({ input }): Promise<PaginatedResponseType<LeaderboardUserSubset>> => {
      const { page, limit } = input
      const skip = (page - 1) * limit
      const items = await _prisma.userProfile.findMany({
        orderBy: { totalXpFromOperator: 'desc' },
        skip,
        take: limit,
        select: { id: true, username: true, avatar: true, totalXpFromOperator: true },
      })
      const total = await _prisma.userProfile.count()
      return { items, total, page, limit, totalPages: Math.ceil(total / limit) }
    }),
}
