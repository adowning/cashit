import prisma from '@/prisma/'
import { JackpotService } from './jackpot.service'
import { type ProcessJackpotContributionsResponse, type JackpotWinDto } from '@/types'

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
        // Update game session totals here...
        totalWagered: { increment: wagerAmount },

        totalWon: { increment: grossWinAmount },
      },
    })
    // Process jackpot contributions
    const jackpotContributions = await this.jackpotService.processJackpotContributions({
      gameSpinId: gameSpin.id,
      wagerCoins: wagerAmount,
      gameCategory: gameSession.game.category,
  })

      //@ts-ignore
    // Create transactions for jackpot wins
    const transactionIds = await this.createJackpotWinTransaction(jackpotContributions,gameSpin.userId)

    return {
      gameSpinId: gameSpin.id,
      jackpotContributions,
      //@ts-ignore
      transactionIds,
    }
  }

  /**
   * Create a transaction for a jackpot win
   */
  async createJackpotWinTransaction(
    jackpotWin: JackpotWinDto,
    userId: string
  ): Promise<string> {
    // Create a new transaction for the jackpot win
    const transaction = await this.prisma.transaction.create({
      data: {
        userProfileId: userId,
        amount: jackpotWin.winAmountCoins,
        type: 'JACKPOT_WIN',
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
    }) as any
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

      // jackpotContributions: {
      //   include: {
      //     jackpot: {
      //       select: {
      //         id: true,
      //         type: true,
      //       },
      //     },
      //   },
      // },
      // jackpotWin: {
      //   include: {
      //     jackpot: {
      //       select: {
      //         id: true,
      //         type: true,
      //       },
      //     },
      //   },
      },
  },
}) as any[]
  }
}
  /**
   * Get jackpot statistics for a specific game
   */
  // async getGameJackpotStats(gameId: string) {
  //   const totalContributions = await prisma.jackpotContribution.aggregate({
  //     where: {
  //       gameSpin: {
  //         gameSession: {
  //           gameId,
  //         },
  //       },
  //     },
  //     _sum: {
  //       contributionAmountCoins: true,
  //     },
  //     _count: true,
  //   })

  //   const totalWins = await prisma.jackpotWin.aggregate({
  //     where: {
  //       gameSpin: {
  //         gameSession: {
  //           gameId,
  //         },
  //       },
  //     },
  //     _sum: {
  //       winAmountCoins: true,
  //     },
  //     _count: true,
  //   })

  //   return {
  //     totalContributionsCoins: totalContributions?._sum?.contributionAmountCoins ?? 0,
  //     totalContributionCount: totalContributions?._count ?? 0,
  //     totalWinsCoins: totalWins?._sum?.winAmountCoins ?? 0,
  //     totalWinCount: totalWins?._count ?? 0,
  //   }
  // }
  //     }

  /**
   * Initialize jackpots on service startup
   */
  // async initializeJackpots(): Promise<void> {
    // Initialize jackpots here...
//   }

//   private async createJackpotWinTransactions(jackpotContributions: ProcessJackpotContributionsResponse): Promise<string[]> {
//     const transactionIds: string[] = []

//     for (const contribution of jackpotContributions.contributions) {
//       if (contribution.jackpotWin) {
//         const transactionId = await this.createJackpotWinTransaction(contribution.jackpotWin, contribution.userId)
//         transactionIds.push(transactionId)
//       }
//     }

//     return transactionIds
//   }
// }