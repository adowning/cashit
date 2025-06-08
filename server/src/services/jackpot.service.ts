import {
  JACKPOT_CONFIG,
  JackpotUtils,
  type JackpotContributionDto,
  type JackpotWinDto,
  type ProcessJackpotContributionsRequest,
  type ProcessJackpotContributionsResponse,
} from 'shared'
import prisma from '../../prisma/'

export class JackpotService {
  prisma: typeof prisma
  constructor() {
    this.prisma = prisma
  }

  /**
   * Initialize jackpots with default configuration
   */
  async initializeJackpots(): Promise<void> {
    const existingJackpots = await this.prisma.jackpot.findMany()

    if (existingJackpots.length === 0) {
      console.log('Initializing jackpots...')

      for (const [, config] of Object.entries(JACKPOT_CONFIG)) {
        await this.prisma.jackpot.create({
          data: {
            type: config.type,
            currentAmountCoins: config.seedAmountCoins,
            seedAmountCoins: config.seedAmountCoins,
            minimumBetCoins: config.minimumBetCoins,
            contributionRateBasisPoints: config.contributionRateBasisPoints,
            probabilityPerMillion: config.probabilityPerMillion,
            minimumTimeBetweenWinsMinutes: config.minimumTimeBetweenWinsMinutes,
            isActive: true,
          },
        })
      }

      console.log('Jackpots initialized successfully')
    }
  }

  /**
   * Get all active jackpots
   */
  async getActiveJackpots() {
    return await this.prisma.jackpot.findMany({
      where: { isActive: true },
      include: {
        lastWinner: {
          select: {
            id: true,
            username: true,
            avatar: true,
          },
        },
      },
      orderBy: { type: 'asc' },
    })
  }

  /**
   * Process jackpot contributions for a game spin
   */
  async processJackpotContributions(
    request: ProcessJackpotContributionsRequest
  ): Promise<ProcessJackpotContributionsResponse> {
    const { gameSpinId, wagerCoins, gameCategory } = request

    // Only SLOTS games are eligible for jackpots
    if (gameCategory !== 'SLOTS') {
      return {
        contributions: [],
        totalContributionCoins: 0,
      }
    }

    // Get eligible jackpot types for this wager
    const eligibleJackpotTypes = JackpotUtils.getEligibleJackpots(wagerCoins)

    if (eligibleJackpotTypes.length === 0) {
      return {
        contributions: [],
        totalContributionCoins: 0,
      }
    }

    // Get active jackpots
    const activeJackpots = await this.prisma.jackpot.findMany({
      where: {
        isActive: true,
        type: { in: eligibleJackpotTypes },
      },
    })

    const contributions: JackpotContributionDto[] = []
    let totalContributionCoins = 0
    let jackpotWin: JackpotWinDto | undefined

    // Process each eligible jackpot
    for (const jackpot of activeJackpots) {
      const config = JACKPOT_CONFIG[jackpot.type]
      const contributionAmount = JackpotUtils.calculateContribution(
        wagerCoins,
        config.contributionRateBasisPoints
      )

      if (contributionAmount > 0) {
        // Create contribution record
        await this.prisma.jackpotContribution.create({
          data: {
            jackpotId: jackpot.id,
            gameSpinId,
            contributionAmountCoins: contributionAmount,
          },
        })

        // Update jackpot amount
        await this.prisma.jackpot.update({
          where: { id: jackpot.id },
          data: {
            currentAmountCoins: {
              increment: contributionAmount,
            },
          },
        })

        contributions.push({
          jackpotType: jackpot.type,
          contributionAmountCoins: contributionAmount,
          contributionAmountDollars: JackpotUtils.coinsToDollars(contributionAmount),
        })

        totalContributionCoins += contributionAmount

        // Check for jackpot win (only one jackpot can be won per spin)
        if (!jackpotWin && this.shouldWinJackpot(jackpot, config)) {
          jackpotWin = await this.processJackpotWin(jackpot, gameSpinId)
        }
      }
    }

    return {
      contributions,
      totalContributionCoins,
      jackpotWin,
    }
  }

