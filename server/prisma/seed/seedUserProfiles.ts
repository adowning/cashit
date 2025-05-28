import { PrismaClient, UserProfile, User, Role as PrismaRole, Operator } from '../generated/'
import { faker } from '@faker-js/faker'

export async function seedUserProfiles(
  prisma: PrismaClient,
  users: User[],
  operatorId: string,
  defaultCurrencyCode: string
): Promise<UserProfile[]> {
  console.log('Seeding user profiles and initial VIP infos...')
  const createdUserProfiles: UserProfile[] = []

  for (const user of users) {
    if (!user || !user.id) {
      console.warn('Skipping profile creation for undefined user or user without ID.')
      continue
    }
    const isAdmin = user.email === 'admin@casino.example.com'

    let userProfile = await prisma.userProfile.findUnique({
      where: { userId: user.id },
    })

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
          monthlyBonusClaimedAt: faker.datatype.boolean(0.1)
            ? faker.date.recent({ days: 30 })
            : null,
          cashbackPercentage: faker.number.int({ min: 0, max: 15 }),
        },
      })

      userProfile = await prisma.userProfile.create({
        data: {
          id: user.id,
          username: user.username,
          avatar: user.image || faker.image.avatarGitHub(),
          cashtag:
            `$${user.username.replace(/[^a-zA-Z0-9]/g, '')}${faker.string.alphanumeric(3)}`.toLowerCase(),
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
      })
      console.log(`Created user profile & VIP info for: ${userProfile.username}`)
      createdUserProfiles.push(userProfile)
    } else {
      console.log(`User profile for ${user.username} already exists.`)
      // Optionally update existing profile's VIP info or other fields
      await prisma.vipInfo.upsert({
        where: { userId: user.id },
        update: {
          level: isAdmin ? 5 : faker.number.int({ min: 0, max: 10 }),
          totalXp: faker.number.int({
            min: userProfile.totalXpFromOperator,
            max: userProfile.totalXpFromOperator + 50000,
          }),
        },
        create: {
          // Should not happen if profile exists and vipInfoId is consistent
          id: user.id,
          username: user.username,
          userId: user.id,
          level: isAdmin ? 5 : faker.number.int({ min: 0, max: 10 }),
          totalXp: faker.number.int({ min: 0, max: 100000 }),
          cashbackPercentage: faker.number.int({ min: 0, max: 15 }),
        },
      })
      createdUserProfiles.push(userProfile)
    }
  }

  console.log('User profile and VIP info seeding finished.')
  return createdUserProfiles
}
