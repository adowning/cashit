import { PrismaClient, Role as PrismaRole } from '../generated/' // Adjust import if your generated client is elsewhere
import { faker } from '@faker-js/faker'

// Import your provided seeding functions
// Ensure these paths are correct relative to this index.ts file
import loadGames from './loadgames'
import seedProducts from './seedProducts'

// Import modular seed functions
// import { seedCurrencies } from './seedCurrency'
import { seedOperators } from './seedOperator'
import { seedUsersAndAccounts } from './seedAuth'
import { seedUserProfiles } from './seedUserProfiles'
import { seedVipInfos } from './seedVip'
import { seedWalletsAndTransactions } from './seedTransactions'
import { seedGameProviders } from './seedGameProviders'
import { seedGameLaunchLinks } from './seedGames' // For GameLaunchLinks if needed
import { seedGameSessionsAndSpins } from './seedGameSessionsAndSpins'
import { seedTournaments } from './seedTournaments'
import { seedTodos } from './seedTodo'

const prisma = new PrismaClient()

const tableNames = [
  // Order is important for TRUNCATE due to foreign keys.
  // Start with tables that are frequently referenced or have cascading deletes.
  // Leaf tables or tables with fewer outgoing relations first, or use CASCADE carefully.
  'TournamentGamePlay',
  'TournamentReward',
  'TournamentParticipant',
  'TournamentGame',
  'Tournament',
  'game_spins',
  'game_launch_links',
  'game_sessions', // UserProfile has a direct relation to currentGameSession
  'rebate_transactions',
  'transactions',
  'wallets',
  'operator_invitations',
  'products',
  'games',
  'GameProvider',
  'vip_infos', // UserProfile has a required relation to VipInfo
  'user_profiles',
  'operator_access_keys',
  'todo',
  'session', // Auth tables
  'account', // Auth tables
  'verification', // Auth tables (mapped name)
  'user', // Auth tables
]

async function truncateTables() {
  console.log('Attempting to truncate tables...')
  for (const tableName of tableNames.reverse()) {
    // Reverse order for truncate might be safer for dependencies
    try {
      await prisma.$executeRawUnsafe(`TRUNCATE TABLE "${tableName}" RESTART IDENTITY CASCADE;`)
      console.log(`Successfully truncated "${tableName}".`)
    } catch (error) {
      console.error(`Error truncating table "${tableName}":`, error)
      // Decide if you want to throw or continue
    }
  }
  console.log('Table truncation process finished.')
}

async function main() {
  console.log('Starting database seeding...')
  await truncateTables()

  // 1. Seed Currencies (Prerequisite for Products)
  // const defaultCurrency = await seedCurrencies(prisma)
  // if (!defaultCurrency) {
  //   console.error('Failed to seed currencies. Halting seed process.')
  //   return
  // }
  console.log(`Seeded currency: 'USD`)

  // 2. Seed Operators (Prerequisite for many other entities)
  const mainOperator = await seedOperators(prisma)
  if (!mainOperator) {
    console.error('Failed to seed operators. Halting seed process.')
    return
  }
  console.log(`Seeded operator: ${mainOperator.name}`)

  // 3. Seed Users (Admin and Regular Users)
  const { adminUser, users: regularUsers } = await seedUsersAndAccounts(prisma)
  console.log(`Seeded 1 admin and ${regularUsers.length} regular users.`)
  const allSeededUsers = [adminUser, ...regularUsers].filter((u) => u) // Filter out potential nulls if admin wasn't created

  if (allSeededUsers.length === 0) {
    console.error('No users were seeded. Halting profile and subsequent seeding.')
    return
  }

  // 4. Seed UserProfiles & VipInfos (VipInfo is created within seedUserProfiles due to strict relation)
  const userProfiles = await seedUserProfiles(prisma, allSeededUsers, mainOperator.id, 'USD')
  console.log(`Seeded ${userProfiles.length} user profiles (includes VIP info stubs).`)

  // 5. Update/Enrich VipInfos (optional, if seedUserProfiles only created stubs)
  // const vipInfos = await seedVipInfos(prisma, userProfiles); // seedVipInfos can now primarily update
  // console.log(`Updated/Enriched ${vipInfos.length} VIP infos.`);

  // 6. Seed Wallets and initial Transactions (e.g., initial deposits)
  const { wallets, transactions } = await seedWalletsAndTransactions(
    prisma,
    userProfiles,
    mainOperator.id,
    2,
    5
  )
  console.log(`Seeded ${wallets.length} wallets and ${transactions.length} initial transactions.`)

  // 7. Seed Game Providers
  const gameProviders = await seedGameProviders(prisma)
  console.log(`Seeded ${gameProviders.length} game providers.`)

  // 8. Load Products (using your provided script)
  try {
    const products = await seedProducts(prisma, { id: mainOperator.id }, 'USD')
    console.log(`Loaded ${products.length} products using seedProducts.ts.`)
  } catch (e) {
    console.error('Error loading products with seedProducts.ts:', e)
  }

  // 9. Load Games (using your provided script)
  let loadedGames: any[] = []
  try {
    loadedGames = await loadGames(prisma, { id: mainOperator.id })
    console.log(`Loaded ${loadedGames.length} games using loadgames.ts.`)
  } catch (e) {
    console.error('Error loading games with loadgames.ts:', e)
  }

  const allGamesFromDb = await prisma.game.findMany({ where: { operatorId: mainOperator.id } })
  if (allGamesFromDb.length === 0) {
    console.warn(
      'No games found in DB after loading. Subsequent game-related seeds might be empty.'
    )
  } else {
    // 10. Seed Game Launch Links (Optional, if needed)
    // await seedGameLaunchLinks(prisma, allGamesFromDb, userProfiles, [mainOperator]);

    // 11. Seed Game Sessions and Spins (more casino activity)
    const { gameSessions, gameSpins } = await seedGameSessionsAndSpins(
      prisma,
      userProfiles,
      allGamesFromDb,
      1,
      3,
      5,
      20
    )
    console.log(`Seeded ${gameSessions.length} game sessions and ${gameSpins.length} game spins.`)

    // 12. Seed Tournaments
    const tournaments = await seedTournaments(prisma, allGamesFromDb, userProfiles, mainOperator.id) // Pass adminUser.id or operator.id as creator
    console.log(`Seeded ${tournaments.length} tournaments and related data.`)
  }

  // 13. Seed Todos
  const todos = await seedTodos(prisma, 5)
  console.log(`Seeded ${todos.length} todos.`)

  console.log('Database seeding completed successfully! 🌱')
}

main()
  .catch((e) => {
    console.error('Error during seeding:', e)
    process.exit(1)
  })
  .finally(async () => {
    await prisma.$disconnect()
  })
