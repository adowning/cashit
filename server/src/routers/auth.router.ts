// // ai/server/src/routers/auth.router.ts
// import { z } from 'zod/v4';
// import prisma from '../../prisma';
// import { publicProcedure, protectedProcedure, ORPCError } from '../lib/orpc';
// // Assuming 'better-auth' server-side SDK or functions would be called here if needed
// // import { serverBetterAuth } from '../lib/better-auth-server-sdk'; // Placeholder

// import type { GoogleSignInDto, GoogleSignInResponse, UserProfile } from 'shared/dist';

// // Helper to map Prisma User + UserProfile to shared UserProfile type
// async function getSharedUserProfile(userId: string, prismaInstance: typeof prisma): Promise<UserProfile> {
//     const userWithProfile = await prismaInstance.user.findUnique({
//         where: { id: userId },
//         include: { UserProfile: true } // Assuming relation on User model is UserProfile[] or UserProfile?
//     });

//     // If UserProfile is a separate query:
//     const user = await prismaInstance.user.findUnique({where: {id: userId}});
//     if (!user) throw new ORPCError({code: 'NOT_FOUND', message: 'User not found.'});

//     const profile = await prismaInstance.userProfile.findUnique({
//         where: { userId: userId }
//     });

//     if (!profile) {
//         throw new ORPCError({ code: 'NOT_FOUND', message: 'User profile not found.' });
//     }

//     return {
//         id: profile.id,
//         userId: user.id,
//         username: profile.username,
//         avatar: profile.avatar,
//         cashtag: profile.cashtag,
//         balance: profile.balance,
//         totalXpFromOperator: profile.totalXpFromOperator,
//         activeCurrencyType: profile.activeCurrencyType,
//         lastDailySpin: profile.lastDailySpin,
//         isActive: profile.isActive,
//         role: profile.role as any, // Cast if Prisma enum and shared enum differ
//         createdAt: profile.createdAt,
//         updatedAt: profile.updatedAt,
//         otherUserid: profile.otherUserid, // Ensure all fields for shared.PrismaUserProfile
//         operatorId: profile.operatorId,
//         currentGameSessionid: profile.currentGameSessionid,
//     };
// }

// export const authRouter = {
//   // signInWithPassword and signUpNewUser are handled by better-auth's HTTP endpoints

//   // oRPC endpoint for Google Sign-In.
//   // This would verify the Google token and then create/link user via better-auth server SDK
//   // or directly manage user creation if better-auth doesn't have a server SDK for this.
//   signInWithGoogle: publicProcedure
//     .input(z.object({ idToken: z.string() }))
//     .handler(async ({ input, ctx }) => { // Corrected to .handler
//       // 1. Securely verify Google ID token (e.g., using 'google-auth-library')
//       //    const googleUserInfo = await verifyGoogleToken(input.idToken);
//       //    if (!googleUserInfo) throw new ORPCError({ code: 'UNAUTHORIZED', message: 'Invalid Google token.' });

//       // ---- MOCK Google Verification ----
//       const googleUserInfo = {
//           email: `google_${Date.now()}@example.com`,
//           name: "Google User",
//           googleId: `gid_${Date.now()}`,
//           picture: "avatar-google.webp"
//       };
//       // ---- END MOCK ----

//       // 2. Find or create user in your system.
//       // This logic depends on how better-auth handles external providers or if you manage it.
//       // For this example, let's assume direct Prisma interaction,
//       // but ideally, you'd use better-auth's server-side functions if they exist.

//       let user = await prisma.user.findUnique({ where: { email: googleUserInfo.email } });
//       let userIdForSession: string;

//       if (user) {
//           userIdForSession = user.id;
//           // Check if Google account is linked, if not, link it (e.g., update Account table)
//           const googleAccount = await prisma.account.findFirst({
//               where: { providerId: 'google', userId: user.id }
//           });
//           if (!googleAccount) {
//               await prisma.account.create({
//                   data: {
//                       userId: user.id,
//                       providerId: 'google',
//                       accountId: googleUserInfo.googleId, // Google's unique ID for the user
//                       // id, createdAt, updatedAt might be auto-generated or need defaults
//                       id: `acc_google_${user.id}`,
//                   }
//               });
//           }
//       } else {
//           // Create new user and UserProfile
//           const newUser = await prisma.user.create({
//               data: {
//                   id: `user_${Date.now()}`,
//                   email: googleUserInfo.email,
//                   username: googleUserInfo.email, // Or generate a unique username
//                   displayUsername: googleUserInfo.name,
//                   emailVerified: true,
//                   image: googleUserInfo.picture,
//                   // UserProfile will be created next
//               }
//           });
//           await prisma.userProfile.create({
//               data: {
//                   id: `prof_${newUser.id}`, // Ensure ID is provided
//                   userId: newUser.id,
//                   username: googleUserInfo.email, // Or generated username
//                   avatar: googleUserInfo.picture,
//                   // Ensure all required UserProfile fields are set
//                   balance: 0,
//                   totalXpFromOperator: 0,
//                   activeCurrencyType: 'USD',
//                   lastDailySpin: new Date(0),
//                   isActive: true,
//               }
//           });
//           await prisma.account.create({
//               data: {
//                   id: `acc_google_${newUser.id}`,
//                   userId: newUser.id,
//                   providerId: 'google',
//                   accountId: googleUserInfo.googleId,
//               }
//           });
//           userIdForSession = newUser.id;
//       }

