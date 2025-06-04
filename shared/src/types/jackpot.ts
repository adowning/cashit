import type { PrismaUserProfile, PrismaJackpotType } from './prisma'

/**
 * Jackpot Types and Interfaces
 * All amounts are in coins (100 coins = $1.00)
 */

// Re-export the Prisma-generated JackpotType enum to avoid conflicts
export type JackpotType = PrismaJackpotType

// Create enum-like object for runtime usage
export const JackpotType = {
  MINOR: 'MINOR' as const,
  MAJOR: 'MAJOR' as const,
  GRAND: 'GRAND' as const,
} as const

export interface Jackpot {
  id: string
  type: JackpotType
  currentAmountCoins: number // Amount in coins (100 coins = $1)
  seedAmountCoins: number // Base amount when reset
  minimumBetCoins: number // Minimum bet to be eligible
  contributionRateBasisPoints: number // Rate in basis points (10000 = 100%)
  probabilityPerMillion: number // Probability per million spins
  minimumTimeBetweenWinsMinutes: number // Minimum time between wins
  lastWonAt: Date | null
  lastWonBy: string | null // UserProfile ID
  isActive: boolean
  createdAt: Date
  updatedAt: Date
  lastWinner?: PrismaUserProfile
}

export interface JackpotContribution {
  id: string
  jackpotId: string
  gameSpinId: string
  contributionAmountCoins: number // Amount in coins contributed to this jackpot
  createdAt: Date
}

export interface JackpotWin {
  id: string
  jackpotId: string
  winnerId: string
  winAmountCoins: number // Amount won in coins
  gameSpinId: string
  transactionId: string | null
  createdAt: Date
  jackpot?: Jackpot
  winner?: PrismaUserProfile
}

/**
 * Jackpot Configuration Constants
 */
export const JACKPOT_CONFIG = {
  MINOR: {
    type: JackpotType.MINOR,
    seedAmountCoins: 100, // $1.00
    minimumBetCoins: 1, // $0.01
    contributionRateBasisPoints: 10, // 0.1%
    probabilityPerMillion: 1000, // 0.1% chance per spin
    minimumTimeBetweenWinsMinutes: 5, // 5 minutes
  },
  MAJOR: {
    type: JackpotType.MAJOR,
    seedAmountCoins: 1000, // $10.00
    minimumBetCoins: 100, // $1.00
    contributionRateBasisPoints: 5, // 0.05%
    probabilityPerMillion: 100, // 0.01% chance per spin
    minimumTimeBetweenWinsMinutes: 30, // 30 minutes
  },
  GRAND: {
    type: JackpotType.GRAND,
    seedAmountCoins: 10000, // $100.00
    minimumBetCoins: 400, // $4.00
    contributionRateBasisPoints: 2.5, // 0.025%
    probabilityPerMillion: 10, // 0.001% chance per spin
    minimumTimeBetweenWinsMinutes: 120, // 2 hours
  },
} as const

/**
 * Helper functions for jackpot calculations
 */
export const JackpotUtils = {
  /**
   * Convert coins to dollars for display
   */
  coinsToDollars: (coins: number): number => coins / 100,

  /**
   * Convert dollars to coins for storage
   */
  dollarsToCoins: (dollars: number): number => Math.round(dollars * 100),

  /**
   * Calculate contribution amount for a wager
   */
  calculateContribution: (wagerCoins: number, contributionRateBasisPoints: number): number => {
    return Math.floor((wagerCoins * contributionRateBasisPoints) / 10000)
  },

  /**
   * Check if a bet is eligible for a jackpot type
   */
  isEligibleForJackpot: (wagerCoins: number, jackpotType: JackpotType): boolean => {
    const config = JACKPOT_CONFIG[jackpotType]
    return wagerCoins >= config.minimumBetCoins
  },

  /**
   * Get eligible jackpot types for a wager amount
   */
  getEligibleJackpots: (wagerCoins: number): JackpotType[] => {
    const eligible: JackpotType[] = []

    if (wagerCoins >= JACKPOT_CONFIG.MINOR.minimumBetCoins) {
      eligible.push(JackpotType.MINOR)
    }
    if (wagerCoins >= JACKPOT_CONFIG.MAJOR.minimumBetCoins) {
      eligible.push(JackpotType.MAJOR)
    }
    if (wagerCoins >= JACKPOT_CONFIG.GRAND.minimumBetCoins) {
      eligible.push(JackpotType.GRAND)
    }

    return eligible
  },

  /**
   * Calculate total contribution for all eligible jackpots
   */
  calculateTotalContribution: (wagerCoins: number): number => {
    const eligibleJackpots = JackpotUtils.getEligibleJackpots(wagerCoins)

    return eligibleJackpots.reduce((total, jackpotType) => {
      const config = JACKPOT_CONFIG[jackpotType]
      return (
        total + JackpotUtils.calculateContribution(wagerCoins, config.contributionRateBasisPoints)
      )
    }, 0)
  },

  /**
   * Generate a random seed amount around the base seed (±10%)
   */
  generateRandomSeedAmount: (baseSeedCoins: number): number => {
    const variation = Math.floor(baseSeedCoins * 0.1) // 10% variation
    const randomOffset = Math.floor(Math.random() * (variation * 2 + 1)) - variation
    return baseSeedCoins + randomOffset
  },

  /**
   * Check if enough time has passed since last win
   */
  canWinJackpot: (lastWonAt: Date | null, minimumTimeBetweenWinsMinutes: number): boolean => {
    if (!lastWonAt) return true

    const now = new Date()
    const timeDiffMinutes = (now.getTime() - lastWonAt.getTime()) / (1000 * 60)
    return timeDiffMinutes >= minimumTimeBetweenWinsMinutes
  },

  /**
   * Determine if a spin wins a jackpot based on probability
   */
  checkJackpotWin: (probabilityPerMillion: number): boolean => {
    const randomNumber = Math.floor(Math.random() * 1000000)
    return randomNumber < probabilityPerMillion
  },
}

/**
 * DTOs for API responses
 */
export interface JackpotDisplayDto {
  id: string
  type: JackpotType
  currentAmountDollars: number // Converted to dollars for display
  lastWonAt: Date | null
  lastWinnerUsername: string | null
}

export interface JackpotContributionDto {
  jackpotType: JackpotType
  contributionAmountCoins: number
  contributionAmountDollars: number
}

export interface JackpotWinDto {
  id: string
  jackpotType: JackpotType
  winAmountCoins: number
  winAmountDollars: number
  winnerUsername: string
  gameSpinId: string
  createdAt: Date
}

/**
 * Request/Response types for jackpot operations
 */
export interface GetJackpotsResponse {
  jackpots: JackpotDisplayDto[]
}

export interface ProcessJackpotContributionsRequest {
  gameSpinId: string
  wagerCoins: number
  gameCategory: string // Should be 'SLOTS' for jackpot eligibility
}

export interface ProcessJackpotContributionsResponse {
  contributions: JackpotContributionDto[]
  totalContributionCoins: number
  jackpotWin?: JackpotWinDto
}
