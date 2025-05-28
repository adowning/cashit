#!/bin/bash

# Create the seed directory if it doesn't exist
mkdir -p /tmp/testapp/server/prisma/seed

# --- /tmp/testapp/server/prisma/seed/index.ts ---
cat << 'EOF_INDEX_TS' > /tmp/testapp/server/prisma/seed/index.ts
import { PrismaClient, Role as PrismaRole } from '@prisma/client'; // Adjust import if your generated client is elsewhere
import { faker } from '@faker-js/faker';

// Import your provided seeding functions
// Ensure these paths are correct relative to this index.ts file
import loadGames from './loadgames';
import seedProducts from './seedProducts';

// Import modular seed functions
import { seedCurrencies } from './seedCurrency';
import { seedOperators } from './seedOperator';
import { seedUsers } from './seedAuth';
import { seedUserProfiles } from './seedUserProfiles';
import { seedVipInfos } from './seedVip';
import { seedWalletsAndTransactions } from './seedTransactions';
import { seedGameProviders } from './seedGameProviders';
import { seedGameLaunchLinks } from './seedGames'; // For GameLaunchLinks if needed
import { seedGameSessionsAndSpins } from './seedGameSessionsAndSpins';
import { seedTournaments } from './seedTournaments';
import { seedTodos } from './seedTodo';

const prisma = new PrismaClient();

const tableNames = [
  // Order is important for TRUNCATE due to foreign keys.
  // Start with tables that are frequently referenced or have cascading deletes.
  // Leaf tables or tables with fewer outgoing relations first, or use CASCADE carefully.
  "TournamentGamePlay",
  "TournamentReward",
  "TournamentParticipant",
  "TournamentGame",
  "Tournament",
  "game_spins",
  "game_launch_links",
  "game_sessions", // UserProfile has a direct relation to currentGameSession
  "rebate_transactions",
  "transactions",
  "wallets",
  "operator_invitations",
  "products",
  "games",
  "GameProvider",
  "vip_infos", // UserProfile has a required relation to VipInfo
  "user_profiles",
  "operator_access_keys",
  "todo",
  "Currency",
  "Session", // Auth tables
  "Account", // Auth tables
  "Verification", // Auth tables (mapped name)
  "user", // Auth tables
];

async function truncateTables() {
  console.log('Attempting to truncate tables...');
  for (const tableName of tableNames.reverse()) { // Reverse order for truncate might be safer for dependencies
    try {
      await prisma.$executeRawUnsafe(`TRUNCATE TABLE "${tableName}" RESTART IDENTITY CASCADE;`);
      console.log(`Successfully truncated "${tableName}".`);
    } catch (error) {
      console.error(`Error truncating table "${tableName}":`, error);
      // Decide if you want to throw or continue
    }
  }
  console.log('Table truncation process finished.');
}

async function main() {
  console.log('Starting database seeding...');
  await truncateTables();

  // 1. Seed Currencies (Prerequisite for Products)
  const defaultCurrency = await seedCurrencies(prisma);
  if (!defaultCurrency) {
    console.error("Failed to seed currencies. Halting seed process.");
    return;
  }
  console.log(`Seeded currency: ${defaultCurrency.code}`);

  // 2. Seed Operators (Prerequisite for many other entities)
  const mainOperator = await seedOperators(prisma);
  if (!mainOperator) {
    console.error("Failed to seed operators. Halting seed process.");
    return;
  }
  console.log(`Seeded operator: ${mainOperator.name}`);

  // 3. Seed Users (Admin and Regular Users)
  const { adminUser, users: regularUsers } = await seedUsers(prisma);
  console.log(`Seeded 1 admin and ${regularUsers.length} regular users.`);
  const allSeededUsers = [adminUser, ...regularUsers].filter(u => u); // Filter out potential nulls if admin wasn't created

  if (allSeededUsers.length === 0) {
      console.error("No users were seeded. Halting profile and subsequent seeding.");
      return;
  }

  // 4. Seed UserProfiles & VipInfos (VipInfo is created within seedUserProfiles due to strict relation)
  const userProfiles = await seedUserProfiles(prisma, allSeededUsers, mainOperator.id, defaultCurrency.code);
  console.log(`Seeded ${userProfiles.length} user profiles (includes VIP info stubs).`);

  // 5. Update/Enrich VipInfos (optional, if seedUserProfiles only created stubs)
  // const vipInfos = await seedVipInfos(prisma, userProfiles); // seedVipInfos can now primarily update
  // console.log(`Updated/Enriched ${vipInfos.length} VIP infos.`);


  // 6. Seed Wallets and initial Transactions (e.g., initial deposits)
  const { wallets, transactions } = await seedWalletsAndTransactions(prisma, userProfiles, mainOperator.id, 2, 5);
  console.log(`Seeded ${wallets.length} wallets and ${transactions.length} initial transactions.`);

  // 7. Seed Game Providers
  const gameProviders = await seedGameProviders(prisma);
  console.log(`Seeded ${gameProviders.length} game providers.`);

  // 8. Load Products (using your provided script)
  try {
    const products = await seedProducts(prisma, { id: mainOperator.id }, defaultCurrency.id);
    console.log(`Loaded ${products.length} products using seedProducts.ts.`);
  } catch (e) {
    console.error("Error loading products with seedProducts.ts:", e);
  }

  // 9. Load Games (using your provided script)
  let loadedGames: any[] = [];
  try {
    loadedGames = await loadGames(prisma, { id: mainOperator.id });
    console.log(`Loaded ${loadedGames.length} games using loadgames.ts.`);
  } catch (e) {
    console.error("Error loading games with loadgames.ts:", e);
  }
  
  const allGamesFromDb = await prisma.game.findMany({ where: { operatorId: mainOperator.id } });
  if (allGamesFromDb.length === 0) {
    console.warn("No games found in DB after loading. Subsequent game-related seeds might be empty.");
  } else {
    // 10. Seed Game Launch Links (Optional, if needed)
    // await seedGameLaunchLinks(prisma, allGamesFromDb, userProfiles, [mainOperator]);

    // 11. Seed Game Sessions and Spins (more casino activity)
    const { gameSessions, gameSpins } = await seedGameSessionsAndSpins(prisma, userProfiles, allGamesFromDb, 1, 3, 5, 20);
    console.log(`Seeded ${gameSessions.length} game sessions and ${gameSpins.length} game spins.`);

    // 12. Seed Tournaments
    const tournaments = await seedTournaments(prisma, allGamesFromDb, userProfiles, mainOperator.id); // Pass adminUser.id or operator.id as creator
    console.log(`Seeded ${tournaments.length} tournaments and related data.`);
  }

  // 13. Seed Todos
  const todos = await seedTodos(prisma, 5);
  console.log(`Seeded ${todos.length} todos.`);

  console.log('Database seeding completed successfully! 🌱');
}