//       // 3. Create a session using better-auth's server-side mechanism if possible,
//       //    or generate your own session/JWT if oRPC is managing sessions independently
//       //    after better-auth handles initial credential exchange.
//       //    For now, let's assume oRPC needs to return token-like data.
//       //    This part is highly dependent on how `better-auth` server-side works.

//       // Placeholder for session token generation if oRPC handles its own sessions post-better-auth
//       const accessToken = `orpcsession_${userIdForSession}_${Date.now()}`;
//       const userProfileData = await getSharedUserProfile(userIdForSession, prisma);

//       return
// // // ai/server/src/routers/auth.router.ts
// // import { z } from 'zod/v4'
// // import prisma from '../../prisma'
// // import { publicProcedure, protectedProcedure } from '../lib/orpc'
// // import { hashPassword, Verification } from '../lib/auth' // Assuming you have these helpers
// // import { Prisma } from '@prisma/client' // Import Prisma
// // import type {
// //   AuthCredentials,
// //   SignUpPayload,
// //   RefreshTokenDto,
// //   AuthResponseDto,
// //   UserProfile,
// //   GoogleSignInDto,
// //   GoogleSignInResponse,
// // } from 'shared/dist' // From shared types
// // import { ORPCError, os } from "@orpc/server";

// // // Placeholder for JWT token generation - replace with your actual implementation
// // const generateAccessToken = (userId: string) => `mock-access-token-for-${userId}-${Date.now()}`
// // const generateRefreshToken = (userId: string) => `mock-refresh-token-for-${userId}-${Date.now()}`

// // export const authRouter = {
// //   signInWithPassword: publicProcedure
// //     .input(
// //       z.object({
// //         username: z.string(),
// //         password: z.string(),
// //       })
// //     )
// //     .mutation(async ({ input, ctx }) => {
// //       const userAccount = await prisma.account.findFirst({
// //         where: {
// //           OR: [
// //             { user: { username: input.username } },
// //             { user: { email: input.username } }, // Allow login with email
// //           ],
// //           providerId: 'credentials', // Assuming you use 'credentials' for password-based auth
// //         },
// //         include: { user: { include: { profile: true } } },
// //       })

// //       if (!userAccount || !userAccount.password) {
// //         throw new ORPCError({ code: 'UNAUTHORIZED', message: 'Invalid username or password.' })
// //       }

// //       const isValidPassword = await verifyPassword(input.password, userAccount.password)
// //       if (!isValidPassword) {
// //         throw new ORPCError({ code: 'UNAUTHORIZED', message: 'Invalid username or password.' })
// //       }

// //       if (!userAccount.user.profile) {
// //         // This case should ideally not happen if user creation guarantees a profile.
// //         // If it can, create a profile here or throw an error.
// //         console.error(`User ${userAccount.userId} is missing a UserProfile.`)
// //         // As a fallback, create one. This might need more default values.
// //         userAccount.user.profile = await prisma.userProfile.create({
// //           data: {
// //             userId: userAccount.userId,
// //             username: userAccount.user.username, // Ensure UserProfile has a username
// //             // Add any other required default fields for UserProfile
// //           },
// //         })
// //         if (!userAccount.user.profile) {
// //           throw new ORPCError({
// //             code: 'INTERNAL_SERVER_ERROR',
// //             message: 'User profile could not be created or fetched.',
// //           })
// //         }
// //       }

// //       const accessToken = generateAccessToken(userAccount.userId)
// //       const refreshToken = generateRefreshToken(userAccount.userId)

// //       // Update session or log login
// //       await prisma.session.create({
// //         data: {
// //           userId: userAccount.userId,
// //           token: accessToken, // Or a separate session token
// //           expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // Example: 7 days
// //         },
// //       })

