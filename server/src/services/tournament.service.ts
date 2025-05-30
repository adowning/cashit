// server/src/services/tournament.service.ts

import { Tournament, TournamentStatus, UserProfile } from 'prisma/generated'
import type { ExtendedPrismaClient } from '../../prisma' // Import Prisma namespace for input types
import {
  PrismaUserProfile as PrismaUserProfileType,
  UpdateUserInput as UpdateUserInputTypeShared, // Type from shared/dist for input structure
  SetReferrerDto as SetReferrerDtoTypeShared, // Type from shared/dist
  PaginatedResponse as PaginatedResponseType,
  // TournamentStatus,
  TournamentCreatedPayload,
  TournamentEndedPayload,
  TournamentLeaderboardUpdatedPayload,
  TournamentParticipantJoinedPayload,
  TournamentParticipantType,
  TournamentStartedPayload,
} from 'shared/dist'
import { Prisma } from 'prisma/generated'
import prisma from '../../prisma/index' // Your extended Prisma client
import { typedAppEventEmitter, AppEvents } from '@/lib/events'

const db: ExtendedPrismaClient = prisma
// Use Prisma's TournamentStatus enum directly for consistency
// If you have a local enum, ensure its values match Prisma's
// For this refactor, I will use TournamentStatus where applicable.

// --- Helper Types (consider moving to packages/types/src/interface/tournament.ts) ---
export interface CreateTournamentInput {
  name: string
  description?: string
  startTime: Date
  endTime?: Date
  targetScore?: number
  eligibleGames?: Array<{ gameId: string; pointMultiplier?: number }>
  rewards?: Array<{ rank: number; description: string /* other reward fields */ }>
  createdByUserId?: string // For linking to the admin user who created it
}

export interface UpdateTournamentInput {
  name?: string
  description?: string
  startTime?: Date
  endTime?: Date
  targetScore?: number
  status?: TournamentStatus // Use Prisma's enum
  // For simplicity, eligibleGames and rewards updates might need dedicated functions
  // or more complex logic (diffing, replacing) if supported here.
}

// --- Service Functions ---

/**
 * Creates a new tournament.
 */
export async function createTournament(
  adminUser: UserProfile, // Ensure UserProfile has 'id' and 'role'
  input: CreateTournamentInput
): Promise<Tournament> {
  if (adminUser.role !== 'ADMIN' && adminUser.role !== 'OWNER') {
    throw new Error('Unauthorized: Only admins or owners can create tournaments.')
  }

  const tournament = await db.tournament.create({
    data: {
      name: input.name,
      description: input.description,
      startTime: input.startTime,
      endTime: input.endTime,
      targetScore: input.targetScore,
      status: TournamentStatus.PENDING, // Use Prisma's enum
      createdByid: adminUser.id, // Link to the admin user who created it (schema field: createdByid)
      games: input.eligibleGames // Changed from eligibleGames
        ? {
            connect: input.eligibleGames.map((g) => ({ id: g.gameId })),
          }
        : undefined,
      rewards: input.rewards
        ? {
            create: input.rewards.map((r) => ({
              rank: r.rank,
              description: r.description,
              // ... other reward fields
            })),
          }
        : undefined,
    },
    include: { games: true, rewards: true }, // Changed from eligibleGames
  })

  // After creating the tournament, update game.tournamentDirectives
  if (input.eligibleGames) {
    for (const g of input.eligibleGames) {
      const gameToUpdate = await db.game.findUnique({ where: { id: g.gameId } })
      if (gameToUpdate) {
        let directives: any[] = []
        if (gameToUpdate.tournamentDirectives && Array.isArray(gameToUpdate.tournamentDirectives)) {
          directives = gameToUpdate.tournamentDirectives
        } else if (typeof gameToUpdate.tournamentDirectives === 'string') {
          try {
            const parsedDirectives = JSON.parse(gameToUpdate.tournamentDirectives)
            if (Array.isArray(parsedDirectives)) {
              directives = parsedDirectives
            }
          } catch (error) {
            console.error(
              `Error parsing tournamentDirectives for game ${g.gameId}:`,
              error
            )
            // Initialize as empty array if parsing fails
          }
        }
        // Remove old entry for this tournament, if any, then add new one
        directives = directives.filter(
          (d: any) => d.tournamentId !== tournament.id
        )
        directives.push({
          tournamentId: tournament.id,
          pointMultiplier: g.pointMultiplier ?? 1.0,
        })
        await db.game.update({
          where: { id: g.gameId },
          data: { tournamentDirectives: directives as Prisma.InputJsonValue }, // Use Prisma.InputJsonValue
        })
      }
    }
  }

  typedAppEventEmitter.emit(AppEvents.TOURNAMENT_CREATED, {
    tournamentId: tournament.id,
    name: tournament.name,
    startTime: tournament.startTime.toISOString(),
  } as TournamentCreatedPayload)

  return tournament
}

