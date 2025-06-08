import {
  JoinTournamentResponse as JoinTournamentResponseShared,
  PrismaTournament,
  PrismaTournamentParticipant,
  PrismaTournamentReward,
  TournamentCore,
  TournamentDetailed,
  TournamentParticipantInfo,
  TournamentStatus,
} from 'shared/dist'
import z from 'zod/v4'
import prisma from '../../prisma/index'
import { protectedProcedure, publicProcedure } from '../lib/orpc'

// Zod Schemas for input validation, mirroring shared types
const ListTournamentsQuerySchema = z
  .object({
    status: z.enum(TournamentStatus).optional(),
    gameId: z.cuid().optional(),
    activeNow: z.boolean().optional(),
  })
  .optional()

const TournamentIdSchema = z.object({
  tournamentId: z.string().min(1),
})

// Helper function to map Prisma Tournament to TournamentCore
const mapPrismaTournamentToTournamentCore = (
  tournament: PrismaTournament & {
    participants?: PrismaTournamentParticipant[]
    TournamentGames?: any[]
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
    // prizeFund is not directly in PrismaTournament, might need to be calculated or added
    prizeFund:
      tournament.rewards?.reduce(
        (acc, reward) =>
          acc + (reward.description.includes('USD') ? parseInt(reward.description) : 0),
        0
      ) || 'Dynamic',
  }
}

export const tournamentRouter: any = {
  list: publicProcedure
    .input(ListTournamentsQuerySchema)
    .handler(async ({ input }): Promise<TournamentCore[]> => {
      const whereClause: any = {}
      if (input?.status) {
        whereClause.status = input.status as TournamentStatus
      }
      if (input?.gameId) {
        whereClause.TournamentGames = { some: { A: input.gameId } }
      }
      if (input?.activeNow) {
        const now = new Date()
        whereClause.startTime = { lte: now }
        whereClause.endTime = { gte: now }
        whereClause.status = TournamentStatus.ACTIVE
      }

      const tournaments = await prisma.tournament.findMany({
        where: whereClause,
        include: {
          participants: true, // For participantCount
          tournamentGames: { include: { games: true } },
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
      const tournament = (await prisma.tournament.findUnique({
        where: { id: input.tournamentId },
        include: {
          tournamentGames: { include: { games: true } },
          rewards: { include: { winner: true } },
          participants: {
            include: { user: true },
            orderBy: { score: 'desc' },
          },
          user: true, // For createdBy
        },
      })) as TournamentDetailed | null

      if (!tournament) return null

      return {
        ...mapPrismaTournamentToTournamentCore(tournament),
        eligibleGames: (tournament as any).TournamentGames.map(
          (tg: { A: any; games: { name: any; thumbnailUrl: any } }) => ({
            gameId: tg.A,
            name: tg.games?.name ?? 'Unknown Game',
            pointMultiplier: 1.0, // Default multiplier since TournamentGames doesn't have this field
            thumbnailUrl: tg.games?.thumbnailUrl ?? undefined,
          })
        ),
        rewards: tournament.rewards.map((r) => ({
          id: r.id,
          rank: r.rank,
          description: r.description,
          isClaimed: r.isClaimed,
          winnerId: r.winnerId,
          winnerUsername: r.winner?.username,
        })),
        participants: tournament.participants?.map((p) => ({
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
        tournamentId: z.string().min(1),
        limit: z.number().int().min(1).max(100).optional().default(10),
        offset: z.number().int().min(0).optional().default(0),
      })
    )
    .handler(async ({ input }): Promise<TournamentParticipantInfo[]> => {
      const participants = await prisma.tournamentParticipant.findMany({
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

      const tournament = await prisma.tournament.findUnique({
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

      const existingParticipant = await prisma.tournamentParticipant.findUnique({
        where: { tournamentId_userId: { tournamentId, userId } },
      })

      if (existingParticipant) {
        throw new Error('User already joined this tournament.')
      }

      const participant = await prisma.tournamentParticipant.create({
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