// //       // Explicitly construct UserProfile based on shared type
// //       const userProfileData: UserProfile = {
// //         id: userAccount.user.profile.id,
// //         userId: userAccount.user.id,
// //         username: userAccount.user.profile.username,
// //         avatar: userAccount.user.profile.avatar,
// //         cashtag: userAccount.user.profile.cashtag,
// //         balance: userAccount.user.profile.balance,
// //         totalXpFromOperator: userAccount.user.profile.totalXpFromOperator,
// //         activeCurrencyType: userAccount.user.profile.activeCurrencyType,
// //         lastDailySpin: userAccount.user.profile.lastDailySpin,
// //         isActive: userAccount.user.profile.isActive,
// //         role: userAccount.user.profile.role,
// //         createdAt: userAccount.user.profile.createdAt,
// //         updatedAt: userAccount.user.profile.updatedAt,
// //         // Map other fields as necessary from userAccount.user and userAccount.user.profile
// //       }

// //       return {
// //         accessToken,
// //         refreshToken,
// //         user: userProfileData,
// //       } as AuthResponseDto // Ensure this matches the AuthResponseDto structure
// //     }),

// //   signUpNewUser: publicProcedure
// //     .input(
// //       z.object({
// //         // Based on SignUpPayload from auth.store.ts
// //         email: z.string().email(),
// //         // username: z.string().min(3),
// //         password: z.string().min(6), // Add password validation as needed
// //       })
// //     )
// //     .mutation(async ({ input, ctx }) => {
// //       const existingUserByEmail = await prisma.user.findUnique({ where: { email: input.email } })
// //       if (existingUserByEmail) {
// //         throw new ORPCError({ code: 'CONFLICT', message: 'Email already in use.' })
// //       }
// //       const existingUserByUsername = await prisma.user.findUnique({
// //         where: { username: input.username },
// //       })
// //       if (existingUserByUsername) {
// //         throw new ORPCError({ code: 'CONFLICT', message: 'Username already taken.' })
// //       }

// //       const hashedPassword = await hashPassword(input.password)
// //       const userId = `user_${new Date().getTime()}` // Simple unique ID generation

// //       const user = await prisma.user.create({
// //         data: {
// //           id: userId,
// //           email: input.email,
// //           username: input.username,
// //           displayUsername: input.username,
// //           emailVerified: false, // Set to true if you have an email verification flow
// //           createdAt: new Date(),
// //           updatedAt: new Date(),
// //           profile: {
// //             create: {
// //               id: `profile_${userId}`, // Ensure UserProfile id is unique
// //               username: input.username, // Or derive from user.username
// //               // Add other default UserProfile fields here
// //               avatar: 'avatar-10.webp', // Default avatar
// //             },
// //           },
// //           accounts: {
// //             create: {
// //               id: `account_${userId}_credentials`,
// //               accountId: userId, // Or a provider-specific ID
// //               providerId: 'credentials',
// //               password: hashedPassword,
// //               createdAt: new Date(),
// //               updatedAt: new Date(),
// //             },
// //           },
// //         },
// //         include: { profile: true },
// //       })

// //       if (!user.profile) {
// //         throw new ORPCError({
// //           code: 'INTERNAL_SERVER_ERROR',
// //           message: 'User profile could not be created.',
// //         })
// //       }

// //       const accessToken = generateAccessToken(user.id)
// //       const refreshToken = generateRefreshToken(user.id)

// //       // Explicitly construct UserProfile based on shared type
// //       const userProfileData: UserProfile = {
// //         id: user.profile.id,
// //         userId: user.id,
// //         username: user.profile.username,
// //         avatar: user.profile.avatar,
// //         cashtag: user.profile.cashtag,
// //         balance: user.profile.balance,
// //         totalXpFromOperator: user.profile.totalXpFromOperator,
// //         activeCurrencyType: user.profile.activeCurrencyType,
// //         lastDailySpin: user.profile.lastDailySpin,
// //         isActive: user.profile.isActive,
// //         role: user.profile.role,
// //         createdAt: user.profile.createdAt,
// //         updatedAt: user.profile.updatedAt,
// //       }

// //       return {
// //         accessToken,
// //         refreshToken,
// //         user: userProfileData,
// //       } as AuthResponseDto
// //     }),

// //   getCurrentSession: protectedProcedure // Renamed from getMe for clarity with session focus
// //     .query(async ({ ctx }) => {
// //       if (!ctx.session?.user?.id) {
// //         throw new ORPCError({ code: 'UNAUTHORIZED', message: 'Not authenticated' })
// //       }
// //       const userProfile = await prisma.userProfile.findUnique({
// //         where: { userId: ctx.session.user.id },
// //       })