/**
 * Updates an existing tournament.
 */
export async function updateTournament(
  adminUser: UserProfile,
  tournamentId: string,
  input: UpdateTournamentInput
): Promise<Tournament> {
  if (adminUser.role !== 'ADMIN' && adminUser.role !== 'OWNER') {
    throw new Error('Unauthorized: Only admins or owners can update tournaments.')
  }

  const existingTournament = await db.tournament.findUnique({ where: { id: tournamentId } })
  if (!existingTournament) {
    throw new Error('Tournament not found.')
  }

  const updatedTournament = await db.tournament.update({
    where: { id: tournamentId },
    data: {
      name: input.name,
      description: input.description,
      startTime: input.startTime,
      endTime: input.endTime,
      targetScore: input.targetScore,
      status: input.status, // Uses Prisma's enum from input type
    },
    include: { games: true, rewards: true }, // Changed from eligibleGames
  })
  // Consider emitting a TOURNAMENT_UPDATED event
  return updatedTournament
}

/**
 * Lists tournaments based on filters.
 */
export async function listTournaments(filters: {
  status?: TournamentStatus // Use Prisma's enum
  gameId?: string
  activeNow?: boolean
}): Promise<Tournament[]> {
  const where: Prisma.TournamentWhereInput = {}
  if (filters.status) {
    where.status = filters.status
  }
  if (filters.gameId) {
    where.games = { some: { id: filters.gameId } } // Changed from eligibleGames
  }
  if (filters.activeNow) {
    const now = new Date()
    where.status = TournamentStatus.ACTIVE
    where.startTime = { lte: now }
    where.OR = [{ endTime: { gte: now } }, { endTime: null }]
  }

  return db.tournament.findMany({
    where,
    include: {
      games: { // Changed from eligibleGames
        select: { id: true, name: true, thumbnailUrl: true, tournamentDirectives: true },
      },
      participants: { select: { _count: true } },
      rewards: true,
    },
    orderBy: { startTime: 'asc' },
  })
}

/**
 * Gets details of a specific tournament.
 */
export async function getTournamentDetails(tournamentId: string): Promise<Tournament | null> {
  return db.tournament.findUnique({
    where: { id: tournamentId },
    include: {
      games: { // Changed from eligibleGames
        select: {
          id: true,
          name: true,
          title: true,
          thumbnailUrl: true,
          tournamentDirectives: true,
        },
      },
      participants: {
        orderBy: { score: 'desc' },
        take: 100,
        include: {
          user: { select: { id: true, username: true, avatar: true } }, // Select specific user fields
        },
      },
      rewards: { orderBy: { rank: 'asc' } },
    },
  })
}

/**
 * Allows a user to join an active tournament.
 */
