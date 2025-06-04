import prisma from '../../prisma/'
import { JackpotService } from './jackpot.service.js'
import { type ProcessJackpotContributionsResponse, type JackpotWinDto } from 'shared'

export interface GameSpinProcessingResult {
  gameSpinId: string
  jackpotContributions: ProcessJackpotContributionsResponse
  transactionIds: string[]
}

export interface CreateGameSpinRequest {
  gameSessionId: string
  sessionId: string
  spinNumber: number
  wagerAmount: number
  grossWinAmount: number
  currencyId?: string
  spinData?: any
}

export class GameSpinService {
  private jackpotService: JackpotService
  prisma: typeof prisma

  constructor() {
    this.jackpotService = new JackpotService()
    this.prisma = prisma
  }

  /**
   * Process a complete game spin including jackpot contributions
   */
  async processGameSpin(request: CreateGameSpinRequest): Promise<GameSpinProcessingResult> {
    const {
      gameSessionId,
      sessionId,
      spinNumber,
      wagerAmount,
      grossWinAmount,
      currencyId,
      spinData,
    } = request

    // Get game session with game info to check category
    const gameSession = await this.prisma.gameSession.findUnique({
      where: { id: gameSessionId },
      include: {
        game: {
          select: {
            id: true,
            category: true,
            name: true,
          },
        },
      },
    })

    if (!gameSession) {
      throw new Error('Game session not found')
    }

    // Create the game spin record
    const gameSpin = await this.prisma.gameSpin.create({
      data: {
        gameSessionId,
        sessionId,
        spinNumber,
        wagerAmount,
        grossWinAmount,
        currencyId,
        timeStamp: new Date(),
        spinData,
      },
    })

    // Update game session totals
    await this.prisma.gameSession.update({
      where: { id: gameSessionId },
      data: {
        totalWagered: {
          increment: wagerAmount,
        },
        totalWon: {
          increment: grossWinAmount,
        },
      },
    })

    // Process jackpot contributions (only for SLOTS games)
    const jackpotContributions = await this.jackpotService.processJackpotContributions({
      gameSpinId: gameSpin.id,
      wagerCoins: wagerAmount, // Assuming wagerAmount is already in coins
      gameCategory: gameSession.game.category,
    })

    // Handle jackpot win transaction if there was a win
    const transactionIds: string[] = []

    if (jackpotContributions.jackpotWin) {
      const jackpotWinTransactionId = await this.createJackpotWinTransaction(
        jackpotContributions.jackpotWin,
        gameSession.userId
      )
      transactionIds.push(jackpotWinTransactionId)
    }

    return {
      gameSpinId: gameSpin.id,
      jackpotContributions,
      transactionIds,
    }
  }

  /**
   * Create a transaction for a jackpot win
   */
  private async createJackpotWinTransaction(
    jackpotWin: JackpotWinDto,
    userId: string
  ): Promise<string> {
    // Get user's wallet (assuming they have a primary wallet)
    const userWallet = await this.prisma.wallet.findFirst({
      where: {
        userId,
        isActive: true,
      },
    })

    if (!userWallet) {
      throw new Error('User wallet not found')
    }

    // Create the jackpot win transaction
    const transaction = await this.prisma.transaction.create({
      data: {
        type: 'JACKPOT_WIN',
        status: 'COMPLETED',
        amount: jackpotWin.winAmountCoins,
        netAmount: jackpotWin.winAmountCoins,
        description: `${jackpotWin.jackpotType} Jackpot Win`,
        balanceBefore: userWallet.balance,
        balanceAfter: userWallet.balance + jackpotWin.winAmountCoins,
        userProfileId: userId,
        walletId: userWallet.id,
        metadata: {
          jackpotType: jackpotWin.jackpotType,
          gameSpinId: jackpotWin.gameSpinId,
          jackpotWinId: jackpotWin.id,
        },
      },
    })

    // Update wallet balance
    await this.prisma.wallet.update({
      where: { id: userWallet.id },
      data: {
        balance: {
          increment: jackpotWin.winAmountCoins,
        },
      },
    })

    // Link the transaction to the jackpot win
    await this.prisma.jackpotWin.update({
      where: { id: jackpotWin.id },
      data: {
        transactionId: transaction.id,
      },
    })

    return transaction.id
  }

  /**
   * Get game spin with jackpot information
   */
  async getGameSpinWithJackpots(gameSpinId: string) {
    return await this.prisma.gameSpin.findUnique({
      where: { id: gameSpinId },
      include: {
        gameSession: {
          include: {
            game: {
              select: {
                id: true,
                name: true,
                category: true,
              },
            },
            refferenceToUserProfile: {
              select: {
                id: true,
                username: true,
                avatar: true,
              },
            },
          },
        },
        jackpotContributions: {
          include: {
            jackpot: {
              select: {
                id: true,
                type: true,
                currentAmountCoins: true,
              },
            },
          },
        },
        jackpotWin: {
          include: {
            jackpot: {
              select: {
                id: true,
                type: true,
              },
            },
            transaction: {
              select: {
                id: true,
                amount: true,
                status: true,
              },
            },
          },
        },
      },
    })
  }

  /**
   * Get recent spins with jackpot activity
   */
  async getRecentSpinsWithJackpots(limit: number = 20) {
    return await this.prisma.gameSpin.findMany({
      where: {
        OR: [{ jackpotContributions: { some: {} } }, { jackpotWin: { isNot: null } }],
      },
      take: limit,
      orderBy: { createdAt: 'desc' },
      include: {
        gameSession: {
          include: {
            game: {
              select: {
                id: true,
                name: true,
                category: true,
              },
            },
            refferenceToUserProfile: {
              select: {
                id: true,
                username: true,
                avatar: true,
              },
            },
          },
        },
        jackpotContributions: {
          include: {
            jackpot: {
              select: {
                id: true,
                type: true,
              },
            },
          },
        },
        jackpotWin: {
          include: {
            jackpot: {
              select: {
                id: true,
                type: true,
              },
            },
          },
        },
      },
    })
  }

  /**
   * Get jackpot statistics for a specific game
   */
  async getGameJackpotStats(gameId: string) {
    const totalContributions = await this.prisma.jackpotContribution.aggregate({
      where: {
        gameSpin: {
          gameSession: {
            gameId,
          },
        },
      },
      _sum: {
        contributionAmountCoins: true,
      },
      _count: true,
    })

    const totalWins = await this.prisma.jackpotWin.aggregate({
      where: {
        gameSpin: {
          gameSession: {
            gameId,
          },
        },
      },
      _sum: {
        winAmountCoins: true,
      },
      _count: true,
    })

    return {
      totalContributionsCoins: totalContributions._sum.contributionAmountCoins || 0,
      totalContributionCount: totalContributions._count,
      totalWinsCoins: totalWins._sum.winAmountCoins || 0,
      totalWinCount: totalWins._count,
    }
  }

  /**
   * Initialize jackpots on service startup
   */
  async initializeJackpots(): Promise<void> {
    await this.jackpotService.initializeJackpots()
  }
}