// //       if (!userProfile) {
// //         throw new ORPCError({ code: 'NOT_FOUND', message: 'User profile not found.' })
// //       }

// //       // Map to UserProfile shared type
// //       const userProfileData: UserProfile = {
// //         id: userProfile.id,
// //         userId: userProfile.userId, // This was missing in your example, important to include
// //         username: userProfile.username,
// //         avatar: userProfile.avatar,
// //         cashtag: userProfile.cashtag,
// //         balance: userProfile.balance,
// //         totalXpFromOperator: userProfile.totalXpFromOperator,
// //         activeCurrencyType: userProfile.activeCurrencyType,
// //         lastDailySpin: userProfile.lastDailySpin,
// //         isActive: userProfile.isActive,
// //         role: userProfile.role,
// //         createdAt: userProfile.createdAt,
// //         updatedAt: userProfile.updatedAt,
// //       }

// //       return {
// //         accessToken: ctx.session.token, // Assuming token is stored in session context
// //         user: userProfileData,
// //       } as GetSessionResponse // Ensure this type exists in shared/dist
// //     }),

// //   // Placeholder for signInWithGoogle - requires Google OAuth setup
// //   signInWithGoogle: publicProcedure
// //     .input(z.object({ idToken: z.string() }))
// //     .mutation(async ({ input }) => {
// //       // 1. Verify Google ID Token (use a library like 'google-auth-library')
// //       // 2. Extract user info (email, name, picture)
// //       // 3. Find or create user in your DB based on Google email
// //       //    - If new user, create User, Account (provider: 'google'), UserProfile
// //       //    - If existing user, link Google account if not already linked
// //       // 4. Generate your app's access and refresh tokens
// //       // 5. Return AuthResponseDto
// //       console.log('Google Sign-In attempt with token:', input.idToken.substring(0, 20) + '...')
// //       // This is a mock implementation. Replace with actual Google token verification.
// //       const mockGoogleUser = {
// //         email: `google_user_${Date.now()}@example.com`,
// //         name: 'Google User',
// //         picture: 'avatar-google.webp',
// //         googleId: `google-id-${Date.now()}`,
// //       }

// //       let user = await prisma.user.findUnique({
// //         where: { email: mockGoogleUser.email },
// //         include: { profile: true, accounts: true },
// //       })
// //       let userProfile: Prisma.UserProfile | null = null

// //       if (!user) {
// //         const userId = `user_google_${Date.now()}`
// //         user = await prisma.user.create({
// //           data: {
// //             id: userId,
// //             email: mockGoogleUser.email,
// //             username: mockGoogleUser.email, // Or generate a unique username
// //             displayUsername: mockGoogleUser.name,
// //             emailVerified: true,
// //             image: mockGoogleUser.picture,
// //             createdAt: new Date(),
// //             updatedAt: new Date(),
// //             profile: {
// //               create: {
// //                 id: `profile_google_${userId}`,
// //                 username: mockGoogleUser.email, // Or a generated unique username
// //                 avatar: mockGoogleUser.picture,
// //               },
// //             },
// //             accounts: {
// //               create: {
// //                 id: `account_google_${userId}`,
// //                 accountId: mockGoogleUser.googleId,
// //                 providerId: 'google',
// //                 userId: userId,
// //                 createdAt: new Date(),
// //                 updatedAt: new Date(),
// //               },
// //             },
// //           },
// //           include: { profile: true, accounts: true },
// //         })
// //         userProfile = user.profile
// //       } else {
// //         userProfile = user.profile
// //         const googleAccount = user.accounts.find((acc) => acc.providerId === 'google')
// //         if (!googleAccount) {
// //           await prisma.account.create({
// //             data: {
// //               id: `account_google_${user.id}`,
// //               accountId: mockGoogleUser.googleId,
// //               providerId: 'google',
// //               userId: user.id,
// //               createdAt: new Date(),
// //               updatedAt: new Date(),
// //             },
// //           })
// //         }
// //       }
// //       if (!userProfile) {
// //         throw new ORPCError({
// //           code: 'INTERNAL_SERVER_ERROR',
// //           message: 'User profile could not be ensured.',
// //         })
// //       }

// //       const accessToken = generateAccessToken(user.id)
// //       const refreshToken = generateRefreshToken(user.id)

