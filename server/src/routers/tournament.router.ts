import z from 'zod/v4'
import prisma from '../../prisma/index'
import { protectedProcedure, publicProcedure } from '../lib/orpc'
import type { ExtendedPrismaClient } from '../../prisma'
import {
  TournamentCore,
  TournamentDetailed,
  TournamentParticipantInfo,
  JoinTournamentResponse as JoinTournamentResponseShared,
  TournamentStatus,
  PrismaTournament,
  // PrismaTournamentGame, // Removed
  PrismaGame, // Added
  PrismaTournamentReward,
  PrismaTournamentParticipant,
} from 'shared/dist'
import { Prisma } from '../../prisma/generated/client'

const _prisma: ExtendedPrismaClient = prisma

// Zod Schemas for input validation, mirroring shared types
const ListTournamentsQuerySchema = z
  .object({
    status: z.nativeEnum(TournamentStatus).optional(),
    gameId: z.string().cuid().optional(),
    activeNow: z.boolean().optional(),
  })
  .optional()

const GetTournamentLeaderboardQuerySchema = z
  .object({
    limit: z.number().int().min(1).max(100).optional(),
    offset: z.number().int().min(0).optional(),
  })
  .optional()

const TournamentIdSchema = z.object({
  tournamentId: z.string().cuid(),
})

// Helper function to map Prisma Tournament to TournamentCore
const mapPrismaTournamentToTournamentCore = (
  tournament: PrismaTournament & {
    participants?: PrismaTournamentParticipant[]
    games?: PrismaGame[] // Changed from eligibleGames
    rewards?: PrismaTournamentReward[]
  }
): TournamentCore => {
  return {
    id: tournament.id,
    name: tournament.name,
    description: tournament.description,
    startTime: tournament.startTime.toISOString(),
    endTime: tournament.endTime?.toISOString() || null,
    targetScore: tournament.targetScore,
    status: tournament.status as TournamentStatus, // Prisma enum should match shared enum
    participantCount: tournament.participants?.length ?? 0,
    // prizeFund calculation might need to check tournament.games if it was relying on eligibleGames.
    // For now, assuming it's based on rewards.
    prizeFund:
      tournament.rewards?.reduce(
        (acc, reward) =>
          acc + (reward.description.includes('USD') ? parseInt(reward.description) : 0),
        0
      ) || 'Dynamic',
  }
}

