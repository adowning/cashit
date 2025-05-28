import z from 'zod/v4'
import prisma from '../../prisma/index'
import { protectedProcedure, publicProcedure } from '../lib/orpc'
import type { ExtendedPrismaClient } from '../../prisma'
import {
  PrismaGameCategory,
  RTGSettingsRequestDto,
  RTGSettingsResponseDto,
  RTGSpinRequestDto,
  RTGSpinResponseDto,
  ProviderSettingsResponseData, // Assuming this is the detailed structure for RTG settings
  ProviderSpinResponseData, // Assuming this is the detailed structure for RTG spin result
  PrismaGameHistoryItem as GameHistoryItem, // From shared types for game history
  PrismaGameBigWinData as GameBigWinData, // From shared types for big wins
  PrismaGameProvider as SharedGameProvider,
  PrismaGame as SharedPrismaGame, // Using the shared PrismaGame for broader compatibility
  PaginatedResponse,
  LaunchGameResponseDto,
  PrismaGameProviderName,
  HighRollerInfo,
  LuckyBetInfo,
  OutputGameBigWinItem,
  GameBigWinResponseData,
} from 'shared/dist' // Ensure your shared types are correctly structured and exported
import { Prisma } from '../../prisma/generated/client' // For Prisma.* types if needed
import { GameCategory as PrismaGameCategoryEnum } from '../../prisma/generated/client'

const _prisma: ExtendedPrismaClient = prisma

// --- Zod Schemas for Input Validation ---
const GameIdSchema = z.object({
  id: z.string().cuid(), // Assuming game IDs are CUIDs
})

const GameSlugSchema = z.object({
  slug: z.string(),
})

const GameEnterSchema = z.object({
  id: z.string(), // Can be CUID or external ID based on your logic
  demo: z.boolean().optional().default(false),
})

const GameHistoryQuerySchema = z
  .object({
    page: z.number().int().min(1).optional().default(1),
    limit: z.number().int().min(1).max(100).optional().default(10),
    // Add other filters like gameId, dateRange if needed
  })
  .optional()

const GameSearchQuerySchema = z
  .object({
    query: z.string().optional(),
    category: z.ZodAny,
    provider: z.ZodAny,
    page: z.number().int().min(1).optional().default(1),
    limit: z.number().int().min(1).max(100).optional().default(20),
    featured: z.boolean().optional(),
    isActive: z.boolean().optional().default(true),
    // Add more filters like tags, etc.
  })
  .optional()

const SetFavoriteGameSchema = z.object({
  gameId: z.string().cuid(),
  isFavorite: z.boolean(),
})

// Shared type for Game with provider info, adjust as necessary
type GameWithProvider = SharedPrismaGame & {
  gameProvider?: SharedGameProvider | null
}

// Helper to map PrismaGame to a client-friendly structure (SharedPrismaGame or custom)
// This ensures consistency and avoids sending unnecessary fields.
const mapPrismaGameToSharedGame = (game: GameWithProvider): SharedPrismaGame => {
  // Ensure all fields required by SharedPrismaGame are mapped
  // This is an example; you'll need to adjust based on your actual SharedPrismaGame definition
  return {
    id: game.id,
    name: game.name,
    title: game.title,
    description: game.description,
    supportedProviders: game.supportedProviders,
    category: game.category,
    tags: game.tags,
    isActive: game.isActive,
    thumbnailUrl: game.thumbnailUrl,
    bannerUrl: game.bannerUrl,
    meta: game.meta, // Prisma.JsonValue maps to JsonValue in shared
    createdAt: game.createdAt,
    updatedAt: game.updatedAt,
    featured: game.featured,
    providerName: game.providerName,
    totalWagered: game.totalWagered,
    gameProviderId: game.gameProviderId,
    gameProvider: game.gameProvider
      ? {
          // Map provider if included and needed
          id: game.gameProvider.id,
          name: game.gameProvider.name,
          displayName: game.gameProvider.displayName,
          rgsBaseUrl: game.gameProvider.rgsBaseUrl,
          settingsPath: game.gameProvider.settingsPath,
          spinPath: game.gameProvider.spinPath,
          resolveBetPath: game.gameProvider.resolveBetPath,
          providerRoundId: game.gameProvider.providerRoundId,
          authType: game.gameProvider.authType,
          apiKey: game.gameProvider.apiKey, // Be cautious exposing sensitive fields
          apiSecret: game.gameProvider.apiSecret, // Be cautious
          publicKey: game.gameProvider.publicKey,
          privateKeyRef: game.gameProvider.privateKeyRef,
          configJson: game.gameProvider.configJson,
          isActive: game.gameProvider.isActive,
          notes: game.gameProvider.notes,
          createdAt: game.gameProvider.createdAt,
          updatedAt: game.gameProvider.updatedAt,
        }
      : null,
    operatorId: game.operatorId,
    // Ensure other fields like gameSessions, gameLaunchLinks, operator, TournamentGame are handled
    // or explicitly excluded if not needed by the client for this DTO.
    // For simplicity, I'm omitting them here, but you might need them.
    gameSessions: [], // Placeholder or fetch if needed
    gameLaunchLinks: [], // Placeholder
    // operator: null, // Placeholder
    TournamentGame: [], // Placeholder
    goldsvetData: game.goldsvetData, // Make sure this is compatible
  }
}

