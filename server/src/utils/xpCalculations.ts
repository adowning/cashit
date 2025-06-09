// server/src/utils/xpCalculations.ts

import { VipInfo } from '@/generated'
import { getVipLevelConfiguration } from '../config/leveling.config'

/**
 * Base XP rates for different activities
 */
export const XP_RATES = {
  // XP per dollar wagered
  WAGER_BASE_RATE: 1,
  
  // XP per dollar deposited (higher than wager to encourage deposits)
  DEPOSIT_BASE_RATE: 2,
  
  // Daily bonus XP
  DAILY_BONUS_XP: 10,
  
  // Tournament participation XP
  TOURNAMENT_PARTICIPATION_XP: 25,
  
  // Tournament win bonus XP (per position)
  TOURNAMENT_WIN_BONUS: {
    1: 100, // 1st place
    2: 75,  // 2nd place
    3: 50,  // 3rd place
    4: 25,  // 4th-10th place
    10: 10  // 11th+ place
  },
  
  // Achievement XP rewards
  ACHIEVEMENT_XP: {
    FIRST_DEPOSIT: 50,
    FIRST_WIN: 25,
    PLAY_STREAK_7_DAYS: 100,
    PLAY_STREAK_30_DAYS: 500,
    HIGH_ROLLER_1000: 200,
    HIGH_ROLLER_5000: 1000,
    SOCIAL_SHARE: 15,
    PROFILE_COMPLETE: 30
  }
}

/**
 * Calculate XP bonus for a deposit based on amount and VIP level
 */
export function calculateXpBonusForDeposit(depositAmountCents: number, vipInfo: VipInfo): number {
  // Convert cents to dollars
  const depositAmount = depositAmountCents / 100
  
  // Base XP calculation
  const baseXp = Math.floor(depositAmount * XP_RATES.DEPOSIT_BASE_RATE)
  
  // Apply VIP level multiplier
  const levelConfig = getVipLevelConfiguration(vipInfo.level)
  const multiplier = levelConfig?.dailyBonusMultiplier || 1.0
  
  return Math.floor(baseXp * multiplier)
}

/**
 * Calculate XP for a wager based on amount and VIP level
 */
export function calculateXpForWager(wagerAmountCents: number, vipInfo: VipInfo): number {
  // Convert cents to dollars
  const wagerAmount = wagerAmountCents / 100
  
  // Base XP calculation
  const baseXp = Math.floor(wagerAmount * XP_RATES.WAGER_BASE_RATE)
  
  // Apply VIP level multiplier
  const levelConfig = getVipLevelConfiguration(vipInfo.level)
  const multiplier = levelConfig?.dailyBonusMultiplier || 1.0
  
  return Math.floor(baseXp * multiplier)
}

/**
 * Calculate XP for daily bonus claim
 */
export function calculateDailyBonusXp(vipInfo: VipInfo): number {
  const baseXp = XP_RATES.DAILY_BONUS_XP
  
  // Apply VIP level multiplier
  const levelConfig = getVipLevelConfiguration(vipInfo.level)
  const multiplier = levelConfig?.dailyBonusMultiplier || 1.0
  
  return Math.floor(baseXp * multiplier)
}

/**
 * Calculate XP for tournament participation
 */
export function calculateTournamentParticipationXp(vipInfo: VipInfo): number {
  const baseXp = XP_RATES.TOURNAMENT_PARTICIPATION_XP
  
  // Apply VIP level multiplier
  const levelConfig = getVipLevelConfiguration(vipInfo.level)
  const multiplier = levelConfig?.dailyBonusMultiplier || 1.0
  
  return Math.floor(baseXp * multiplier)
}

/**
 * Calculate XP bonus for tournament placement
 */
export function calculateTournamentPlacementXp(placement: number, vipInfo: VipInfo): number {
  let baseXp = 0
  
  if (placement === 1) {
    baseXp = XP_RATES.TOURNAMENT_WIN_BONUS[1]
  } else if (placement === 2) {
    baseXp = XP_RATES.TOURNAMENT_WIN_BONUS[2]
  } else if (placement === 3) {
    baseXp = XP_RATES.TOURNAMENT_WIN_BONUS[3]
  } else if (placement <= 10) {
    baseXp = XP_RATES.TOURNAMENT_WIN_BONUS[4]
  } else {
    baseXp = XP_RATES.TOURNAMENT_WIN_BONUS[10]
  }
  
  // Apply VIP level multiplier
  const levelConfig = getVipLevelConfiguration(vipInfo.level)
  const multiplier = levelConfig?.dailyBonusMultiplier || 1.0
  
  return Math.floor(baseXp * multiplier)
}

/**
 * Calculate XP for achievements
 */