  /**
   * Check if a jackpot should be won
   */
  private shouldWinJackpot(jackpot: any, config: any): boolean {
    // Check minimum time between wins
    if (!JackpotUtils.canWinJackpot(jackpot.lastWonAt, config.minimumTimeBetweenWinsMinutes)) {
      return false
    }

    // Check probability
    return JackpotUtils.checkJackpotWin(config.probabilityPerMillion)
  }

  /**
   * Process a jackpot win
   */
  private async processJackpotWin(jackpot: any, gameSpinId: string): Promise<JackpotWinDto> {
    // Get the game spin to find the winner
    const gameSpin = await this.prisma.gameSpin.findUnique({
      where: { id: gameSpinId },
      include: {
        gameSession: {
          include: {
            refferenceToUserProfile: {
              select: {
                id: true,
                username: true,
              },
            },
          },
        },
      },
    })

    if (!gameSpin) {
      throw new Error('Game spin not found')
    }

    const winnerId = gameSpin.gameSession.refferenceToUserProfile.id
    const winnerUsername = gameSpin.gameSession.refferenceToUserProfile.username
    const winAmount = jackpot.currentAmountCoins

    // Create jackpot win record
    const jackpotWin = await this.prisma.jackpotWin.create({
      data: {
        jackpotId: jackpot.id,
        winnerId,
        winAmountCoins: winAmount,
        gameSpinId,
      },
    })

    // Reset jackpot to random seed amount
    const newSeedAmount = JackpotUtils.generateRandomSeedAmount(jackpot.seedAmountCoins)

    await this.prisma.jackpot.update({
      where: { id: jackpot.id },
      data: {
        currentAmountCoins: newSeedAmount,
        lastWonAt: new Date(),
        lastWonBy: winnerId,
      },
    })

    // Create transaction for the win (this will be handled by the transaction service)
    // For now, we'll return the win data and let the calling service handle the transaction

    return {
      id: jackpotWin.id,
      jackpotType: jackpot.type,
      winAmountCoins: winAmount,
      winAmountDollars: JackpotUtils.coinsToDollars(winAmount),
      winnerUsername,
      gameSpinId,
      createdAt: jackpotWin.createdAt,
    }
  }

  /**
   * Get jackpot statistics
   */
  async getJackpotStats() {
    const jackpots = await this.getActiveJackpots()

    interface JackpotWithWinner {
      type: any
      currentAmountCoins: any
      lastWonAt: any
      lastWinner?: {
        username: string | null
      } | null
    }

    const stats = {
      totalPoolCoins: jackpots.reduce((sum, j) => sum + j.currentAmountCoins, 0),
      totalPoolDollars: 0,
      jackpots: jackpots.map((j: JackpotWithWinner) => ({
        type: j.type,
        currentAmountCoins: j.currentAmountCoins,
        currentAmountDollars: JackpotUtils.coinsToDollars(j.currentAmountCoins),
        lastWonAt: j.lastWonAt,
        lastWinnerUsername: j.lastWinner?.username || null,
      })),
    }

    stats.totalPoolDollars = JackpotUtils.coinsToDollars(stats.totalPoolCoins)

    return stats
  }

  /**
   * Get recent jackpot wins
   */
  async getRecentJackpotWins(limit: number = 10) {
    return await this.prisma.jackpotWin.findMany({
      take: limit,
      orderBy: { createdAt: 'desc' },
      include: {
        jackpot: {
          select: {
            type: true,
          },
        },
        winner: {
          select: {
            username: true,
            avatar: true,
          },
        },
      },
    })
  }

  /**
   * Get jackpot contribution history for a user
   */
  async getUserJackpotContributions(userId: string, limit: number = 50) {
    return await this.prisma.jackpotContribution.findMany({
      where: {
        gameSpin: {
          gameSession: {
            refferenceToUserProfile: {
              id: userId,
            },
          },
        },
      },
      take: limit,
      orderBy: { createdAt: 'desc' },
      include: {
        jackpot: {
          select: {
            type: true,
          },
        },
      },
    })
  }

  /**
   * Get jackpot wins for a user
   */
  async getUserJackpotWins(userId: string) {
    return await this.prisma.jackpotWin.findMany({
      where: { winnerId: userId },
      orderBy: { createdAt: 'desc' },
      include: {
        jackpot: {
          select: {
            type: true,
          },
        },
      },
    })
  }
}