export async function joinTournament(
  userId: string,
  tournamentId: string,
  tx?: Prisma.TransactionClient // Optional transaction client
): Promise<TournamentParticipantType> {
  const prismaClient = db

  const tournament = await db.tournament.findUnique({
    where: { id: tournamentId },
    select: { status: true, startTime: true, endTime: true },
  })

  if (!tournament) {
    throw new Error('Tournament not found.')
  }
  if (
    tournament.status !== TournamentStatus.ACTIVE &&
    tournament.status !== TournamentStatus.PENDING
  ) {
    throw new Error('Tournament is not open for joining.')
  }
  const now = new Date()
  if (tournament.startTime > now && tournament.status === TournamentStatus.PENDING) {
    // Allow joining PENDING tournaments before they start
  } else if (tournament.status !== TournamentStatus.ACTIVE) {
    throw new Error('Tournament is not active for joining.')
  }

  if (tournament.endTime && tournament.endTime <= now) {
    throw new Error('Tournament has already ended.')
  }

  const existingParticipant = await prismaClient.tournamentParticipant.findUnique({
    where: { tournamentId_userId: { tournamentId, userId } },
    include: { user: { select: { id: true, username: true, avatar: true } } }, // Specify user fields
  })

  if (existingParticipant) {
    return existingParticipant as TournamentParticipantType // User already joined
  }

  const participant = await prismaClient.tournamentParticipant.create({
    data: {
      tournamentId,
      userId,
      score: 0,
      joinedAt: now, // Set joinedAt explicitly
    },
    include: { user: { select: { id: true, username: true, avatar: true } } }, // Specify user fields
  })

  typedAppEventEmitter.emit(AppEvents.TOURNAMENT_PARTICIPANT_JOINED, {
    tournamentId,
    userId,
    username: participant.user.username, // username might be null based on User schema
  } as TournamentParticipantJoinedPayload)

  await publishLeaderboardUpdate(tournamentId)

  return participant as unknown as TournamentParticipantType
}

/**
 * Records points for a user in active tournaments for a specific game.
 * This function is designed to be called within a transaction initiated by the calling service (e.g., gameService).
 */
export async function recordTournamentPoints(
  userId: string,
  gameId: string, // The actual game ID from your Game model
  pointsEarnedInGame: number,
  gamePlayIdentifier: string, // e.g., gameSpinId, unique identifier for the game action
  tx: Prisma.TransactionClient, // Transaction client passed from the calling service
  _meta?: Prisma.InputJsonValue | null // Optional meta, not used here but matches signature from game.service
): Promise<void> {
  const now = new Date()
  // Use the provided transaction client (tx) for all database operations
  const activeParticipations = await tx.tournamentParticipant.findMany({
    where: {
      userId,
      tournament: {
        status: TournamentStatus.ACTIVE,
        startTime: { lte: now },
        OR: [{ endTime: { gte: now } }, { endTime: null }],
        games: { some: { id: gameId } }, // Changed from eligibleGames
      },
    },
    include: {
      tournament: {
        include: {
          games: { // Changed from eligibleGames
            where: { id: gameId },
            select: { id: true, tournamentDirectives: true },
          },
        },
      },
    },
  })

  if (activeParticipations.length === 0) {
    return // No active tournament participation for this game
  }

  for (const participation of activeParticipations) {
    const targetGame = participation.tournament.games.find((g) => g.id === gameId) // Changed from tournamentGame
    if (!targetGame) continue

    let pointMultiplier = 1.0
    if (targetGame.tournamentDirectives) {
      // Assuming tournamentDirectives is already parsed by Prisma if Json type is handled well
      // Or parse if string:
      // const directives = typeof targetGame.tournamentDirectives === 'string' ? JSON.parse(targetGame.tournamentDirectives) : targetGame.tournamentDirectives;
      const directives = targetGame.tournamentDirectives as Array<{
        tournamentId: string
        pointMultiplier: number
      }>
      const directive = directives?.find(
        (d) => d.tournamentId === participation.tournamentId
      )
      if (directive) {
        pointMultiplier = directive.pointMultiplier
      }
    }

    const pointsForTournament = Math.floor(pointsEarnedInGame * pointMultiplier)

    if (pointsForTournament <= 0) continue

    // All operations for a single participation update are already within the $transaction block in the old code
    // but since `tx` is passed, this specific $transaction is redundant if `tx` itself IS a transaction.
    // If `recordTournamentPoints` is always called within an existing transaction,
    // we can directly use `tx` for its operations.

    const updatedParticipant = await tx.tournamentParticipant.update({
      where: { id: participation.id },
      data: {
        score: { increment: pointsForTournament },
      },
    })

    await tx.tournamentGamePlay.create({
      data: {
        tournamentParticipantId: participation.id,
        gameId: gameId,
        pointsEarned: pointsForTournament,
        playedAt: now,
        gameSessionId: gamePlayIdentifier, // Schema uses gameSessionId, mapping gamePlayIdentifier here
      },
    })

    if (
      participation.tournament.targetScore &&
      updatedParticipant.score >= participation.tournament.targetScore
    ) {
      const currentTournament = await tx.tournament.findUnique({
        // Use tx
        where: { id: participation.tournamentId },
      })
      if (currentTournament && currentTournament.status === TournamentStatus.ACTIVE) {
        await processTournamentEnd(participation.tournamentId, tx) // Pass the transaction client
      }
    }
    // publishLeaderboardUpdate should ideally not be awaited if it involves external calls
    // that could fail and roll back the transaction. Consider doing it outside the loop or after the main transaction.
    // For now, keeping it as is but noting this. It should also use `tx` if it reads data that must be consistent with the transaction.
    await publishLeaderboardUpdate(participation.tournamentId, tx)
  }
}