export function calculateAchievementXp(achievementType: keyof typeof XP_RATES.ACHIEVEMENT_XP, vipInfo: VipInfo): number {
  const baseXp = XP_RATES.ACHIEVEMENT_XP[achievementType] || 0
  
  // Apply VIP level multiplier
  const levelConfig = getVipLevelConfiguration(vipInfo.level)
  const multiplier = levelConfig?.dailyBonusMultiplier || 1.0
  
  return Math.floor(baseXp * multiplier)
}

/**
 * Calculate XP for high roller bonuses based on wager amount
 */
export function calculateHighRollerXp(wagerAmountCents: number, vipInfo: VipInfo): number {
  const wagerAmount = wagerAmountCents / 100
  let bonusXp = 0
  
  // High roller thresholds
  if (wagerAmount >= 5000) {
    bonusXp = XP_RATES.ACHIEVEMENT_XP.HIGH_ROLLER_5000
  } else if (wagerAmount >= 1000) {
    bonusXp = XP_RATES.ACHIEVEMENT_XP.HIGH_ROLLER_1000
  }
  
  if (bonusXp > 0) {
    // Apply VIP level multiplier
    const levelConfig = getVipLevelConfiguration(vipInfo.level)
    const multiplier = levelConfig?.dailyBonusMultiplier || 1.0
    
    return Math.floor(bonusXp * multiplier)
  }
  
  return 0
}

/**
 * Calculate bonus XP for consecutive play days
 */
export function calculateStreakBonusXp(consecutiveDays: number, vipInfo: VipInfo): number {
  let bonusXp = 0
  
  // Streak bonuses
  if (consecutiveDays >= 30) {
    bonusXp = XP_RATES.ACHIEVEMENT_XP.PLAY_STREAK_30_DAYS
  } else if (consecutiveDays >= 7) {
    bonusXp = XP_RATES.ACHIEVEMENT_XP.PLAY_STREAK_7_DAYS
  }
  
  if (bonusXp > 0) {
    // Apply VIP level multiplier
    const levelConfig = getVipLevelConfiguration(vipInfo.level)
    const multiplier = levelConfig?.dailyBonusMultiplier || 1.0
    
    return Math.floor(bonusXp * multiplier)
  }
  
  return 0
}

/**
 * Calculate total XP for a gaming session
 */
export function calculateSessionXp(sessionData: {
  wagerAmountCents: number
  isFirstWin?: boolean
  isHighRoller?: boolean
  tournamentParticipation?: boolean
  tournamentPlacement?: number
}, vipInfo: VipInfo): {
  wagerXp: number
  bonusXp: number
  totalXp: number
  breakdown: string[]
} {
  const breakdown: string[] = []
  
  // Base wager XP
  const wagerXp = calculateXpForWager(sessionData.wagerAmountCents, vipInfo)
  breakdown.push(`Wager XP: ${wagerXp}`)
  
  let bonusXp = 0
  
  // First win bonus
  if (sessionData.isFirstWin) {
    const firstWinXp = calculateAchievementXp('FIRST_WIN', vipInfo)
    bonusXp += firstWinXp
    breakdown.push(`First Win Bonus: ${firstWinXp}`)
  }
  
  // High roller bonus
  if (sessionData.isHighRoller) {
    const highRollerXp = calculateHighRollerXp(sessionData.wagerAmountCents, vipInfo)
    bonusXp += highRollerXp
    if (highRollerXp > 0) {
      breakdown.push(`High Roller Bonus: ${highRollerXp}`)
    }
  }
  
  // Tournament participation
  if (sessionData.tournamentParticipation) {
    const tournamentXp = calculateTournamentParticipationXp(vipInfo)
    bonusXp += tournamentXp
    breakdown.push(`Tournament Participation: ${tournamentXp}`)
  }
  
  // Tournament placement
  if (sessionData.tournamentPlacement) {
    const placementXp = calculateTournamentPlacementXp(sessionData.tournamentPlacement, vipInfo)
    bonusXp += placementXp
    breakdown.push(`Tournament Placement #${sessionData.tournamentPlacement}: ${placementXp}`)
  }
  
  const totalXp = wagerXp + bonusXp
  
  return {
    wagerXp,
    bonusXp,
    totalXp,
    breakdown
  }
}

/**
 * Get XP multiplier for special events or promotions
 */
export function getEventXpMultiplier(eventType?: string): number {
  // Define special event multipliers
  const eventMultipliers: Record<string, number> = {
    'DOUBLE_XP_WEEKEND': 2.0,
    'HAPPY_HOUR': 1.5,
    'NEW_GAME_LAUNCH': 1.25,
    'HOLIDAY_BONUS': 1.75
  }
  
  return eventType ? (eventMultipliers[eventType] || 1.0) : 1.0
}

/**
 * Apply event multiplier to XP calculation
 */
export function applyEventMultiplier(baseXp: number, eventType?: string): number {
  const multiplier = getEventXpMultiplier(eventType)
  return Math.floor(baseXp * multiplier)
}