export const tournamentRouter = {
  list: publicProcedure
    .input(ListTournamentsQuerySchema)
    .handler(async ({ input }): Promise<TournamentCore[]> => {
      const whereClause: Prisma.TournamentWhereInput = {}
      if (input?.status) {
        whereClause.status = input.status as TournamentStatus
      }
      if (input?.gameId) {
        whereClause.games = { some: { id: input.gameId } } // Changed from eligibleGames
      }
      if (input?.activeNow) {
        const now = new Date()
        whereClause.startTime = { lte: now }
        whereClause.endTime = { gte: now }
        whereClause.status = TournamentStatus.ACTIVE
      }

      const tournaments = await _prisma.tournament.findMany({
        where: whereClause,
        include: {
          participants: true, // For participantCount
          games: true, // Changed from eligibleGames
          rewards: true, // For prizeFund (example calculation)
        },
        orderBy: {
          startTime: 'desc',
        },
      })
      return tournaments.map(mapPrismaTournamentToTournamentCore)
    }),

  getDetails: publicProcedure
    .input(TournamentIdSchema)
    .handler(async ({ input }): Promise<TournamentDetailed | null> => {
      const tournament = await _prisma.tournament.findUnique({
        where: { id: input.tournamentId },
        include: {
          games: { // Changed from eligibleGames
            select: { id: true, name: true, thumbnailUrl: true, tournamentDirectives: true },
          },
          rewards: { include: { winner: true } },
          participants: {
            include: { user: true },
            orderBy: { score: 'desc' },
          },
          user: true, // For createdBy
        },
      })

      if (!tournament) return null

      return {
        ...mapPrismaTournamentToTournamentCore(tournament),
        eligibleGames: tournament.games.map((game) => {
          let pointMultiplier = 1.0
          if (game.tournamentDirectives) {
            // Assuming tournamentDirectives is already parsed by Prisma if Json type is handled well
            // If not, parse it:
            // const directives = typeof game.tournamentDirectives === 'string' ? JSON.parse(game.tournamentDirectives) : game.tournamentDirectives;
            const directives = game.tournamentDirectives as Array<{
              tournamentId: string
              pointMultiplier: number
            }> // Type assertion
            const directive = directives?.find((d) => d.tournamentId === tournament.id)
            if (directive) {
              pointMultiplier = directive.pointMultiplier
            }
          }
          return {
            gameId: game.id, // gameId is now game.id
            name: game.name ?? 'Unknown Game',
            pointMultiplier: pointMultiplier,
            thumbnailUrl: game.thumbnailUrl ?? undefined,
          }
        }),
        rewards: tournament.rewards.map((r) => ({
          id: r.id,
          rank: r.rank,
          description: r.description,
          isClaimed: r.isClaimed,
          winnerId: r.winnerId,
          winnerUsername: r.winner?.username,
        })),
        participants: tournament.participants.map((p) => ({
          userId: p.userId,
          username: p.user?.username ?? 'Unknown User',
          avatarUrl: p.user?.avatar,
          score: p.score,
          rank: p.rank,
          joinedAt: p.joinedAt.toISOString(),
        })),
        createdBy: tournament.user
          ? { id: tournament.user.id, username: tournament.user.username }
          : undefined,
        createdAt: tournament.createdAt.toISOString(),
        updatedAt: tournament.updatedAt.toISOString(),
      }
    }),

  getLeaderboard: publicProcedure
    .input(
      z.object({
        tournamentId: z.string().cuid(),
        limit: z.number().int().min(1).max(100).optional().default(10),
        offset: z.number().int().min(0).optional().default(0),
      })
    )
    .handler(async ({ input }): Promise<TournamentParticipantInfo[]> => {
      const participants = await _prisma.tournamentParticipant.findMany({
        where: { tournamentId: input.tournamentId },
        include: { user: true },
        orderBy: { score: 'desc' },
        take: input.limit,
        skip: input.offset,
      })

      return participants.map((p, index) => ({
        userId: p.userId,
        username: p.user?.username ?? 'Unknown User',
        avatarUrl: p.user?.avatar,
        score: p.score,
        rank: input.offset + index + 1, // Calculate rank based on order and pagination
        joinedAt: p.joinedAt.toISOString(),
      }))
    }),

  join: protectedProcedure
    .input(TournamentIdSchema)
    .handler(async ({ context, input }): Promise<JoinTournamentResponseShared> => {
      const userId = context.session.user.id
      const { tournamentId } = input

      const tournament = await _prisma.tournament.findUnique({
        where: { id: tournamentId },
      })

      if (!tournament) {
        throw new Error('Tournament not found.')
      }
      if (
        tournament.status !== TournamentStatus.ACTIVE &&
        tournament.status !== TournamentStatus.PENDING
      ) {
        throw new Error('Tournament is not active or upcoming.')
      }
      if (tournament.endTime && tournament.endTime < new Date()) {
        throw new Error('Tournament has already ended.')
      }
      if (tournament.startTime > new Date() && tournament.status === TournamentStatus.PENDING) {
        // Allow joining pending tournaments
      } else if (tournament.status !== TournamentStatus.ACTIVE) {
        throw new Error('Tournament is not active for joining.')
      }

      const existingParticipant = await _prisma.tournamentParticipant.findUnique({
        where: { tournamentId_userId: { tournamentId, userId } },
      })

      if (existingParticipant) {
        throw new Error('User already joined this tournament.')
      }

      const participant = await _prisma.tournamentParticipant.create({
        data: {
          tournamentId,
          userId,
          score: 0,
          joinedAt: new Date(),
        },
        include: { user: true },
      })

      return {
        userId: participant.userId,
        username: participant.user?.username ?? 'Unknown User',
        avatarUrl: participant.user?.avatar,
        score: participant.score,
        rank: null, // Rank usually calculated later or on leaderboard fetch
        joinedAt: participant.joinedAt.toISOString(),
      }
    }),
}