/**
 * Gets the leaderboard for a tournament.
 */
export async function getTournamentLeaderboard(
  tournamentId: string,
  limit: number = 100
  // tx?: Prisma.TransactionClient // Allow passing transaction client for consistency
): Promise<TournamentParticipantType[]> {
  const prismaClient = db
  return prismaClient.tournamentParticipant.findMany({
    where: { tournamentId },
    orderBy: [{ score: 'desc' }, { joinedAt: 'asc' }],
    take: limit,
    include: {
      user: {
        select: { id: true, username: true, avatar: true }, // Select specific fields
      },
    },
  }) as unknown as TournamentParticipantType[] // Casting might be needed if Prisma's generated type isn't identical
}

/**
 * Publishes leaderboard updates via WebSocket.
 */
async function publishLeaderboardUpdate(tournamentId: string, tx?: Prisma.TransactionClient) {
  // Pass tx to getTournamentLeaderboard to read within the same transaction if called from recordTournamentPoints
  const leaderboard = await getTournamentLeaderboard(tournamentId, 20)
  typedAppEventEmitter.emit(AppEvents.TOURNAMENT_LEADERBOARD_UPDATED, {
    tournamentId,
    leaderboard: leaderboard.map((p) => ({
      userId: p.userId,
      username: p.user.username || 'Player', // User.username can be null
      score: p.score,
      rank: p.rank,
      avatarUrl: p.user.avatar,
    })),
  } as TournamentLeaderboardUpdatedPayload)
}

/**
 * Processes the start of a tournament.
 */
export async function processTournamentStart(
  tournamentId: string
  // tx?: Prisma.TransactionClient
): Promise<void> {
  const prismaClient = db
  const tournament = await prismaClient.tournament.findUnique({ where: { id: tournamentId } })

  if (!tournament || tournament.status !== TournamentStatus.PENDING) {
    console.warn(`Tournament ${tournamentId} not found or not in PENDING state for start.`)
    return
  }
  const now = new Date()
  if (tournament.startTime > now) {
    console.warn(
      `Tournament ${tournamentId} start time (${tournament.startTime}) is in the future.`
    )
    return
  }

  await prismaClient.tournament.update({
    where: { id: tournamentId },
    data: { status: TournamentStatus.ACTIVE },
  })

  typedAppEventEmitter.emit(AppEvents.TOURNAMENT_STARTED, {
    tournamentId,
    name: tournament.name,
    endTime: tournament.endTime?.toISOString(),
  } as TournamentStartedPayload)
  console.log(`Tournament ${tournamentId} (${tournament.name}) started.`)
}

/**
 * Processes the end of a tournament.
 */