export const gameRouter = {
  getGameCategories: publicProcedure
    // .output(z.array(z.nativeEnum(PrismaGameCategoryEnum))) // Assuming you just return enum values
    .handler(async () => {
      // This simply returns all possible enum values.
      // If you have a GameCategory model in Prisma, you'd query that instead.
      return Object.values(PrismaGameCategoryEnum)
    }),

  getGameProviders: publicProcedure
    .output(z.array(z.custom<SharedGameProvider>())) // Assuming PrismaGameProvider is your shared type
    .handler(async (): Promise<SharedGameProvider[]> => {
      const providers = await _prisma.gameProvider.findMany({
        where: { isActive: true },
        orderBy: { name: 'asc' },
      })
      // Map to SharedGameProvider if necessary, or ensure PrismaGameProvider is compatible
      return providers.map((p) => ({
        ...p,
        configJson: p.configJson ?? null,
        meta: p.configJson ?? null,
      }))
    }),

  searchGames: publicProcedure
    .input(GameSearchQuerySchema)
    .output(z.custom<PaginatedResponse<SharedPrismaGame>>())
    .handler(async ({ input }): Promise<PaginatedResponse<SharedPrismaGame>> => {
      const { page = 1, limit = 20, query, category, provider, featured, isActive } = input ?? {}

      const whereClause: Prisma.GameWhereInput = {}
      if (query) {
        whereClause.OR = [
          { name: { contains: query, mode: 'insensitive' } },
          { title: { contains: query, mode: 'insensitive' } },
          { description: { contains: query, mode: 'insensitive' } },
        ]
      }
      if (category) {
        whereClause.category = category
      }
      if (provider) {
        // Assuming provider name is stored on the Game model or via relation
        whereClause.gameProvider = { name: provider as PrismaGameProviderName }
      }
      if (featured !== undefined) {
        whereClause.featured = featured
      }
      if (isActive !== undefined) {
        whereClause.isActive = isActive
      }

      const totalGames = await _prisma.game.count({ where: whereClause })
      const gamesData = await _prisma.game.findMany({
        where: whereClause,
        include: { gameProvider: true }, // Include provider info
        orderBy: [{ featured: 'desc' }, { name: 'asc' }],
        skip: (page - 1) * limit,
        take: limit,
      })
      const x = gamesData.map(mapPrismaGameToSharedGame)
      console.log(x)
      return {
        items: gamesData.map(mapPrismaGameToSharedGame),
        total: totalGames,
        page,
        limit,
        totalPages: Math.ceil(totalGames / limit),
      }
    }),

  getGameDetails: publicProcedure // Or protected if details are sensitive
    .input(GameIdSchema) // Assuming you fetch by CUID
    .output(z.custom<SharedPrismaGame | null>())
    .handler(async ({ input }): Promise<SharedPrismaGame | null> => {
      const game = await _prisma.game.findUnique({
        where: { id: input.id },
        include: { gameProvider: true },
      })
      return game ? mapPrismaGameToSharedGame(game) : null
    }),

  // This is a placeholder. Actual game launch involves more complex logic,
  // potentially interacting with game aggregators or specific provider APIs.
  launchGame: protectedProcedure
    .input(GameEnterSchema)
    .output(z.custom<LaunchGameResponseDto>())
    .handler(async ({ context, input }): Promise<LaunchGameResponseDto> => {
      const userId = context.session.user.id
      const game = await _prisma.game.findUnique({ where: { id: input.id } }) // or other identifier

      if (!game) {
        throw new Error('Game not found')
      }
      if (!game.isActive) {
        throw new Error('Game is not active')
      }

      // TODO: Implement actual game launch logic.
      // This might involve:
      // 1. Checking user's balance/eligibility.
      // 2. Calling a game aggregator API to get a session URL.
      // 3. Creating a GameSession record in your database.
      // 4. Returning the launch URL and session ID.
      const gameSession = await _prisma.gameSession.create({
        data: {
          userId: userId,
          gameId: game.id,
          isActive: true,
          // sessionData: {}, // Initial session data
          // rtgToken, rtgFingerPrint might be populated after provider call
        },
      })

      // For now, returning a mock response.
      return {
        launch_url: `https://example.com/launch/${game.id}?user=${userId}&session=${gameSession.id}&demo=${input.demo}`,
        game_session_id: gameSession.id, // Your internal game session ID
        launch_strategy: 'IFRAME', // Or 'REDIRECT', 'POPUP'
      }
    }),

  // Placeholder for RTG specific settings - requires actual RTG integration
  rtgSettings: protectedProcedure
    .input(z.custom<RTGSettingsRequestDto>())
    .output(z.custom<RTGSettingsResponseDto>())
    .handler(async ({ input, context }): Promise<RTGSettingsResponseDto> => {
      // 1. Authenticate user (context.session.user.id)
      // 2. Prepare request for RTG /settings endpoint based on input
      //    (map your userId to RTG's expected format, etc.)
      // 3. Call the RTG provider's /settings API (proxy request)
      //    This would involve an HTTP call from the server to RTG.
      // 4. Create/update a GameSession in your DB with RTG session details.
      // 5. Map RTG's response to ProviderSettingsResponseData.
      // 6. Return RTGSettingsResponseDto.

      console.log('RTG Settings Request:', input, 'User:', context.session.user.id)
      // Mock response - Replace with actual RTG integration logic
      const mockRtgSettingsData: ProviderSettingsResponseData = {
        user: {
          balance: { cash: '100.00' },
          canGamble: true,
          userId: context.session.user.id, // Or RTG's specific ID for the user
          sessionId: `rtg-session-${Date.now()}`,
          token: `rtg-token-${Date.now()}`,
          serverTime: new Date().toISOString(),
        },
        game: { version: '1.0', gameType: 'slot' },
      }
      // Example: Create a game session (simplified)
      await _prisma.gameSession.upsert({
        where: { id: mockRtgSettingsData.user.sessionId }, // Or another unique constraint
        update: {
          isActive: true,
          sessionData: mockRtgSettingsData as any,
          rtgToken: mockRtgSettingsData.user.token,
        },
        create: {
          id: mockRtgSettingsData.user.sessionId,
          userId: context.session.user.id,
          gameId: input.gameId, // Ensure this gameId exists in your DB
          isActive: true,
          sessionData: mockRtgSettingsData as any,
          rtgToken: mockRtgSettingsData.user.token,
        },
      })
      return { success: true, result: mockRtgSettingsData }
    }),

  // Placeholder for RTG specific spin - requires actual RTG integration
  rtgSpin: protectedProcedure
    .input(z.custom<RTGSpinRequestDto>())
    .output(z.custom<RTGSpinResponseDto>())
    .handler(async ({ input, context }): Promise<RTGSpinResponseDto> => {
      // 1. Validate user session and RTG game session token (input.sessionId, input.token)
      // 2. Debit user's balance for the stake (create a BET transaction)
      // 3. Call RTG /spin API (proxy request)
      // 4. Handle RTG's response:
      //    - If win, credit user's balance (create a WIN transaction)
      //    - Update GameSession with spin details, win/loss amounts.
      //    - Create GameSpin record.
      // 5. Map RTG's spin response to ProviderSpinResponseData.
      // 6. Return RTGSpinResponseDto.

      console.log('RTG Spin Request:', input, 'User:', context.session.user.id)
      // Mock response - Replace with actual RTG integration and platform game round handling logic
      const mockRtgSpinData: ProviderSpinResponseData = {
        transactions: { roundId: `round-${Date.now()}` },
        user: {
          balance: { cash: { atEnd: '99.00' } }, // Example: balance after R5 stake
          userId: context.session.user.id,
          sessionId: input.sessionId,
          token: input.token,
          serverTime: new Date().toISOString(),
        },
        game: {
          win: { total: '0.00' }, // Example: no win
          stake: input.stake.toString(),
        },
      }
      // Example: Update game session (simplified)
      await _prisma.gameSession.update({
        where: { id: input.sessionId },
        data: {
          // Update sessionData, totalWagered, totalWon based on spin
          // This is highly dependent on the full GamePlatformSpinResultDetails logic
        },
      })
      return { success: true, result: mockRtgSpinData }
    }),

  getGameHistory: protectedProcedure
    .input(GameHistoryQuerySchema)
    .output(z.custom<PaginatedResponse<GameHistoryItem>>())
    .handler(async ({ context, input }): Promise<PaginatedResponse<GameHistoryItem>> => {
      const userId = context.session.user.id
      const { page = 1, limit = 10 } = input ?? {}

      // This is a conceptual query. You'll need to decide what constitutes "game history".
      // It could be from GameSession, GameSpin, or Transaction records.
      // Assuming GameSpin records hold individual game round outcomes.
      const totalSpins = await _prisma.gameSpin.count({
        where: { gameSession: { userId: userId } },
      })
      const spins = await _prisma.gameSpin.findMany({
        where: { gameSession: { userId: userId } },
        include: {
          gameSession: { include: { game: true } },
        },
        orderBy: { createdAt: 'desc' },
        skip: (page - 1) * limit,
        take: limit,
      })

      const records: GameHistoryItem[] = spins.map((spin) => {
        // You need to parse spin.spinData to get bet, win, multiplier etc.
        // This is highly dependent on the structure of your spinData JSON.
        const spinData = spin.spinData as any // Cast for now
        return {
          name: spin.gameSession?.game?.name ?? 'Unknown Game',
          created_at: spin.createdAt.getTime(),
          amount: spinData?.betAmount ?? spin.wagerAmount ?? 0, // Example access
          multiplier: spinData?.multiplier ?? 0, // Example access
          bet_id: spin.id,
          status: spinData?.status ?? 'completed', // Example access
          profit:
            (spinData?.winAmount ?? spin.grossWinAmount ?? 0) -
            (spinData?.betAmount ?? spin.wagerAmount ?? 0), // Example calculation
        }
      })

      return {
        items: records,
        total: totalSpins,
        page,
        limit,
        totalPages: Math.ceil(totalSpins / limit),
      }
    }),

  getGameBigWins: publicProcedure
    .output(z.custom<GameBigWinData>())
    .handler(async (): Promise<GameBigWinData> => {
      const now = new Date()
      const twentyFourHoursAgo = new Date(now.getTime() - 24 * 60 * 60 * 1000)
      const sevenDaysAgo = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000)

      const finalDisplayLimit = 10 // How many to show in the UI
      const initialFetchMultiplier = 3 // Fetch 3x more records initially for diversification
      const luckyBetsFetchLimit = finalDisplayLimit * initialFetchMultiplier
      const highRollersFetchLimit = finalDisplayLimit * initialFetchMultiplier

      // --- Fetch Lucky Bets (with increased limit for diversification) ---
      const rawLuckyBetsData = await prisma.gameSpin.findMany({
        where: {
          grossWinAmount: {
            gt: 0,
          },
          timeStamp: {
            gte: twentyFourHoursAgo,
          },
        },
        orderBy: {
          grossWinAmount: 'desc',
        },
        take: luckyBetsFetchLimit,
        include: {
          gameSession: {
            select: {
              userId: true,
              refferenceToUserProfile: {
                select: {
                  username: true,
                  avatar: true,
                },
              },
              game: {
                select: {
                  id: true,
                  name: true,
                  title: true,
                  thumbnailUrl: true,
                },
              },
            },
          },
        },
      })

      const userBestSpins = new Map<string, OutputGameBigWinItem>()

      for (const spin of rawLuckyBetsData) {
        if (!spin.gameSession?.userId || !spin.gameSession.refferenceToUserProfile) {
          continue
        }

        const userId = spin.gameSession.userId
        const wager = spin.wagerAmount || 1
        const multiplier =
          spin.grossWinAmount && wager > 0
            ? parseFloat((spin.grossWinAmount / wager).toFixed(2))
            : null

        const currentSpinInfo: OutputGameBigWinItem = {
          id: spin.id,
          userId: userId,
          username: spin.gameSession.refferenceToUserProfile.username || 'Player',
          avatar: spin.gameSession.refferenceToUserProfile.avatar || null,
          gameName: spin.gameSession.game?.name || spin.gameSession.game?.name || 'Unknown Game',
          winAmount: spin.grossWinAmount,
          wagerAmount: spin.wagerAmount,
          multiplier: multiplier,
          timestamp: spin.timeStamp,
          gameId: spin.gameSession.game?.id,
          // gameIcon: spin.gameSession.game?.thumbnailUrl || null,
        }

        const existingBestSpin = userBestSpins.get(userId)
        if (!existingBestSpin || currentSpinInfo.winAmount > existingBestSpin.winAmount) {
          userBestSpins.set(userId, currentSpinInfo)
        }
      }

      const diversifiedLuckyBets = Array.from(userBestSpins.values())
        .sort((a, b) => b.winAmount! - a.winAmount!)
        .slice(0, finalDisplayLimit)

      // --- Fetch High Rollers ---
      const highRollersAggregates = await prisma.gameSession.groupBy({
        by: ['userId'],
        where: {
          startTime: { gte: sevenDaysAgo },
          totalWagered: { gt: 0 },
        },
        _sum: { totalWagered: true },
        _max: { startTime: true },
        orderBy: { _sum: { totalWagered: 'desc' } },
        take: highRollersFetchLimit,
      })

      const final_high_rollers: OutputGameBigWinItem[] = []
      if (highRollersAggregates.length > 0) {
        const userIds = highRollersAggregates
          .map((hr) => hr.userId)
          .filter((id) => id !== null) as string[]
        if (userIds.length > 0) {
          const userDetails = await prisma.userProfile.findMany({
            where: { userId: { in: userIds } },
            select: { userId: true, username: true, avatar: true, activeCurrencyType: true },
          })
          const userMap = new Map(userDetails.map((ud) => [ud.userId, ud]))

          const recentGamesPlayedByUser = await prisma.gameSession.findMany({
            where: { userId: { in: userIds }, startTime: { gte: sevenDaysAgo } },
            orderBy: { startTime: 'desc' },
            distinct: ['userId'],
            select: {
              userId: true,
              game: { select: { id: true, name: true, title: true, thumbnailUrl: true } },
            },
          })
          const userRecentGameMap = new Map(recentGamesPlayedByUser.map((s) => [s.userId, s.game]))

          for (const agg of highRollersAggregates) {
            if (agg.userId) {
              const userDetail = userMap.get(agg.userId)
              const recentGame = userRecentGameMap.get(agg.userId)
              final_high_rollers.push({
                id: agg.userId,
                userId: agg.userId,
                username: userDetail?.username || 'High Roller',
                avatar: userDetail?.avatar || null,
                gameId: recentGame?.id || null,
                gameName: recentGame?.name || recentGame?.name || 'Multiple Games',
                wagerAmount: agg._sum.totalWagered || 0,
                timestamp: agg._max.startTime || new Date(),
                currency_code: userDetail?.activeCurrencyType || 'N/A',
                description: `Wagered ${(agg._sum.totalWagered || 0) / 100} in total recently`,
                winAmount: 0, // Placeholder, adjust as needed
              })
            }
          }
        }
      }

      // Map OutputGameBigWinItem[] to PrismaGameBigWinItem[]
      function mapToPrismaGameBigWinItem(item: OutputGameBigWinItem): any {
        return {
          game_id: item.gameId ?? null,
          game_name: item.gameName ?? null,
          game_icon: null, // Set if available
          user_name: item.username ?? null,
          user_avatar: item.avatar ?? null,
          user_id: item.userId ?? null,
          win_amount: item.winAmount ?? 0,
          wager_amount: item.wagerAmount ?? 0,
          multiplier: item.multiplier ?? null,
          timestamp: item.timestamp ?? null,
          currency_code: (item as any).currency_code ?? null,
          description: (item as any).description ?? null,
        }
      }

      return {
        high_rollers: final_high_rollers
          .sort((a, b) => (b.wagerAmount || 0) - (a.wagerAmount || 0))
          .slice(0, finalDisplayLimit)
          .map(mapToPrismaGameBigWinItem),
        lucky_bets: diversifiedLuckyBets.map(mapToPrismaGameBigWinItem),
      }
    }),

  getFavoriteGames: protectedProcedure
    .output(z.array(z.string())) // Assuming it returns an array of game IDs (CUIDs)
    .handler(async ({ context }): Promise<string[]> => {
      const userId = context.session.user.id
      // You need a model to store user's favorite games, e.g., UserFavoriteGame
      // For example: model UserFavoriteGame { userId String, gameId String, @@id([userId, gameId]) }
      // const favorites = await _prisma.userFavoriteGame.findMany({
      //   where: { userId: userId },
      //   select: { gameId: true },
      // });
      // return favorites.map(f => f.gameId);
      return [] // Placeholder
    }),

  setFavoriteGame: protectedProcedure
    .input(SetFavoriteGameSchema)
    .output(z.object({ success: z.boolean() }))
    .handler(async ({ context, input }): Promise<{ success: boolean }> => {
      const userId = context.session.user.id
      const { gameId, isFavorite } = input

      // Again, depends on your UserFavoriteGame model
      // if (isFavorite) {
      //   await _prisma.userFavoriteGame.upsert({
      //     where: { userId_gameId: { userId, gameId } },
      //     create: { userId, gameId },
      //     update: {},
      //   });
      // } else {
      //   await _prisma.userFavoriteGame.deleteMany({
      //     where: { userId, gameId },
      //   });
      // }
      return { success: true } // Placeholder
    }),
}