main()
  .catch((e) => {
    console.error('Error during seeding:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
EOF_INDEX_TS
echo "✅ Created /tmp/testapp/server/prisma/seed/index.ts"

# --- /tmp/testapp/server/prisma/seed/seedCurrency.ts ---
cat << 'EOF_SEED_CURRENCY_TS' > /tmp/testapp/server/prisma/seed/seedCurrency.ts
import { PrismaClient, Currency } from '@prisma/client';
import { faker } from '@faker-js/faker';

// Ensure you have a Currency model in your schema.prisma, for example:
// model Currency {
//   id            String    @id @default(cuid())
//   name          String    @unique
//   code          String    @unique // e.g., USD, EUR
//   symbol        String    // e.g., $, €
//   exchangeRate  Float     @default(1.0)
//   isActive      Boolean   @default(true)
//   createdAt     DateTime  @default(now())
//   updatedAt     DateTime  @updatedAt
//   Product       Product[] // Relation to Product
//   @@map("Currency")
// }
// And in Product model:
// currencyId String
// currency   Currency @relation(fields: [currencyId], references: [id])


export async function seedCurrencies(prisma: PrismaClient): Promise<Currency> {
  console.log('Seeding currencies...');

  let usdCurrency = await prisma.currency.findUnique({
    where: { code: 'USD' },
  });

  if (!usdCurrency) {
    usdCurrency = await prisma.currency.create({
      data: {
        name: 'US Dollar',
        code: 'USD',
        symbol: '$',
        exchangeRate: 1.0,
        isActive: true,
      },
    });
    console.log('Created USD currency.');
  } else {
    console.log('USD currency already exists.');
  }
  
  console.log('Currency seeding finished.');
  return usdCurrency;
}
EOF_SEED_CURRENCY_TS
echo "✅ Created /tmp/testapp/server/prisma/seed/seedCurrency.ts"

# --- /tmp/testapp/server/prisma/seed/seedOperator.ts ---
cat << 'EOF_SEED_OPERATOR_TS' > /tmp/testapp/server/prisma/seed/seedOperator.ts
import { PrismaClient, Operator, PaymentMethod, KeyMode, Role } from '@prisma/client';
import { faker } from '@faker-js/faker';
import bcrypt from 'bcryptjs';

export async function seedOperators(prisma: PrismaClient): Promise<Operator> {
  console.log('Seeding operators...');

  const operatorName = 'MainCasinoOperator';
  let operator = await prisma.operator.findUnique({
    where: { name: operatorName },
  });

  if (!operator) {
    const hashedSecret = await bcrypt.hash('supersecretoperatorpassword', 10);
    operator = await prisma.operator.create({
      data: {
        name: operatorName,
        operator_secret: hashedSecret,
        operator_access: 'internal_services', // Example access level
        callbackUrl: faker.internet.url(),
        active: true,
        permissions: [KeyMode.read, KeyMode.write, KeyMode.manage_users, KeyMode.launch_game, KeyMode.manage_settings],
        ips: ['127.0.0.1', '::1', '*'], // Allow all for local dev, restrict in prod
        description: 'The primary operator for this online casino platform.',
        acceptedPayments: [PaymentMethod.CASH_APP, PaymentMethod.INSTORE_CARD, PaymentMethod.INSTORE_CASH],
      },
    });
    console.log(`Created operator: ${operator.name}`);
  } else {
    console.log(`Operator "${operator.name}" already exists.`);
  }
  
  console.log('Operator seeding finished.');
  return operator;
}
EOF_SEED_OPERATOR_TS
echo "✅ Created /tmp/testapp/server/prisma/seed/seedOperator.ts"

# --- /tmp/testapp/server/prisma/seed/seedAuth.ts ---
cat << 'EOF_SEED_AUTH_TS' > /tmp/testapp/server/prisma/seed/seedAuth.ts
import { PrismaClient, User, Role as PrismaRole } from '@prisma/client';
import { faker } from '@faker-js/faker';
// import bcrypt from 'bcryptjs'; // Only if storing hashed passwords directly in Account model

export async function seedUsers(prisma: PrismaClient) {
  console.log('Seeding users (auth)...');
  const usersToCreate = 20;
  const createdUsersList: User[] = [];

  // 1. Create or find Admin User
  const adminEmail = 'admin@casino.example.com';
  let adminUser = await prisma.user.findUnique({ where: { email: adminEmail } });

  if (!adminUser) {
    adminUser = await prisma.user.create({
      data: {
        id: faker.string.uuid(),
        name: 'Administrator Prime',
        username: 'admincasino',
        displayUsername: 'AdminCasino',
        email: adminEmail,
        emailVerified: true,
        image: faker.image.avatar(),
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    });
    console.log(`Created admin user: ${adminUser.email}`);
  } else {
    console.log(`Admin user ${adminEmail} already exists.`);
  }
  if (adminUser) createdUsersList.push(adminUser);


  // 2. Create or find Regular Users
  for (let i = 0; i < usersToCreate; i++) {
    const firstName = faker.person.firstName();
    const lastName = faker.person.lastName();
    const email = faker.internet.email({ firstName: `${firstName.toLowerCase()}${i}`, lastName: lastName.toLowerCase()});
    let regularUser = await prisma.user.findUnique({ where: { email } });

    if (!regularUser) {
      regularUser = await prisma.user.create({
        data: {
          id: faker.string.uuid(),
          name: `${firstName} ${lastName}`,
          username: faker.internet.userName({ firstName, lastName }).toLowerCase() + i,
          displayUsername: `${firstName}${faker.number.int({ min: 10, max: 99 })}`,
          email: email,
          emailVerified: faker.datatype.boolean(0.7),
          image: faker.image.avatar(),
          createdAt: new Date(),
          updatedAt: new Date(),
        },
      });
      console.log(`Created regular user: ${regularUser.email}`);
    } else {
       console.log(`Regular user ${email} already exists, skipping creation.`);
    }
    if (regularUser) createdUsersList.push(regularUser);
  }
  
  const finalAdminUser = createdUsersList.find(u => u.email === adminEmail);
  const finalRegularUsers = createdUsersList.filter(u => u.email !== adminEmail && u.id !== finalAdminUser?.id); // Ensure no duplicates

  console.log('User (auth) seeding finished.');
  return { adminUser: finalAdminUser!, users: finalRegularUsers };
}
EOF_SEED_AUTH_TS
echo "✅ Created /tmp/testapp/server/prisma/seed/seedAuth.ts"

# --- /tmp/testapp/server/prisma/seed/seedUserProfiles.ts ---
cat << 'EOF_SEED_USERPROFILES_TS' > /tmp/testapp/server/prisma/seed/seedUserProfiles.ts
import { PrismaClient, UserProfile, User, Role as PrismaRole, Operator } from '@prisma/client';
import { faker } from '@faker-js/faker';

export async function seedUserProfiles(
  prisma: PrismaClient,
  users: User[],
  operatorId: string,
  defaultCurrencyCode: string
): Promise<UserProfile[]> {
  console.log('Seeding user profiles and initial VIP infos...');
  const createdUserProfiles: UserProfile[] = [];

  for (const user of users) {
    if (!user || !user.id) {
        console.warn('Skipping profile creation for undefined user or user without ID.');
        continue;
    }
    const isAdmin = user.email === 'admin@casino.example.com';

    let userProfile = await prisma.userProfile.findUnique({
        where: { userId: user.id }
    });

    if (!userProfile) {
        // Create VipInfo first as it's a required relation for UserProfile
        const vipInfo = await prisma.vipInfo.create({
          data: {
            id: user.id, // Using user ID also for VipInfo ID for simplicity here
            username: user.username,
            userId: user.id,
            avatar: user.image || faker.image.avatarGitHub(),
            level: isAdmin ? 5 : faker.number.int({ min: 0, max: 10 }),
            currentLevelXp: faker.number.int({ min: 0, max: 1000 }),
            totalXp: faker.number.int({ min: 0, max: 100000 }),
            dailyBonusClaimedAt: faker.datatype.boolean(0.3) ? faker.date.recent({ days: 1 }) : null,
            weeklyBonusClaimedAt: faker.datatype.boolean(0.2) ? faker.date.recent({ days: 7 }) : null,
            monthlyBonusClaimedAt: faker.datatype.boolean(0.1) ? faker.date.recent({ days: 30 }) : null,
            cashbackPercentage: faker.number.int({ min: 0, max: 15 }),
          }
        });

        userProfile = await prisma.userProfile.create({
            data: {
                id: user.id,
                username: user.username,
                avatar: user.image || faker.image.avatarGitHub(),
                cashtag: `$${user.username.replace(/[^a-zA-Z0-9]/g, '')}${faker.string.alphanumeric(3)}`.toLowerCase(),
                balance: faker.number.int({ min: 10000, max: 250000 }), // 100-2500 currency units
                totalXpFromOperator: vipInfo.totalXp, // Sync with VIP total XP
                activeCurrencyType: defaultCurrencyCode,
                lastDailySpin: faker.date.past({ years: 1 }),
                userId: user.id,
                isActive: true,
                role: isAdmin ? PrismaRole.ADMIN : PrismaRole.USER,
                operatorId: operatorId,
                vipInfoId: vipInfo.id, // Connect to the created VipInfo
            },
        });
        console.log(`Created user profile & VIP info for: ${userProfile.username}`);
        createdUserProfiles.push(userProfile);
    } else {
        console.log(`User profile for ${user.username} already exists.`);
        // Optionally update existing profile's VIP info or other fields
        await prisma.vipInfo.upsert({
            where: { userId: user.id },
            update: {
                level: isAdmin ? 5 : faker.number.int({ min: 0, max: 10 }),
                totalXp: faker.number.int({ min: userProfile.totalXpFromOperator, max: userProfile.totalXpFromOperator + 50000 }),
            },
            create: { // Should not happen if profile exists and vipInfoId is consistent
                id: user.id,
                username: user.username,
                userId: user.id,
                level: isAdmin ? 5 : faker.number.int({ min: 0, max: 10 }),
                totalXp: faker.number.int({ min: 0, max: 100000 }),
                cashbackPercentage: faker.number.int({ min: 0, max: 15 }),
            }
        });
        createdUserProfiles.push(userProfile);
    }
  }

  console.log('User profile and VIP info seeding finished.');
  return createdUserProfiles;
}
EOF_SEED_USERPROFILES_TS
echo "✅ Created /tmp/testapp/server/prisma/seed/seedUserProfiles.ts"

# --- /tmp/testapp/server/prisma/seed/seedVip.ts ---
cat << 'EOF_SEED_VIP_TS' > /tmp/testapp/server/prisma/seed/seedVip.ts
import { PrismaClient, VipInfo, UserProfile } from '@prisma/client';
import { faker } from '@faker-js/faker';

// This function can be used to further update VIP info if needed,
// but seedUserProfiles now handles initial creation due to the strict relation.
export async function seedVipInfos(prisma: PrismaClient, userProfiles: UserProfile[]): Promise<VipInfo[]> {
  console.log('Updating/Enriching VIP infos (if necessary)...');
  const updatedVipInfos: VipInfo[] = [];

  for (const profile of userProfiles) {
    if (!profile || !profile.vipInfoId) {
        console.warn(`Skipping VIP update for profile ${profile?.username} due to missing profile or vipInfoId.`);
        continue;
    }
    const vipInfo = await prisma.vipInfo.findUnique({
      where: { id: profile.vipInfoId },
    });

    if (vipInfo) {
      // Example: Add more XP or update a recently claimed bonus
      const updatedVip = await prisma.vipInfo.update({
        where: { id: vipInfo.id },
        data: {
          currentLevelXp: faker.number.int({ min: vipInfo.currentLevelXp, max: vipInfo.currentLevelXp + 500 }),
          totalXp: faker.number.int({ min: vipInfo.totalXp, max: vipInfo.totalXp + 2000 }),
          // Simulate a recent claim
          // dailyBonusClaimedAt: vipInfo.level > 3 && faker.datatype.boolean(0.1) ? new Date() : vipInfo.dailyBonusClaimedAt,
        },
      });
      updatedVipInfos.push(updatedVip);
    } else {
        console.warn(`VipInfo not found for profile ${profile.username} with vipInfoId ${profile.vipInfoId}. This should not happen if seedUserProfiles ran correctly.`);
    }
  }

  console.log(`VIP info update/enrichment finished. Processed ${updatedVipInfos.length} records.`);
  return updatedVipInfos;
}
EOF_SEED_VIP_TS
echo "✅ Created /tmp/testapp/server/prisma/seed/seedVip.ts"

# --- /tmp/testapp/server/prisma/seed/seedTransactions.ts ---
cat << 'EOF_SEED_TRANSACTIONS_TS' > /tmp/testapp/server/prisma/seed/seedTransactions.ts
import {
  PrismaClient,
  UserProfile,
  Wallet,
  Transaction,
  TransactionType,
  TransactionStatus,
  PaymentMethod,
  Product,
  Role,
} from '@prisma/client';
import { faker } from '@faker-js/faker';

export async function seedWalletsAndTransactions(
  prisma: PrismaClient,
  userProfiles: UserProfile[],
  operatorId: string,
  minTransactionsPerUser: number = 2,
  maxTransactionsPerUser: number = 10
) {
  console.log('Seeding wallets and transactions...');
  const createdWallets: Wallet[] = [];
  const createdTransactions: Transaction[] = [];

  const products = await prisma.product.findMany({ where: { operatorId }, take: 5 });

  for (const profile of userProfiles) {
    if (!profile || !profile.id) continue;

    const paymentMethods = Object.values(PaymentMethod);
    const userPaymentMethod = faker.helpers.arrayElement(paymentMethods);

    let wallet = await prisma.wallet.findUnique({
      where: { userId_paymentMethod_operatorId: { userId: profile.userId, paymentMethod: userPaymentMethod, operatorId } },
    });

    if (!wallet) {
      wallet = await prisma.wallet.create({
        data: {
          userId: profile.userId,
          operatorId: operatorId,
          paymentMethod: userPaymentMethod,
          balance: profile.balance,
          bonusBalance: faker.number.int({ min: 0, max: 5000 }),
          lockedBalance: 0,
          isActive: true,
          address: userPaymentMethod === PaymentMethod.CASH_APP ? `$${profile.username}${faker.string.alphanumeric(4)}` : null,
        },
      });
      createdWallets.push(wallet);
      console.log(`Created ${userPaymentMethod} wallet for ${profile.username}`);
    } else {
       createdWallets.push(wallet);
    }

    let currentBalance = wallet.balance;
    let currentBonusBalance = wallet.bonusBalance;

    const numTransactions = faker.number.int({ min: minTransactionsPerUser, max: maxTransactionsPerUser });

    for (let i = 0; i < numTransactions; i++) {
      const transactionTypeCandidates = [
        TransactionType.DEPOSIT, TransactionType.BET_PLACE, TransactionType.BET_WIN,
        TransactionType.BONUS_AWARD
      ];
      if (products.length > 0) transactionTypeCandidates.push(TransactionType.PRODUCT_PURCHASE);
      if (currentBalance > 2000) transactionTypeCandidates.push(TransactionType.WITHDRAWAL);


      const transactionType = faker.helpers.arrayElement(transactionTypeCandidates);
      const status = faker.helpers.arrayElement([
        TransactionStatus.COMPLETED, TransactionStatus.PENDING, TransactionStatus.FAILED,
      ]);

      let amount = 0;
      let netAmount = 0;
      let feeAmount = 0;
      let bonusAmountTrx = 0;
      const balanceBefore = currentBalance;
      const bonusBalanceBefore = currentBonusBalance;
      let currentProductId = null;

      switch (transactionType) {
        case TransactionType.DEPOSIT:
          amount = faker.number.int({ min: 1000, max: 20000 });
          netAmount = amount;
          if (status === TransactionStatus.COMPLETED) currentBalance += netAmount;
          if (products.length > 0 && faker.datatype.boolean(0.3)) {
            currentProductId = faker.helpers.arrayElement(products).id;
          }
          break;
        case TransactionType.PRODUCT_PURCHASE:
          if (products.length > 0) {
            const product = faker.helpers.arrayElement(products);
            currentProductId = product.id;
            amount = product.priceInCents;
            netAmount = -amount;
            if (status === TransactionStatus.COMPLETED && currentBalance >= amount) currentBalance += netAmount;
            else if (status === TransactionStatus.COMPLETED) status = TransactionStatus.FAILED; // Not enough balance
          } else continue;
          break;
        case TransactionType.BET_PLACE:
          amount = faker.number.int({ min: 50, max: Math.min(5000, currentBalance) });
          if (amount <= 0 && currentBalance > 0) amount = 50; // ensure some bet if balance exists
          else if (currentBalance <= 0) continue; // skip bet if no balance

          netAmount = -amount;
          if (status === TransactionStatus.COMPLETED) currentBalance += netAmount;
          break;
        case TransactionType.BET_WIN:
          const lastBet = createdTransactions.reverse().find(t => t.type === TransactionType.BET_PLACE && t.userProfileId === profile.id);
          amount = faker.number.int({ min: 10, max: (lastBet?.amount || 500) * 5 });
          netAmount = amount;
          if (status === TransactionStatus.COMPLETED) currentBalance += netAmount;
          break;
        case TransactionType.WITHDRAWAL:
          amount = faker.number.int({ min: 1000, max: Math.min(10000, currentBalance) });
           if (amount <= 0 && currentBalance > 0) amount = 1000;
           else if (currentBalance <= 0) continue;

          feeAmount = faker.datatype.boolean(0.2) ? faker.number.int({ min: 50, max: 200 }) : 0;
          netAmount = -(amount + feeAmount);
          if (status === TransactionStatus.COMPLETED) currentBalance += netAmount;
          break;
        case TransactionType.BONUS_AWARD:
          bonusAmountTrx = faker.number.int({ min: 500, max: 5000 });
          if (status === TransactionStatus.COMPLETED) currentBonusBalance += bonusAmountTrx;
          amount = bonusAmountTrx; // For display/logging, bonus is the "amount"
          netAmount = 0; // No change to real balance for bonus award itself
          break;
      }
      
      const balanceAfter = currentBalance;
      const bonusBalanceAfter = currentBonusBalance;

      if (transactionType === TransactionType.WITHDRAWAL && balanceBefore < amount + feeAmount && status === TransactionStatus.COMPLETED) {
          status = TransactionStatus.FAILED; // Correct status if withdrawal would make balance negative
      }


      const transaction = await prisma.transaction.create({
        data: {
          walletId: wallet.id,
          userProfileId: profile.id,
          operatorId: operatorId,
          type: transactionType,
          status,
          amount,
          netAmount: (status === TransactionStatus.COMPLETED && transactionType !== TransactionType.BONUS_AWARD) ? netAmount : 0,
          feeAmount: feeAmount > 0 ? feeAmount : null,
          productId: currentProductId,
          paymentMethod: wallet.paymentMethod,
          balanceBefore: (status === TransactionStatus.COMPLETED && transactionType !== TransactionType.BONUS_AWARD) ? balanceBefore : null,
          balanceAfter: (status === TransactionStatus.COMPLETED && transactionType !== TransactionType.BONUS_AWARD) ? balanceAfter : null,
          bonusBalanceBefore: status === TransactionStatus.COMPLETED ? bonusBalanceBefore : null,
          bonusBalanceAfter: status === TransactionStatus.COMPLETED ? bonusBalanceAfter : null,
          bonusAmount: bonusAmountTrx > 0 ? bonusAmountTrx : null,
          description: `${transactionType} of ${amount / 100}`,
          provider: transactionType === TransactionType.DEPOSIT || transactionType === TransactionType.WITHDRAWAL ? 'MockPaymentProvider' : 'System',
          providerTxId: faker.string.alphanumeric(16),
          processedAt: status === TransactionStatus.COMPLETED || status === TransactionStatus.FAILED ? new Date() : null,
          metadata: {
            ipAddress: faker.internet.ip(),
            deviceInfo: { os: faker.helpers.arrayElement(['iOS', 'Android', 'Windows', 'MacOS']), browser: faker.internet.userAgent() },
          }
        },
      });
      createdTransactions.push(transaction);
    }
    // Final update to wallet based on simulated transactions
     if(wallet && (wallet.balance !== currentBalance || wallet.bonusBalance !== currentBonusBalance)) {
        await prisma.wallet.update({
            where: { id: wallet.id },
            data: { balance: currentBalance, bonusBalance: currentBonusBalance }
        });
    }
  }

  console.log('Wallet and transaction seeding finished.');
  return { wallets: createdWallets, transactions: createdTransactions };
}
EOF_SEED_TRANSACTIONS_TS
echo "✅ Created /tmp/testapp/server/prisma/seed/seedTransactions.ts"

# --- /tmp/testapp/server/prisma/seed/seedGameProviders.ts ---
cat << 'EOF_SEED_GAMEPROVIDERS_TS' > /tmp/testapp/server/prisma/seed/seedGameProviders.ts
import { PrismaClient, GameProvider, GameProviderName, ProviderAuthType } from '@prisma/client';
import { faker } from '@faker-js/faker';

export async function seedGameProviders(prisma: PrismaClient): Promise<GameProvider[]> {
  console.log('Seeding game providers...');
  const createdGameProviders: GameProvider[] = [];

  const providerDataList = [
    { name: GameProviderName.PRAGMATICPLAY, displayName: 'Pragmatic Play', rgsBaseUrl: 'https://api.pragmaticplay.com/rgs', authType: ProviderAuthType.API_KEY, apiKey: `pk_${faker.string.alphanumeric(32)}`, configJson: { gameLaunchParams: ['token', 'lang', 'gameSymbol'] } },
    { name: GameProviderName.EVOPLAY, displayName: 'EvoPlay', rgsBaseUrl: 'https://api.evoplay.games/api/v2', authType: ProviderAuthType.JWT_SIGN, privateKeyRef: 'EVOPLAY_PRIVATE_KEY_VAULT_REF', configJson: { jwtAlgorithm: 'RS256' } },
    { name: GameProviderName.NETENT, displayName: 'NetEnt', rgsBaseUrl: 'https://netent-static.casinomodule.com/games', authType: ProviderAuthType.CUSTOM, configJson: { operatorId: faker.string.uuid() } },
    { name: GameProviderName.REDTIGER, displayName: 'Red Tiger', rgsBaseUrl: 'https://rgs.redtiger.com/rtg', authType: ProviderAuthType.API_KEY, apiKey: `rtg_pk_${faker.string.alphanumeric(24)}` },
    { name: GameProviderName.KICKASS, displayName: 'KickAss Games', rgsBaseUrl: 'https://api.kickassgames.dev/v1', authType: ProviderAuthType.API_KEY, apiKey: `ka_${faker.string.alphanumeric(30)}` },
    { name: GameProviderName.NETGAME, displayName: 'NetGame', rgsBaseUrl: 'https://api.netgame.com/prod', authType: ProviderAuthType.API_KEY, apiKey: `ng_${faker.string.alphanumeric(28)}` },
    { name: GameProviderName.BIGFISHGAMES, displayName: 'Big Fish Games', rgsBaseUrl: 'https://api.bigfish.com/casino', authType: ProviderAuthType.OAUTH2, configJson: { clientId: faker.string.uuid() } },
    { name: GameProviderName.CQNINE, displayName: 'CQ9 Gaming', rgsBaseUrl: 'https://api.cq9gaming.com/v1', authType: ProviderAuthType.API_KEY, apiKey: `cq9_${faker.string.alphanumeric(30)}` },
    { name: GameProviderName.NOLIMIT, displayName: 'Nolimit City', rgsBaseUrl: 'https://rgs.nolimitcity.com', authType: ProviderAuthType.API_KEY, apiKey: `nlc_${faker.string.alphanumeric(32)}` },
    { name: GameProviderName.SPRIBE, displayName: 'Spribe', rgsBaseUrl: 'https://api.spribe.io', authType: ProviderAuthType.API_KEY, apiKey: `sp_${faker.string.alphanumeric(30)}` },
    { name: GameProviderName.BGAMING, displayName: 'BGaming', rgsBaseUrl: 'https://api.bgaming.com/rgs', authType: ProviderAuthType.API_KEY, apiKey: `bg_${faker.string.alphanumeric(30)}` },
    { name: GameProviderName.PLAYNGO, displayName: 'Play\'n GO', rgsBaseUrl: 'https://rgs.playngo.com', authType: ProviderAuthType.API_KEY, apiKey: `png_${faker.string.alphanumeric(30)}` },
    { name: GameProviderName.RELAXGAMING, displayName: 'Relax Gaming', rgsBaseUrl: 'https://api.relax-gaming.com', authType: ProviderAuthType.API_KEY, apiKey: `rlx_${faker.string.alphanumeric(30)}` },
    { name: GameProviderName.HACKSAW, displayName: 'Hacksaw Gaming', rgsBaseUrl: 'https://api.hacksawgaming.com', authType: ProviderAuthType.API_KEY, apiKey: `hksw_${faker.string.alphanumeric(30)}` },
    { name: GameProviderName.INTERNAL, displayName: 'Internal Games', rgsBaseUrl: 'https://internal.casino.example/api', authType: ProviderAuthType.NONE },
  ];

  for (const data of providerDataList) {
    let provider = await prisma.gameProvider.findUnique({
      where: { name: data.name },
    });
    if (!provider) {
      provider = await prisma.gameProvider.create({
        data: data as any, // Cast to any if there are slight mismatches with generated types for seed
      });
      console.log(`Created game provider: ${provider.displayName || provider.name}`);
      createdGameProviders.push(provider);
    } else {
      console.log(`Game provider ${data.displayName || data.name} already exists.`);
      createdGameProviders.push(provider);
    }
  }

  console.log('Game provider seeding finished.');
  return createdGameProviders;
}
EOF_SEED_GAMEPROVIDERS_TS
echo "✅ Created /tmp/testapp/server/prisma/seed/seedGameProviders.ts"

# --- /tmp/testapp/server/prisma/seed/seedGames.ts ---
cat << 'EOF_SEED_GAMES_TS' > /tmp/testapp/server/prisma/seed/seedGames.ts
import { PrismaClient, Game, UserProfile, Operator, GameLaunchLink, GameProvider } from '@prisma/client';
import { faker } from '@faker-js/faker';

// Your loadGames function is called from index.ts.
// This function seeds GameLaunchLinks.

export async function seedGameLaunchLinks(
  prisma: PrismaClient,
  games: Game[],
  userProfiles: UserProfile[],
  operators: Operator[] // Assuming you pass an array with the main operator
): Promise<GameLaunchLink[]> {
  console.log('Seeding game launch links...');
  if (games.length === 0 || userProfiles.length === 0 || operators.length === 0) {
    console.log('Skipping game launch links: missing games, users, or operators.');
    return [];
  }
  const createdLaunchLinks: GameLaunchLink[] = [];
  const mainOperator = operators[0]; // Assuming the first operator is the relevant one

  for (const profile of userProfiles) {
    if (!profile || !profile.id) continue;
    const numberOfLinks = faker.number.int({ min: 1, max: 3 });

    for (let i = 0; i < numberOfLinks; i++) {
      const randomGame = faker.helpers.arrayElement(games.filter(g => g.operatorId === mainOperator.id)); // Ensure game belongs to operator
      if (!randomGame) continue; // Skip if no suitable game found

      const launchLinkData = {
        userId: profile.userId,
        gameId: randomGame.id,
        operatorId: mainOperator.id,
        token_internal: faker.string.uuid() + faker.string.alphanumeric(10),
        currency: profile.activeCurrencyType,
        mode: faker.helpers.arrayElement(['real', 'demo']),
        state: 'SESSION_INIT',
        active: true,
        expiresAt: faker.date.future({ hours: 2 }),
        requestIp: faker.internet.ip(),
        userAgent: faker.internet.userAgent(),
        session_url: `https://casino.example.com/launch/${randomGame.name}?token=${faker.string.alphanumeric(32)}`,
        meta: { platform: faker.helpers.arrayElement(['desktop', 'mobile']), language: 'en' },
        userProfileId: profile.id,
      };
      
      try {
        const launchLink = await prisma.gameLaunchLink.create({
          data: launchLinkData,
        });
        createdLaunchLinks.push(launchLink);
      } catch (error) {
        console.error(`Failed to create launch link for user ${profile.username} and game ${randomGame.name}:`, error);
      }
    }
  }

  console.log(`Seeded ${createdLaunchLinks.length} game launch links.`);
  return createdLaunchLinks;
}
EOF_SEED_GAMES_TS
echo "✅ Created /tmp/testapp/server/prisma/seed/seedGames.ts"

# --- /tmp/testapp/server/prisma/seed/seedGameSessionsAndSpins.ts ---
cat << 'EOF_SEED_GAMESESSIONS_TS' > /tmp/testapp/server/prisma/seed/seedGameSessionsAndSpins.ts
import { PrismaClient, Game, UserProfile, GameSession, GameSpin } from '@prisma/client';
import { faker } from '@faker-js/faker';

export async function seedGameSessionsAndSpins(
  prisma: PrismaClient,
  userProfiles: UserProfile[],
  games: Game[],
  minSessionsPerUser: number,
  maxSessionsPerUser: number,
  minSpinsPerSession: number,
  maxSpinsPerSession: number
) {
  console.log('Seeding game sessions and spins...');
  if (userProfiles.length === 0 || games.length === 0) {
    console.log('No users or games available to create sessions/spins.');
    return { gameSessions: [], gameSpins: [] };
  }

  const createdGameSessions: GameSession[] = [];
  const createdGameSpins: GameSpin[] = [];

  for (const profile of userProfiles) {
    if (!profile || !profile.id) continue;
    const numSessions = faker.number.int({ min: minSessionsPerUser, max: maxSessionsPerUser });

    for (let i = 0; i < numSessions; i++) {
      const randomGame = faker.helpers.arrayElement(games.filter(g => g.operatorId === profile.operatorId));
      if (!randomGame) continue;

      const sessionStartTime = faker.date.recent({ days: 30 });
      const sessionDurationMinutes = faker.number.int({min: 5, max: 120});
      const sessionEndTime = new Date(sessionStartTime.getTime() + sessionDurationMinutes * 60000);
      const isActive = faker.datatype.boolean(0.05); // 5% chance session is still "active"

      const gameSessionData = {
        userId: profile.userId,
        gameId: randomGame.id,
        isActive: isActive,
        startedAt: sessionStartTime,
        startTime: sessionStartTime,
        endTime: isActive ? null : sessionEndTime,
        ipAddress: faker.internet.ip(),
        userAgent: faker.internet.userAgent(),
        startingBalance: profile.balance,
        startingTotalXp: profile.totalXpFromOperator,
        currencyId: profile.activeCurrencyType,
        sessionData: { providerSessionId: faker.string.uuid(), clientType: 'HTML5_DESKTOP' },
        rtgToken: faker.string.alphanumeric(32),
        rtgFingerPrint: faker.string.uuid(),
        // profileId: profile.id, // If you add this direct relation
      };

      const gameSession = await prisma.gameSession.create({ data: gameSessionData });
      createdGameSessions.push(gameSession);

      if (isActive && (!profile.currentGameSessionid || faker.datatype.boolean(0.5))) {
          await prisma.userProfile.update({
              where: { id: profile.id },
              data: { currentGameSessionid: gameSession.id }
          });
      }

      const numSpins = faker.number.int({ min: minSpinsPerSession, max: maxSpinsPerSession });
      let totalWageredInSession = 0;
      let totalWonInSession = 0;

      for (let j = 0; j < numSpins; j++) {
        const wagerAmount = faker.number.int({ min: 10, max: 500 }); // cents
        const grossWinAmount = faker.datatype.boolean(0.4)
          ? faker.number.int({ min: 0, max: wagerAmount * faker.number.int({min:1, max:10}) })
          : 0;

        totalWageredInSession += wagerAmount;
        totalWonInSession += grossWinAmount;

        const spin = await prisma.gameSpin.create({
          data: {
            gameSessionId: gameSession.id,
            spinNumber: j + 1,
            wagerAmount,
            grossWinAmount,
            currencyId: profile.activeCurrencyType,
            timeStamp: faker.date.between({ from: sessionStartTime, to: isActive ? new Date() : sessionEndTime }),
            spinData: { betLines: 20, coinValue: (wagerAmount / 20 / 100).toFixed(2) },
            // sessionId: gameSession.id, // This seems redundant if gameSessionId is present
          },
        });
        createdGameSpins.push(spin);
      }
      await prisma.gameSession.update({
          where: { id: gameSession.id },
          data: { totalWagered: totalWageredInSession, totalWon: totalWonInSession}
      });
    }
  }

  console.log('Game session and spin seeding finished.');
  return { gameSessions: createdGameSessions, gameSpins: createdGameSpins };
}
EOF_SEED_GAMESESSIONS_TS
echo "✅ Created /tmp/testapp/server/prisma/seed/seedGameSessionsAndSpins.ts"

# --- /tmp/testapp/server/prisma/seed/seedTournaments.ts ---
cat << 'EOF_SEED_TOURNAMENTS_TS' > /tmp/testapp/server/prisma/seed/seedTournaments.ts
import {
  PrismaClient, Tournament, TournamentGame, TournamentParticipant,
  TournamentReward, TournamentStatus, Game, UserProfile, TournamentGamePlay, Role
} from '@prisma/client';
import { faker } from '@faker-js/faker';

export async function seedTournaments(
  prisma: PrismaClient,
  allGames: Game[],
  userProfiles: UserProfile[],
  creatorUserId: string // ID of the admin user or operator system user
): Promise<Tournament[]> {
  console.log('Seeding tournaments...');
  if (allGames.length < 3) {
    console.log("Not enough games for varied tournaments. Skipping.");
    return [];
  }
  const createdTournaments: Tournament[] = [];

  const tournamentTypes = [
    { namePrefix: 'Weekly Slot Masters', durationDays: 7, status: TournamentStatus.ACTIVE, gamesCount: 3, targetScoreBase: 100000 },
    { namePrefix: 'Daily Dash', durationDays: 1, status: TournamentStatus.COMPLETED, gamesCount: 2, targetScoreBase: 20000 },
    { namePrefix: 'Upcoming Weekend Bonanza', durationDays: 3, status: TournamentStatus.PENDING, gamesCount: 5, targetScoreBase: 50000 },
  ];

  const adminUserProfile = userProfiles.find(up => up.role === Role.ADMIN);

  for (const type of tournamentTypes) {
    const startTime = type.status === TournamentStatus.PENDING
      ? faker.date.soon({ days: 5 })
      : faker.date.recent({ days: type.durationDays });
    
    let endTimeCalc: Date | null = null;
    if (type.status === TournamentStatus.COMPLETED) {
        endTimeCalc = new Date(startTime.getTime() + (type.durationDays * 24 * 60 * 60 * 1000) - (60 * 60 * 1000)); // Ended an hour ago
    } else if (type.status === TournamentStatus.ACTIVE || type.status === TournamentStatus.PENDING) {
        endTimeCalc = new Date(startTime.getTime() + type.durationDays * 24 * 60 * 60 * 1000);
    }


    const tournament = await prisma.tournament.create({
      data: {
        name: `${type.namePrefix} - ${faker.lorem.words(2)}`,
        description: faker.lorem.sentence(),
        startTime,
        endTime: endTimeCalc,
        targetScore: faker.number.int({min: type.targetScoreBase, max: type.targetScoreBase * 2}),
        status: type.status,
        userId: adminUserProfile?.userId || null, // Link to admin user if available
      },
    });
    createdTournaments.push(tournament);

    const eligibleGames = faker.helpers.arrayElements(allGames.filter(g => g.operatorId === adminUserProfile?.operatorId), {min: 1, max: type.gamesCount});
    if(eligibleGames.length === 0 && allGames.length > 0) { // Fallback if no games match operator
        eligibleGames.push(...faker.helpers.arrayElements(allGames, {min:1, max: type.gamesCount}));
    }

    for (const game of eligibleGames) {
      await prisma.tournamentGame.create({
        data: {
          tournamentId: tournament.id,
          gameId: game.id,
          pointMultiplier: faker.helpers.arrayElement([1.0, 1.2, 1.5, 0.8]),
        },
      });
    }

    const participantsForTournament = faker.helpers.arrayElements(userProfiles.filter(up => up.role === Role.USER), {min: Math.min(3, userProfiles.length-1), max: Math.min(10, userProfiles.length-1)});
    for (const profile of participantsForTournament) {
      if(tournament.status === TournamentStatus.PENDING && faker.datatype.boolean(0.7)) continue;

      const participant = await prisma.tournamentParticipant.create({
        data: {
          tournamentId: tournament.id,
          userId: profile.userId,
          score: 0,
          joinedAt: faker.date.between({ from: startTime, to: new Date() }),
        },
      });

      let totalScoreForParticipant = 0;
      if (tournament.status !== TournamentStatus.PENDING) {
          const numGamePlays = faker.number.int({min: 5, max: 30});
          for (let k=0; k < numGamePlays; k++) {
              const pointsEarned = faker.number.int({min: 10, max: 500});
              totalScoreForParticipant += pointsEarned;
              if (eligibleGames.length > 0) {
                await prisma.tournamentGamePlay.create({
                    data: {
                        tournamentParticipantId: participant.id,
                        gameId: faker.helpers.arrayElement(eligibleGames).id,
                        pointsEarned: pointsEarned,
                        playedAt: faker.date.between({ from: startTime, to: endTimeCalc && endTimeCalc < new Date() ? endTimeCalc : new Date()}),
                    }
                });
              }
          }
          await prisma.tournamentParticipant.update({
              where: { id: participant.id },
              data: { score: totalScoreForParticipant }
          });
      }
    }

    const ranksToReward = [1, 2, 3];
    for (const rank of ranksToReward) {
      await prisma.tournamentReward.create({
        data: {
          tournamentId: tournament.id,
          rank: rank,
          description: `Rank ${rank} Prize: ${faker.commerce.price({ min: 10, max: 500, dec:0, symbol: '$' })} Bonus Credits`,
          isClaimed: tournament.status === TournamentStatus.COMPLETED ? faker.datatype.boolean(0.5) : false,
        },
      });
    }
  }

  console.log(`Seeded ${createdTournaments.length} tournaments.`);
  return createdTournaments;
}
EOF_SEED_TOURNAMENTS_TS
echo "✅ Created /tmp/testapp/server/prisma/seed/seedTournaments.ts"

# --- /tmp/testapp/server/prisma/seed/seedTodo.ts ---
cat << 'EOF_SEED_TODO_TS' > /tmp/testapp/server/prisma/seed/seedTodo.ts
import { PrismaClient, Todo } from '@prisma/client';
import { faker } from '@faker-js/faker';

export async function seedTodos(prisma: PrismaClient, count: number = 5): Promise<Todo[]> {
  console.log('Seeding todos...');
  const createdTodos: Todo[] = [];

  for (let i = 0; i < count; i++) {
    const todo = await prisma.todo.create({
      data: {
        // id is auto-incrementing
        text: faker.lorem.sentence({ min: 3, max: 7 }),
        completed: faker.datatype.boolean(),
      },
    });
    createdTodos.push(todo);
  }

  console.log(`Seeded ${createdTodos.length} todos.`);
  return createdTodos;
}
EOF_SEED_TODO_TS
echo "✅ Created /tmp/testapp/server/prisma/seed/seedTodo.ts"

# --- /tmp/testapp/server/prisma/seed/loadgames.ts (Your provided script) ---
cat << 'EOF_LOADGAMES_TS' > /tmp/testapp/server/prisma/seed/loadgames.ts
// import { PrismaClient } from '../generated/prisma';
// await loadGames();
import { GameCategory, GameProvider } from '@prisma/client'; // Adjusted import
import * as gamesDataFull from './games2.json';
import { PrismaClient } from '@prisma/client';

interface OperatorKey {
  id: string;
}

// const prisma = new PrismaClient();
export default async function loadGames(prisma: PrismaClient, key: OperatorKey): Promise<any[]> { // Return type Promise<any[]>
  // await prisma.$connect(); // Connection managed by main seed script
  console.log('Loading games from games2.json...');
  // await prisma.game.deleteMany({}); // Deletion managed by main seed script's truncate

  const _games: any[] = [];
  const gamesToProcess = (gamesDataFull as any).default || gamesDataFull; // Handle if 'default' key exists due to module system

  async function insertGames(gamesToInsert: any[]) { // Renamed parameter
    if (gamesToInsert.length === 0) {
        console.log("No games to insert from games2.json data.");
        return;
    }
    try {
        await prisma.game.createMany({
            data: gamesToInsert,
            skipDuplicates: true,
        });
        console.log(`Inserted/skipped ${gamesToInsert.length} games from games2.json.`);
    } catch (error) {
        console.error("Error inserting games from games2.json:", error);
    }
  }

  const gameProviders = await prisma.gameProvider.findMany();
  const providerMap = new Map(gameProviders.map(p => [p.name.toLowerCase(), p.id]));


  for (const _game of gamesToProcess) {
    const game: any = { ..._game }; // Create a mutable copy

    game.operatorId = key.id;
    
    // Map developer to GameProviderName enum and then to gameProviderId
    const developerName = game.developer?.toLowerCase();
    let providerEnumKey: keyof typeof GameProviderName | undefined = undefined;

    if (developerName) {
        const matchedKey = Object.keys(GameProviderName).find(k => k.toLowerCase() === developerName);
        if (matchedKey) {
            providerEnumKey = matchedKey as keyof typeof GameProviderName;
        }
    }

    if (providerEnumKey && providerMap.has(GameProviderName[providerEnumKey].toLowerCase())) {
        game.gameProviderId = providerMap.get(GameProviderName[providerEnumKey].toLowerCase());
    } else if (developerName && providerMap.has(developerName)) { // Fallback to direct name match if enum not found
        game.gameProviderId = providerMap.get(developerName);
    } else {
        // console.warn(`Could not map developer "${game.developer}" to a known gameProviderId. Game: ${game.name}`);
        // Optionally, link to a default/unknown provider or skip
    }


    game.category =
      GameCategory[
        game.type
          ? (game.type as string).toUpperCase().replace(/\s+/g, '_') as keyof typeof GameCategory
          : 'SLOTS' // Default to SLOTS if type is missing
      ] || GameCategory.OTHER; // Default to OTHER if mapping fails


    // Clean up fields not in the Game model or that need transformation
    const goldsvetData: any = {};
    const fieldsToKeepInGame = ['name', 'title', 'description', 'supportedProviders', 'category', 'tags', 'isActive', 'thumbnailUrl', 'bannerUrl', 'meta', 'featured', 'providerName', 'totalWagered', 'gameProviderId', 'operatorId'];
    
    Object.keys(game).forEach(k => {
        if (!fieldsToKeepInGame.includes(k) && k !== 'goldsvetData') {
            goldsvetData[k] = game[k];
            delete game[k];
        }
    });
    game.goldsvetData = goldsvetData;

    // Ensure required fields have defaults if not present
    game.name = game.name || game.title || `Unknown Game ${faker.string.uuid()}`;
    game.title = game.title || game.name;
    game.supportedProviders = game.supportedProviders || (providerEnumKey ? [GameProviderName[providerEnumKey]] : []);
    game.tags = game.tags || [];
    game.isActive = typeof game.active === 'boolean' ? game.active : (typeof game.isActive === 'string' ? game.isActive.toLowerCase() === 'true' : true);
    game.featured = typeof game.featured === 'boolean' ? game.featured : (typeof game.featured === 'string' ? game.featured.toLowerCase() === 'true' : false);


    if (_games.filter((item) => item.name === game.name && item.operatorId === game.operatorId).length === 0) {
      _games.push(game);
    }
  }

  await insertGames(_games);
  console.log('Finished processing games from games2.json.');
  return await prisma.game.findMany({ where: { operatorId: key.id } }); // Return games for this operator
}
EOF_LOADGAMES_TS
echo "✅ Created /tmp/testapp/server/prisma/seed/loadgames.ts"

# --- /tmp/testapp/server/prisma/seed/seedProducts.ts (Your provided script) ---
cat << 'EOF_SEEDPRODUCTS_TS' > /tmp/testapp/server/prisma/seed/seedProducts.ts
import * as productsData from './products.json'; // Ensure path is correct
import { PrismaClient, Product as PrismaProduct, Operator } from '@prisma/client'; // Adjust imports

interface ProductInput {
  id?: string;
  title: string;
  priceInCents: number;
  description?: string;
  url?: string; // Changed from image to url to match schema
  iconUrl?: string;
  operatorId?: string; // Changed from shopId
  totalDiscountInCents?: number;
  currencyId?: string; // Changed from currency_id
  productType?: string;
  bonusCode?: string;
  bonusTotalInCredits?: number;
  isActive?: boolean;
  amountToReceiveInCredits?: number;
  bestValue?: number;
  discountInCents?: number;
  bonusSpins?: number;
  isPromo?: boolean;
  [key: string]: unknown; // For any additional properties
}

export default async function seedProducts( // Renamed from loadProducts for clarity
  prisma: PrismaClient,
  operatorKey: { id: string }, // Changed from key to operatorKey
  currencyID: string
): Promise<PrismaProduct[]> {
  console.log('Loading products from products.json...');
  // await prisma.product.deleteMany({ where: { operatorId: operatorKey.id } }); // Deletion managed by main script

  const productsToProcess = (productsData as any).default || productsData; // Handle if 'default' key exists

  const mappedProducts: ProductInput[] = productsToProcess.map((product: any) => ({
    ...product, // Spread original product data
    title: product.title ?? `Product ${faker.commerce.productName()}`,
    url: product.url ?? product.image ?? faker.image.urlLoremFlickr({ category: 'technics' }), // Map 'image' to 'url'
    operatorId: operatorKey.id,
    currencyId: currencyID,
    // Ensure defaults for potentially missing fields from JSON if they are required by schema
    description: product.description ?? faker.commerce.productDescription(),
    productType: product.productType ?? "DEPOSIT_PACKAGE",
    priceInCents: product.priceInCents ?? 0,
    amountToReceiveInCredits: product.amountToReceiveInCredits ?? 0,
    isActive: typeof product.isActive === 'boolean' ? product.isActive : true,
  }));

  const createdProducts: PrismaProduct[] = [];
  for (const productInput of mappedProducts) {
    try {
      const createdProduct = await prisma.product.create({
        data: {
          title: productInput.title,
          description: productInput.description,
          url: productInput.url,
          iconUrl: productInput.iconUrl,
          productType: productInput.productType!,
          bonusCode: productInput.bonusCode,
          bonusTotalInCredits: productInput.bonusTotalInCredits,
          isActive: productInput.isActive,
          priceInCents: productInput.priceInCents,
          amountToReceiveInCredits: productInput.amountToReceiveInCredits,
          bestValue: productInput.bestValue,
          discountInCents: productInput.discountInCents,
          bonusSpins: productInput.bonusSpins,
          isPromo: productInput.isPromo,
          totalDiscountInCents: productInput.totalDiscountInCents,
          operator: { connect: { id: productInput.operatorId! } },
          currency: { connect: { id: productInput.currencyId! } },
        },
      });
      createdProducts.push(createdProduct);
    } catch (error) {
        console.error(`Error creating product "${productInput.title}":`, error);
    }
  }
  console.log(`Finished processing ${createdProducts.length} products from products.json.`);
  return createdProducts;
}
EOF_SEEDPRODUCTS_TS
echo "✅ Created /tmp/testapp/server/prisma/seed/seedProducts.ts"

# --- /tmp/testapp/server/prisma/seed/games2.json (Your provided data) ---
# This will be a large block. Ensure your terminal handles it.
# For brevity in this example, I'll put a placeholder.
# In the actual script, the full JSON content you provided would be here.
cat << 'EOF_GAMES2_JSON' > /tmp/testapp/server/prisma/seed/games2.json
[
  {
    "id": "13505",
    "developer": "redtiger",
    "type": "slots",
    "vip_level": "5",
    "name": "AncientDiscoRTG",
    "title": "AncientDisco",
    "shop_id": "1",
    "jpg_id": "0",
    "label": "1",
    "device": "1",
    "gamebank": "slots",
    "lines_percent_config_spin": "1",
    "lines_percent_config_spin_bonus": "1",
    "lines_percent_config_bonus": "1",
    "lines_percent_config_bonus_bonus": "1",
    "rezerv": "",
    "cask": "1",
    "advanced": "1",
    "bet": "1",
    "scalemode": "",
    "slotviewstate": "1",
    "view": "",
    "denomination": "1.00",
    "category_temp": "1",
    "original_id": "",
    "bids": "0",
    "stat_in": "0.0000",
    "stat_out": "0.0000",
    "created_at": "2020-01-30 00:00:00",
    "updated_at": "2020-01-30 00:00:00",
    "standard_rtp": "1",
    "active": "true",
    "featured": "false",
    "popularity": "1",
    "current_rtp": "",
    "rtp_stat_in": "",
    "rtp_stat_out": ""
  }
]
EOF_GAMES2_JSON
echo "✅ Created /tmp/testapp/server/prisma/seed/games2.json (stub, replace with full content if needed by script)"


# --- /tmp/testapp/server/prisma/seed/products.json (Your provided data) ---
cat << 'EOF_PRODUCTS_JSON' > /tmp/testapp/server/prisma/seed/products.json
[
  {
    "title": "Package One",
    "productType": "DEPOSIT_PACKAGE",
    "amountToReceiveInCredits": 500,
    "totalDiscountInCents": 300,
    "bonusSpins": 1,
    "isPromo": false,
    "description": "blah blah ",
    "url": "https://nnzmufhldbsvvztlrrau.supabase.co/storage/v1/object/public/products/gems1.png",
    "priceInCents": 200
  },
  {
    "title": "Package Two",
    "productType": "DEPOSIT_PACKAGE",
    "amountToReceiveInCredits": 1000,
    "totalDiscountInCents": 500,
    "bonusSpins": 2,
    "isPromo": false,
    "description": "blah blah ",
    "url": "https://nnzmufhldbsvvztlrrau.supabase.co/storage/v1/object/public/products/gems1.png",
    "priceInCents": 500
  },
  {
    "title": "Package Three",
    "productType": "DEPOSIT_PACKAGE",
    "amountToReceiveInCredits": 1500,
    "totalDiscountInCents": 500,
    "bonusSpins": 3,
    "isPromo": false,
    "description": "blah blah ",
    "url": "https://nnzmufhldbsvvztlrrau.supabase.co/storage/v1/object/public/products/gems1.png",
    "priceInCents": 1000
  },
  {
    "title": "Package Four",
    "productType": "DEPOSIT_PACKAGE",
    "amountToReceiveInCredits": 2000,
    "totalDiscountInCents": 500,
    "bonusSpins": 5,
    "isPromo": false,
    "description": "blah blah ",
    "url": "https://nnzmufhldbsvvztlrrau.supabase.co/storage/v1/object/public/products/gems1.png",
    "priceInCents": 1500
  }
]
EOF_PRODUCTS_JSON
echo "✅ Created /tmp/testapp/server/prisma/seed/products.json"

echo "🎉 All seed files created in /tmp/testapp/server/prisma/seed/ directory."
echo "To run the seed, execute: npm run prisma:seed (or yarn prisma:seed)"
echo "Ensure you have ts-node, @faker-js/faker, and bcryptjs installed."