// //       const sharedUserProfile: UserProfile = {
// //         id: userProfile.id,
// //         userId: user.id,
// //         username: userProfile.username,
// //         avatar: userProfile.avatar,
// //         // ... map other fields
// //         cashtag: userProfile.cashtag,
// //         balance: userProfile.balance,
// //         totalXpFromOperator: userProfile.totalXpFromOperator,
// //         activeCurrencyType: userProfile.activeCurrencyType,
// //         lastDailySpin: userProfile.lastDailySpin,
// //         isActive: userProfile.isActive,
// //         role: userProfile.role,
// //         createdAt: userProfile.createdAt,
// //         updatedAt: userProfile.updatedAt,
// //       }

// //       return {
// //         accessToken,
// //         refreshToken, // Google sign in usually doesn't return your app's refresh token this way
// //         user: sharedUserProfile, // Map to your UserProfile type
// //         authenticated: true, // Add this field if your GoogleSignInResponse expects it
// //         code: 200,
// //       } as GoogleSignInResponse // Ensure GoogleSignInResponse structure
// //     }),

// //   logout: protectedProcedure
// //     .input(z.object({ refreshToken: z.string() }).optional()) // refreshToken might not always be available or needed for session invalidation
// //     .mutation(async ({ ctx, input }) => {
// //       // Invalidate session server-side if applicable
// //       // For example, delete the session from DB based on access token or refresh token
// //       if (ctx.session?.token) {
// //         await prisma.session.deleteMany({ where: { token: ctx.session.token } })
// //       }
// //       // If using refresh tokens stored in DB, you might want to invalidate it:
// //       // if (input?.refreshToken) {
// //       //   await prisma.refreshToken.delete({ where: { token: input.refreshToken } });
// //       // }
// //       return { success: true, message: 'Logged out successfully' }
// //     }),

// //   refreshToken: publicProcedure // Or protectedProcedure if old access token is required for context
// //     .input(z.object({ refreshToken: z.string() }))
// //     .mutation(async ({ input }) => {
// //       // 1. Validate the refresh token (e.g., check against DB, check expiry)
// //       //    This is a MOCK, replace with actual validation.
// //       //    const storedToken = await prisma.refreshToken.findUnique({ where: { token: input.refreshToken }});
// //       //    if (!storedToken || storedToken.expiresAt < new Date()) {
// //       //        throw new ORPCError({ code: 'UNAUTHORIZED', message: 'Invalid or expired refresh token.' });
// //       //    }
// //       //    const userId = storedToken.userId;

// //       // For mock, assume refresh token implies a user ID. In reality, you'd look it up.
// //       const mockUserIdFromRefreshToken = input.refreshToken.startsWith('mock-refresh-token-for-')
// //         ? input.refreshToken.split('-')[4] // Highly insecure, for demo only!
// //         : null

// //       if (!mockUserIdFromRefreshToken) {
// //         throw new ORPCError({
// //           code: 'UNAUTHORIZED',
// //           message: 'Invalid refresh token format for mock.',
// //         })
// //       }

// //       const user = await prisma.user.findUnique({
// //         where: { id: mockUserIdFromRefreshToken },
// //         include: { profile: true },
// //       })
// //       if (!user || !user.profile) {
// //         throw new ORPCError({ code: 'UNAUTHORIZED', message: 'User not found for refresh token.' })
// //       }

// //       const newAccessToken = generateAccessToken(user.id)
// //       // Optionally, generate a new refresh token (token rotation)
// //       const newRefreshToken = generateRefreshToken(user.id)
// //       // await prisma.refreshToken.update({ where: { token: input.refreshToken }, data: { token: newRefreshToken, expiresAt: ... }});

// //       const userProfileData: UserProfile = {
// //         id: user.profile.id,
// //         userId: user.id,
// //         username: user.profile.username,
// //         avatar: user.profile.avatar,
// //         cashtag: user.profile.cashtag,
// //         balance: user.profile.balance,
// //         totalXpFromOperator: user.profile.totalXpFromOperator,
// //         activeCurrencyType: user.profile.activeCurrencyType,
// //         lastDailySpin: user.profile.lastDailySpin,
// //         isActive: user.profile.isActive,
// //         role: user.profile.role,
// //         createdAt: user.profile.createdAt,
// //         updatedAt: user.profile.updatedAt,
// //       }

// //       return {
// //         accessToken: newAccessToken,
// //         refreshToken: newRefreshToken, // Send new refresh token if rotated
// //         user: userProfileData, // Send updated user data if needed
// //       } as AuthResponseDto
// //     }),
// // }

// // export type AuthRouter = typeof authRouter
