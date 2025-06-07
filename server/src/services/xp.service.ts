// server/src/services/xp.service.ts

import { VipInfo } from '../../prisma/generated/client'
import prisma from '../../prisma/index'
import { getVipLevelConfiguration } from '../config/leveling.config'

const db = prisma

// Types for XP calculations
export interface XpGainSource {
  type: 'GAME_WAGER' | 'DEPOSIT' | 'DAILY_BONUS' | 'ACHIEVEMENT' | 'TOURNAMENT' | 'MANUAL'
  sourceId?: string
  metadata?: Record<string, any>
}

export interface XpCalculationResult {
  xpGained: number
  newTotalXp: number
  newCurrentLevelXp: number
  levelChanged: boolean
  newLevel: number
  oldLevel: number
}

/**
 * Calculate XP for a wager based on VIP level and amount
 */
export function calculateXpForWager(wagerAmount: number, vipInfo: VipInfo): number {
  // Base XP calculation: 1 XP per $1 wagered
  const baseXp = Math.floor(wagerAmount)

  // Apply VIP level multiplier
  const levelConfig = getVipLevelConfiguration(vipInfo.level)
  const multiplier = levelConfig?.dailyBonusMultiplier || 1.0

  return Math.floor(baseXp * multiplier)
}

/**
 * Calculate XP for a deposit based on amount and VIP level
 */
export function calculateXpForDeposit(depositAmountCents: number, vipInfo: VipInfo): number {
  // Convert cents to dollars for calculation
  const depositAmount = depositAmountCents / 100

  // Base XP calculation: 2 XP per $1 deposited (deposits are more valuable)
  const baseXp = Math.floor(depositAmount * 2)

  // Apply VIP level multiplier
  const levelConfig = getVipLevelConfiguration(vipInfo.level)
  const multiplier = levelConfig?.dailyBonusMultiplier || 1.0

  return Math.floor(baseXp * multiplier)
}

/**
 * Add XP to a user and handle level progression
 */
export async function addXpToUser(
  userId: string,
  xpAmount: number
  // source: string,
  // sourceId?: string,
  // metadata?: Record<string, any>,
): Promise<XpCalculationResult> {
  // const prismaClient = tx || db

  if (xpAmount <= 0) {
    throw new Error('XP amount must be positive')
  }

  return await prisma.$transaction(async (transaction) => {
    // Get or create VIP info
    let vipInfo = await transaction.vipInfo.findUnique({
      where: { userId },
    })

    if (!vipInfo) {
      vipInfo = await createDefaultVipInfo(userId, transaction)
    }

    const oldLevel = vipInfo.level
    const oldTotalXp = vipInfo.totalXp
    const newTotalXp = oldTotalXp + xpAmount

    // Calculate new level and current level XP
    const levelProgression = calculateLevelProgression(newTotalXp)

    // Update VIP info
    await transaction.vipInfo.update({
      where: { userId },
      data: {
        totalXp: newTotalXp,
        level: levelProgression.level,
        currentLevelXp: levelProgression.currentLevelXp,
        updatedAt: new Date(),
      },
    })

    // Create XP event record (if we had an XpEvent model)
    // await transaction.xpEvent.create({
    //   data: {
    //     userId,
    //     xpGained: xpAmount,
    //     source,
    //     sourceId,
    //     metadata,
    //     totalXpAfter: newTotalXp,
    //     levelAfter: levelProgression.level
    //   }
    // })

    const result: XpCalculationResult = {
      xpGained: xpAmount,
      newTotalXp,
      newCurrentLevelXp: levelProgression.currentLevelXp,
      levelChanged: oldLevel !== levelProgression.level,
      newLevel: levelProgression.level,
      oldLevel,
    }

    // TODO: Emit events for XP gain and potential level up when event system is implemented
    // typedAppEventEmitter.emit(AppEvents.USER_XP_GAINED, { ... })

    if (result.levelChanged) {
      // TODO: Emit level up event when event system is implemented
      // typedAppEventEmitter.emit(AppEvents.USER_LEVEL_UP, { ... })

      // Apply level up benefits
      await applyLevelUpBenefits(userId, levelProgression.level, transaction)
    }

    return result
  })
}

/**
 * Calculate level progression based on total XP
 */
function calculateLevelProgression(totalXp: number): {
  level: number
  currentLevelXp: number
  xpRequiredForCurrentLevel: number
} {
  let level = 0
  let xpUsed = 0

  // Find the appropriate level
  while (true) {
    const levelConfig = getVipLevelConfiguration(level + 1)
    if (!levelConfig) break

    if (totalXp >= xpUsed + levelConfig.xpRequired) {
      xpUsed += levelConfig.xpRequired
      level++
    } else {
      break
    }
  }

  const currentLevelConfig = getVipLevelConfiguration(level + 1)
  const currentLevelXp = totalXp - xpUsed
  const xpRequiredForCurrentLevel = currentLevelConfig?.xpRequired || 0

  return {
    level,
    currentLevelXp,
    xpRequiredForCurrentLevel,
  }
}

/**
 * Create default VIP info for a new user
 */
async function createDefaultVipInfo(userId: string, tx: any): Promise<VipInfo> {
  const defaultLevelConfig = getVipLevelConfiguration(1)
  if (!defaultLevelConfig) {
    throw new Error('Default level 1 VIP config missing.')
  }

  // Get user profile for username
  const userProfile = await tx.userProfile.findUnique({
    where: { userId },
  })

  return await tx.vipInfo.create({
    data: {
      id: `vip_${userId}`,
      userId,
      username: userProfile?.username || `user_${userId}`,
      level: 0, // Start at level 0
      currentLevelXp: 0,
      totalXp: 0,
      cashbackPercentage: defaultLevelConfig.cashbackPercentage,
    },
  })
}

/**
 * Apply level up benefits when a user reaches a new level
 */
async function applyLevelUpBenefits(userId: string, newLevel: number, tx: any): Promise<void> {
  const levelConfig = getVipLevelConfiguration(newLevel)
  if (!levelConfig) return

  // Update cashback percentage
  await tx.vipInfo.update({
    where: { userId },
    data: {
      cashbackPercentage: levelConfig.cashbackPercentage,
    },
  })

  // TODO: Implement other level up benefits like:
  // - One-time bonus credits
  // - Special bonuses
  // - Unlock new features
  // - Send congratulatory messages
}

/**
 * Get user's current XP progress
 */
export async function getUserXpProgress(userId: string): Promise<{
  vipInfo: VipInfo
  progressToNextLevel: number
  xpRequiredForNextLevel: number
} | null> {
  const vipInfo = await db.vipInfo.findUnique({
    where: { userId },
  })

  if (!vipInfo) return null

  const nextLevelConfig = getVipLevelConfiguration(vipInfo.level + 1)
  const xpRequiredForNextLevel = nextLevelConfig?.xpRequired || 0
  const progressToNextLevel =
    xpRequiredForNextLevel > 0 ? (vipInfo.currentLevelXp / xpRequiredForNextLevel) * 100 : 100

  return {
    vipInfo,
    progressToNextLevel,
    xpRequiredForNextLevel,
  }
}