export async function processTournamentEnd(
  tournamentId: string,
  tx?: Prisma.TransactionClient
): Promise<void> {
  const prismaClient = db

  const tournament = await prismaClient.tournament.findUnique({
    where: { id: tournamentId },
    include: { rewards: { orderBy: { rank: 'asc' } } },
  })

  if (!tournament || tournament.status !== TournamentStatus.ACTIVE) {
    console.warn(`Tournament ${tournamentId} not found or not in ACTIVE state for ending.`)
    return
  }
  const now = new Date()
  if (tournament.endTime && tournament.endTime > now && !tournament.targetScore) {
    console.warn(`Tournament ${tournamentId} end time is in the future and target score not met.`)
    return
  }

  await prismaClient.tournament.update({
    where: { id: tournamentId },
    data: { status: TournamentStatus.COMPLETED },
  })

  const participants = await prismaClient.tournamentParticipant.findMany({
    where: { tournamentId },
    orderBy: [{ score: 'desc' }, { joinedAt: 'asc' }],
    include: { user: { select: { id: true, username: true } } }, // include user for username in event
  })

  const rankedParticipants = participants.map((p, index) => ({ ...p, rank: index + 1 }))

  for (const participant of rankedParticipants) {
    await prismaClient.tournamentParticipant.update({
      where: { id: participant.id },
      data: { rank: participant.rank },
    })
  }

  for (const reward of tournament.rewards) {
    const winnerForRank = rankedParticipants.find((p) => p.rank === reward.rank)
    if (winnerForRank) {
      await prismaClient.tournamentReward.update({
        where: { id: reward.id },
        data: { winnerId: winnerForRank.userId },
      })
      // Consider creating a UserReward or similar notification/record for the winner here
    }
  }

  typedAppEventEmitter.emit(AppEvents.TOURNAMENT_ENDED, {
    tournamentId,
    name: tournament.name,
    results: rankedParticipants.map((p) => ({
      userId: p.userId,
      username: p.user.username || 'Player', // User.username can be null
      score: p.score,
      rank: p.rank,
    })),
  } as TournamentEndedPayload) // Ensure TournamentEndedPayload matches this structure
  console.log(`Tournament ${tournamentId} (${tournament.name}) ended and processed.`)
}

export function initTournamentScheduler() {
  console.log('Initializing Tournament Scheduler...')
  setInterval(async () => {
    const now = new Date()
    try {
      const pendingTournaments = await db.tournament.findMany({
        where: { status: TournamentStatus.PENDING, startTime: { lte: now } },
      })
      for (const t of pendingTournaments) {
        await processTournamentStart(t.id)
      }

      const activeTournamentsToEnd = await db.tournament.findMany({
        where: {
          status: TournamentStatus.ACTIVE,
          endTime: { lte: now },
          // This logic for targetScore might need refinement.
          // If a targetScore ends a tournament, that's handled in recordTournamentPoints.
          // This scheduler part primarily handles time-based endings.
        },
      })
      for (const t of activeTournamentsToEnd) {
        if (t.targetScore && t.status === TournamentStatus.ACTIVE) {
          // If a target score exists but wasn't met to auto-end via recordTournamentPoints,
          // and time is up, we end it here.
        }
        await processTournamentEnd(t.id)
      }
    } catch (error) {
      console.error('Error in tournament scheduler:', error)
    }
  }, 60 * 1000)
  console.log('Tournament scheduler initialized and running.')
}

// Utility to fetch tournament by ID, useful for routes or other services
export async function getTournamentById(tournamentId: string, tx?: Prisma.TransactionClient) {
  const prismaClient = db
  return prismaClient.tournament.findUnique({
    where: { id: tournamentId },
    include: {
      games: { // Changed from eligibleGames
        select: { id: true, name: true, thumbnailUrl: true, tournamentDirectives: true },
      },
      participants: { include: { user: true } },
      rewards: true,
      // createdBy: true, // This relation might need to be 'user' depending on your schema
    },
  })
}
