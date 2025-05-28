import {
  PrismaClient,
  Tournament,
  TournamentGame,
  TournamentParticipant,
  TournamentReward,
  TournamentStatus,
  Game,
  UserProfile,
  TournamentGamePlay,
  Role,
} from '../generated/'
import { faker } from '@faker-js/faker'

export async function seedTournaments(
  prisma: PrismaClient,
  allGames: Game[],
  userProfiles: UserProfile[],
  creatorUserId: string // ID of the admin user or operator system user
): Promise<Tournament[]> {
  console.log('Seeding tournaments...')
  if (allGames.length < 3) {
    console.log('Not enough games for varied tournaments. Skipping.')
    return []
  }
  const createdTournaments: Tournament[] = []

  const tournamentTypes = [
    {
      namePrefix: 'Weekly Slot Masters',
      durationDays: 7,
      status: TournamentStatus.ACTIVE,
      gamesCount: 3,
      targetScoreBase: 100000,
    },
    {
      namePrefix: 'Daily Dash',
      durationDays: 1,
      status: TournamentStatus.COMPLETED,
      gamesCount: 2,
      targetScoreBase: 20000,
    },
    {
      namePrefix: 'Upcoming Weekend Bonanza',
      durationDays: 3,
      status: TournamentStatus.PENDING,
      gamesCount: 5,
      targetScoreBase: 50000,
    },
  ]

  const adminUserProfile = userProfiles.find((up) => up.role === Role.ADMIN)

  for (const type of tournamentTypes) {
    const startTime =
      type.status === TournamentStatus.PENDING
        ? faker.date.soon({ days: 5 })
        : faker.date.recent({ days: type.durationDays })

    let endTimeCalc: Date | null = null
    if (type.status === TournamentStatus.COMPLETED) {
      endTimeCalc = new Date(
        startTime.getTime() + type.durationDays * 24 * 60 * 60 * 1000 - 60 * 60 * 1000
      ) // Ended an hour ago
    } else if (
      type.status === TournamentStatus.ACTIVE ||
      type.status === TournamentStatus.PENDING
    ) {
      endTimeCalc = new Date(startTime.getTime() + type.durationDays * 24 * 60 * 60 * 1000)
    }

    const tournament = await prisma.tournament.create({
      data: {
        name: `${type.namePrefix} - ${faker.lorem.words(2)}`,
        description: faker.lorem.sentence(),
        startTime,
        endTime: endTimeCalc,
        targetScore: faker.number.int({ min: type.targetScoreBase, max: type.targetScoreBase * 2 }),
        status: type.status,
        userId: adminUserProfile?.userId || null, // Link to admin user if available
      },
    })
    createdTournaments.push(tournament)

    const eligibleGames = faker.helpers.arrayElements(
      allGames.filter((g) => g.operatorId === adminUserProfile?.operatorId),
      { min: 1, max: type.gamesCount }
    )
    if (eligibleGames.length === 0 && allGames.length > 0) {
      // Fallback if no games match operator
      eligibleGames.push(...faker.helpers.arrayElements(allGames, { min: 1, max: type.gamesCount }))
    }

    for (const game of eligibleGames) {
      await prisma.tournamentGame.create({
        data: {
          tournamentId: tournament.id,
          gameId: game.id,
          pointMultiplier: faker.helpers.arrayElement([1.0, 1.2, 1.5, 0.8]),
        },
      })
    }

    const participantsForTournament = faker.helpers.arrayElements(
      userProfiles.filter((up) => up.role === Role.USER),
      { min: Math.min(3, userProfiles.length - 1), max: Math.min(10, userProfiles.length - 1) }
    )
    for (const profile of participantsForTournament) {
      if (tournament.status === TournamentStatus.PENDING && faker.datatype.boolean(0.7)) continue
      if (startTime > new Date()) continue // Skip if tournament hasn't started yet
      const participant = await prisma.tournamentParticipant.create({
        data: {
          tournamentId: tournament.id,
          userId: profile.userId,
          score: 0,
          joinedAt: faker.date.between({ from: startTime, to: new Date() }),
        },
      })

      let totalScoreForParticipant = 0
      if (tournament.status !== TournamentStatus.PENDING) {
        const numGamePlays = faker.number.int({ min: 5, max: 30 })
        for (let k = 0; k < numGamePlays; k++) {
          const pointsEarned = faker.number.int({ min: 10, max: 500 })
          totalScoreForParticipant += pointsEarned
          if (eligibleGames.length > 0) {
            await prisma.tournamentGamePlay.create({
              data: {
                tournamentParticipantId: participant.id,
                gameId: faker.helpers.arrayElement(eligibleGames).id,
                pointsEarned: pointsEarned,
                playedAt: faker.date.between({
                  from: startTime,
                  to: endTimeCalc && endTimeCalc < new Date() ? endTimeCalc : new Date(),
                }),
              },
            })
          }
        }
        await prisma.tournamentParticipant.update({
          where: { id: participant.id },
          data: { score: totalScoreForParticipant },
        })
      }
    }

    const ranksToReward = [1, 2, 3]
    for (const rank of ranksToReward) {
      await prisma.tournamentReward.create({
        data: {
          tournamentId: tournament.id,
          rank: rank,
          description: `Rank ${rank} Prize: ${faker.commerce.price({ min: 10, max: 500, dec: 0, symbol: '$' })} Bonus Credits`,
          isClaimed:
            tournament.status === TournamentStatus.COMPLETED ? faker.datatype.boolean(0.5) : false,
        },
      })
    }
  }

  console.log(`Seeded ${createdTournaments.length} tournaments.`)
  return createdTournaments
}
