import { Context } from 'hono'
import { User, Session } from 'better-auth/types'
import {
  getOrCreateWallet,
  createTransactionRecord,
  updateWalletBalance,
  toCents,
} from './transaction.service.js'
import { GameSpinService } from './game-spin.service.js'
import { recordTournamentPoints, getTournamentLeaderboard } from './tournament.service.js'
import { typedAppEventEmitter, AppEvents } from '../lib/events.js'
import type { RTGSpinRequestDto, ProviderSpinResponseData, RtgSpinResult } from 'shared'
import { TransactionType, TransactionStatus } from '../../prisma/generated/index.js'
import type { Prisma } from '../../prisma/generated/index.js'
import prisma from '../../prisma/index.js'

const db = prisma
// Performance measurement interface
interface PerformanceMetrics {
  totalExecutionTime: number
  userProfileQueryTime: number
  providerConfigQueryTime: number
  platformGameQueryTime: number
  activeGameSessionQueryTime: number
  walletCheckQueryTime: number
  rgsCallTime: number
  mainTransactionTime: number
  jackpotProcessingTime: number
  tournamentProcessingTime: number
  dbCallCount: number
  cacheHits: number
  cacheMisses: number
}

// Performance logger utility
class PerformanceLogger {
  public metrics: PerformanceMetrics
  private startTime: number
  private logFile: string

  constructor() {
    this.metrics = {
      totalExecutionTime: 0,
      userProfileQueryTime: 0,
      providerConfigQueryTime: 0,
      platformGameQueryTime: 0,
      activeGameSessionQueryTime: 0,
      walletCheckQueryTime: 0,
      rgsCallTime: 0,
      mainTransactionTime: 0,
      jackpotProcessingTime: 0,
      tournamentProcessingTime: 0,
      dbCallCount: 0,
      cacheHits: 0,
      cacheMisses: 0,
    }
    this.startTime = Bun.nanoseconds()
    this.logFile = `performance-logs/rtg-spin-${Date.now()}.txt`
  }

  startTimer(): number {
    return Bun.nanoseconds()
  }

  endTimer(startTime: number): number {
    return (Bun.nanoseconds() - startTime) / 1000000 // Convert to milliseconds
  }

  incrementDbCall() {
    this.metrics.dbCallCount++
  }

  incrementCacheHit() {
    this.metrics.cacheHits++
  }

  incrementCacheMiss() {
    this.metrics.cacheMisses++
  }

  async logMetrics(userId: string, gameId: string, success: boolean, error?: string) {
    this.metrics.totalExecutionTime = this.endTimer(this.startTime)

    const logEntry = {
      timestamp: new Date().toISOString(),
      userId,
      gameId,
      success,
      error,
      metrics: this.metrics,
      cacheHitRate:
        (this.metrics.cacheHits / (this.metrics.cacheHits + this.metrics.cacheMisses)) * 100,
      avgDbCallTime: this.metrics.totalExecutionTime / this.metrics.dbCallCount,
    }

    const logText = `
=== RTG SPIN PERFORMANCE LOG ===
Timestamp: ${logEntry.timestamp}
User ID: ${logEntry.userId}
Game ID: ${logEntry.gameId}
Success: ${logEntry.success}
${error ? `Error: ${error}` : ''}

PERFORMANCE METRICS:
- Total Execution Time: ${this.metrics.totalExecutionTime.toFixed(2)}ms
- User Profile Query: ${this.metrics.userProfileQueryTime.toFixed(2)}ms
- Provider Config Query: ${this.metrics.providerConfigQueryTime.toFixed(2)}ms
- Platform Game Query: ${this.metrics.platformGameQueryTime.toFixed(2)}ms
- Active Game Session Query: ${this.metrics.activeGameSessionQueryTime.toFixed(2)}ms
- Wallet Check Query: ${this.metrics.walletCheckQueryTime.toFixed(2)}ms
- RGS Call Time: ${this.metrics.rgsCallTime.toFixed(2)}ms
- Main Transaction Time: ${this.metrics.mainTransactionTime.toFixed(2)}ms
- Jackpot Processing Time: ${this.metrics.jackpotProcessingTime.toFixed(2)}ms
- Tournament Processing Time: ${this.metrics.tournamentProcessingTime.toFixed(2)}ms

DATABASE METRICS:
- Total DB Calls: ${this.metrics.dbCallCount}
- Average DB Call Time: ${logEntry.avgDbCallTime.toFixed(2)}ms

CACHE METRICS:
- Cache Hits: ${this.metrics.cacheHits}
- Cache Misses: ${this.metrics.cacheMisses}
- Cache Hit Rate: ${logEntry.cacheHitRate.toFixed(2)}%

PERFORMANCE BREAKDOWN:
- Initial DB Queries: ${(((this.metrics.userProfileQueryTime + this.metrics.providerConfigQueryTime + this.metrics.platformGameQueryTime + this.metrics.activeGameSessionQueryTime + this.metrics.walletCheckQueryTime) / this.metrics.totalExecutionTime) * 100).toFixed(2)}%
- RGS Call: ${((this.metrics.rgsCallTime / this.metrics.totalExecutionTime) * 100).toFixed(2)}%
- Main Transaction: ${((this.metrics.mainTransactionTime / this.metrics.totalExecutionTime) * 100).toFixed(2)}%
- Jackpot Processing: ${((this.metrics.jackpotProcessingTime / this.metrics.totalExecutionTime) * 100).toFixed(2)}%
- Tournament Processing: ${((this.metrics.tournamentProcessingTime / this.metrics.totalExecutionTime) * 100).toFixed(2)}%

TOP 5 HOTTEST QUERIES IDENTIFIED:
1. User Profile + VIP Query: ${this.metrics.userProfileQueryTime.toFixed(2)}ms
2. Main Transaction Block: ${this.metrics.mainTransactionTime.toFixed(2)}ms  
3. Jackpot Processing: ${this.metrics.jackpotProcessingTime.toFixed(2)}ms
4. Tournament Processing: ${this.metrics.tournamentProcessingTime.toFixed(2)}ms
5. Wallet Check Query: ${this.metrics.walletCheckQueryTime.toFixed(2)}ms

OPTIMIZATION RECOMMENDATIONS:
- Cache user profiles with VIP info (TTL: 5 minutes)
- Cache wallet data with optimistic locking (TTL: 30 seconds)
- Cache active jackpots state (TTL: 10 seconds)
- Cache active tournaments (TTL: 1 minute)
- Batch jackpot contribution inserts
- Use Bun.sql for hot path queries

=====================================

`

    try {
      await Bun.write(this.logFile, logText, { createPath: true })
      console.log(`🔍 Performance metrics logged to: ${this.logFile}`)
    } catch (err) {
      console.error('❌ Failed to write performance log:', err)
    }
  }
}

// Import the handlePlatformGameRound function from the original service
import {
  fromCentsToFloat,
  getProviderConfig,
  handlePlatformGameRound,
  proxyRequestToRgs,
  RgsProxyError,
} from './rtg.service.js'

///rtg/games/rtg/platform/0Fnal8tl5RQwjg2nHZXkeD2jNTBnJiPO/777Strike/game/settings
export async function rtgSpinWithPerformanceMetrics(
  c: Context,
  buser: User,
  session: Session,
  platformGameId: string
): Promise<Response> {
  const perfLogger = new PerformanceLogger()
  let success = false
  let errorMessage = ''

  try {
    // 1. User Profile Query with VIP Info (HOTTEST QUERY #1)
    console.log('🔍 [1/8] Starting user profile + VIP query...')
    const userQueryStart = perfLogger.startTimer()
    perfLogger.incrementDbCall()
    perfLogger.incrementCacheMiss() // Will be cache hit after optimization

    const user = await db.userProfile.findUnique({
      where: { id: buser.id },
      include: { vipInfo: true },
    })

    perfLogger.metrics.userProfileQueryTime = perfLogger.endTimer(userQueryStart)
    console.log(
      `✅ User profile query completed in ${perfLogger.metrics.userProfileQueryTime.toFixed(2)}ms`
    )

    if (!user || !session || !user.vipInfo) {
      errorMessage = 'UNAUTHENTICATED_OR_INCOMPLETE_DATA'
      await perfLogger.logMetrics(buser.id, platformGameId, false, errorMessage)
      return c.json({ success: false, error: errorMessage }, 401)
    }

    // 2. Provider Config Query
    console.log('🔍 [2/8] Starting provider config query...')
    const providerQueryStart = perfLogger.startTimer()
    perfLogger.incrementDbCall()
    perfLogger.incrementCacheMiss() // Will be cache hit after optimization

    const providerName = 'RTG'
    const _rtgProviderConfig = await getProviderConfig(providerName) // For timing measurement

    perfLogger.metrics.providerConfigQueryTime = perfLogger.endTimer(providerQueryStart)
    console.log(
      `✅ Provider config query completed in ${perfLogger.metrics.providerConfigQueryTime.toFixed(2)}ms`
    )

    // 3. Platform Game Query
    console.log('🔍 [3/8] Starting platform game query...')
    const gameQueryStart = perfLogger.startTimer()
    perfLogger.incrementDbCall()
    perfLogger.incrementCacheMiss() // Will be cache hit after optimization

    const platformGame = await db.game.findFirst({ where: { name: platformGameId + 'RTG' } })

    perfLogger.metrics.platformGameQueryTime = perfLogger.endTimer(gameQueryStart)
    console.log(
      `✅ Platform game query completed in ${perfLogger.metrics.platformGameQueryTime.toFixed(2)}ms`
    )

    if (!platformGame || !platformGame.name) {
      errorMessage = 'GAME_NOT_FOUND_OR_PROVIDER_GAME_ID_MISSING'
      await perfLogger.logMetrics(user.id, platformGameId, false, errorMessage)
      return c.json({ success: false, error: errorMessage }, 404)
    }

    const rtgGameId = platformGame.name

    // 4. Parse Client Request
    console.log('🔍 [4/8] Parsing client spin request...')
    const clientSpinRequestImport = await c.req.json()
    const clientSpinRequest = clientSpinRequestImport as unknown as RTGSpinRequestDto

    // 5. Active Game Session Query (HOTTEST QUERY #5)
    console.log('🔍 [5/8] Starting active game session query...')
    const sessionQueryStart = perfLogger.startTimer()
    perfLogger.incrementDbCall()
    perfLogger.incrementCacheMiss() // Will be cache hit after optimization

    const activeGameSession = await db.gameSession.findFirst({
      where: {
        userId: user.id,
        gameId: platformGame.id,
        isActive: true,
      },
    })

    perfLogger.metrics.activeGameSessionQueryTime = perfLogger.endTimer(sessionQueryStart)
    console.log(
      `✅ Active game session query completed in ${perfLogger.metrics.activeGameSessionQueryTime.toFixed(2)}ms`
    )

    if (!activeGameSession || !activeGameSession.currencyId) {
      errorMessage = 'NO_ACTIVE_VALID_SESSION'
      await perfLogger.logMetrics(user.id, platformGameId, false, errorMessage)
      return c.json({ success: false, error: { code: errorMessage } }, 400)
    }

    const currencyId = activeGameSession.currencyId
    const wagerAmountCents = toCents(parseFloat(clientSpinRequest.stake.toString()))

    // 6. Wallet Check Query (HOTTEST QUERY #4)
    console.log('🔍 [6/8] Starting wallet check query...')
    const walletQueryStart = perfLogger.startTimer()
    perfLogger.incrementDbCall()
    perfLogger.incrementCacheMiss() // Will be cache hit after optimization

    const operatorId = user.operatorId
    const wallet = await getOrCreateWallet(user.id, currencyId, operatorId!, db)

    perfLogger.metrics.walletCheckQueryTime = perfLogger.endTimer(walletQueryStart)
    console.log(
      `✅ Wallet check query completed in ${perfLogger.metrics.walletCheckQueryTime.toFixed(2)}ms`
    )

    if (toCents(wallet.balance) < wagerAmountCents) {
      errorMessage = 'INSUFFICIENT_FUNDS'
      await perfLogger.logMetrics(user.id, platformGameId, false, errorMessage)
      return c.json({ success: false, error: { msg: errorMessage } }, 200)
    }

    // Emit pre-transaction balance update event
    typedAppEventEmitter.emit(AppEvents.USER_BALANCE_UPDATED, {
      userId: user.id,
      newBalance: wallet.balance - wagerAmountCents,
      table: 'wallets',
      changeAmount: fromCentsToFloat(wagerAmountCents) * -1,
      transactionType: TransactionType.BET,
      relatedTransactionId: 'pre-transaction',
    })

    // 7. RGS Call (External API)
    console.log('🔍 [7/8] Starting RGS call...')
    const rgsCallStart = perfLogger.startTimer()

    let rgsSpinResponse: ProviderSpinResponseData
    const DEVMODE = clientSpinRequest.playMode === 'test' ? true : false

    if (DEVMODE == false) {
      const rgsResponse = await proxyRequestToRgs<
        typeof clientSpinRequest,
        ProviderSpinResponseData
      >('spin', 'POST', clientSpinRequest, session.token)
      rgsSpinResponse = (rgsResponse as any).result as ProviderSpinResponseData
    } else {
      const importedData = (await import('./json/rtg-spin-lose.result.json')) as any
      rgsSpinResponse = importedData.default[0].result as ProviderSpinResponseData
    }

    perfLogger.metrics.rgsCallTime = perfLogger.endTimer(rgsCallStart)
    console.log(`✅ RGS call completed in ${perfLogger.metrics.rgsCallTime.toFixed(2)}ms`)

    if (
      !rgsSpinResponse.game ||
      rgsSpinResponse.game.win?.total === undefined ||
      !rgsSpinResponse.transactions
    ) {
      throw new Error('Invalid RGS spin response structure.')
    }

    const actualWinAmountCents = toCents(parseFloat(rgsSpinResponse.game.win.total.toString()))
    const providerRoundIdFromRgs = rgsSpinResponse.transactions.roundId?.toString()

    // 8. Main Transaction Block (HOTTEST QUERY #2)
    console.log('🔍 [8/8] Starting main transaction block...')
    const transactionStart = perfLogger.startTimer()
    perfLogger.incrementDbCall()

    const platformUpdates = await db.$transaction(
      async (tx: any) => {
        return handlePlatformGameRound(
          {
            userId: user.id,
            platformGameId: platformGame.id,
            providerName,
            providerGameId: rtgGameId,
            providerRoundId: providerRoundIdFromRgs,
            providerSessionId: (clientSpinRequest as any).sessionId,
            wagerAmountCents,
            operatorId: user.operatorId!,
            winAmountCents: actualWinAmountCents,
            currencyId,
            rgsRawResponse: rgsSpinResponse,
            user,
          },
          tx
        )
      },
      {
        timeout: 10000,
      }
    )

    perfLogger.metrics.mainTransactionTime = perfLogger.endTimer(transactionStart)
    console.log(
      `✅ Main transaction completed in ${perfLogger.metrics.mainTransactionTime.toFixed(2)}ms`
    )

    // 9. Jackpot Processing (HOTTEST QUERY #3)
    console.log('🔍 [9/9] Starting jackpot processing...')
    const jackpotStart = perfLogger.startTimer()

    try {
      const gameSpinService = new GameSpinService()
      const jackpotResult = await gameSpinService.processGameSpin({
        gameSessionId: platformUpdates.updatedGameSession.id,
        sessionId: (clientSpinRequest as any).sessionId,
        spinNumber: (platformUpdates.updatedGameSession.totalWagered || 0) + 1,
        wagerAmount: wagerAmountCents,
        grossWinAmount: actualWinAmountCents,
        currencyId,
        spinData: {
          providerRoundId: providerRoundIdFromRgs || `spin-${Date.now()}`,
          rgsRawResponse: rgsSpinResponse,
        },
      })

      // Handle jackpot wins if any
      if (jackpotResult.jackpotContributions.jackpotWin) {
        const jackpotWinAmountCents = jackpotResult.jackpotContributions.jackpotWin.winAmountCoins

        // Update game spin record with jackpot information
        await db.gameSpin.update({
          where: { id: platformUpdates.gameSpinRecord.id },
          data: {
            grossWinAmount: actualWinAmountCents + jackpotWinAmountCents,
            spinData: {
              ...(platformUpdates.gameSpinRecord.spinData as any),
              jackpotWin: jackpotResult.jackpotContributions.jackpotWin,
              jackpotContributions: jackpotResult.jackpotContributions.contributions,
            } as Prisma.JsonObject,
          },
        })

        // Create separate jackpot win transaction
        await db.$transaction(async (tx: any) => {
          const wallet = await getOrCreateWallet(user.id, currencyId, user.operatorId!, tx)
          const jackpotWinTx = await createTransactionRecord(
            {
              userId: user.id,
              type: TransactionType.WIN,
              status: TransactionStatus.COMPLETED,
              amountInCents: jackpotWinAmountCents,
              operatorId: user.operatorId!,
              description: `Jackpot win on ${providerName} game ${rtgGameId}`,
              provider: providerName,
              providerTxId: `jackpot-${providerRoundIdFromRgs || Date.now()}`,
              gameId: platformGame.id,
              balanceBeforeInCents: toCents(wallet.balance),
            },
            tx
          )

          const updatedWallet = await updateWalletBalance(
            wallet.id,
            jackpotWinAmountCents,
            'balance',
            tx
          )

          await tx.transaction.update({
            where: { id: jackpotWinTx.id },
            data: {
              balanceAfter: toCents(updatedWallet.balance),
              metadata: {
                jackpotType:
                  jackpotResult.jackpotContributions.jackpotWin?.jackpotType || 'unknown',
                gameSpinId: platformUpdates.gameSpinRecord.id,
              } as Prisma.JsonObject,
            },
          })
        })
      }
    } catch (jackpotError) {
      console.error('❌ Error processing jackpots:', jackpotError)
    }

    perfLogger.metrics.jackpotProcessingTime = perfLogger.endTimer(jackpotStart)
    console.log(
      `✅ Jackpot processing completed in ${perfLogger.metrics.jackpotProcessingTime.toFixed(2)}ms`
    )

    // 10. Tournament Processing (HOTTEST QUERY #4)
    console.log('🔍 [10/10] Starting tournament processing...')
    const tournamentStart = perfLogger.startTimer()

    const pointsForTournament = Math.floor(wagerAmountCents / 100)
    if (pointsForTournament > 0 && platformUpdates.gameSpinRecord?.id) {
      try {
        const tournamentIdsToUpdate = await db.$transaction(
          async (tx: any) => {
            return await recordTournamentPoints(
              user.id,
              platformGame.id,
              pointsForTournament,
              platformUpdates.gameSpinRecord.id,
              tx
            )
          },
          {
            timeout: 8000,
          }
        )

        // Publish leaderboard updates outside the transaction
        for (const tournamentId of tournamentIdsToUpdate) {
          try {
            const leaderboard = await getTournamentLeaderboard(tournamentId, 20)
            typedAppEventEmitter.emit(AppEvents.TOURNAMENT_LEADERBOARD_UPDATED, {
              tournamentId,
              leaderboard: leaderboard.map((p: any) => ({
                userId: p.userId,
                username: p.user.username || 'Player',
                score: p.score,
                rank: p.rank,
                avatarUrl: p.user.avatar,
              })),
            })
          } catch (leaderboardError) {
            console.error(
              `❌ Error publishing leaderboard update for tournament ${tournamentId}:`,
              leaderboardError
            )
          }
        }
      } catch (error) {
        console.error('❌ Error recording tournament points:', error)
      }
    }

    perfLogger.metrics.tournamentProcessingTime = perfLogger.endTimer(tournamentStart)
    console.log(
      `✅ Tournament processing completed in ${perfLogger.metrics.tournamentProcessingTime.toFixed(2)}ms`
    )

    // Emit final events
    typedAppEventEmitter.emit(AppEvents.USER_BALANCE_UPDATED, {
      userId: user.id,
      newBalance: platformUpdates.finalPlatformWallet.balance,
      table: 'wallets',
      changeAmount: fromCentsToFloat(actualWinAmountCents - wagerAmountCents),
      transactionType: TransactionType.BET,
      relatedTransactionId: (platformUpdates.betTransaction as any).id,
    })

    typedAppEventEmitter.emit(AppEvents.GAME_SPIN_COMPLETED, {
      userId: user.id,
      gameId: platformGame.id,
      provider: providerName,
      providerGameId: rtgGameId,
      wagerAmount: wagerAmountCents,
      winAmount: actualWinAmountCents,
      currencyId,
      xpGained: platformUpdates.xpAwardedThisSpin,
      timestamp: new Date().toISOString(),
      gameSpinRecordId: platformUpdates.gameSpinRecord.id,
    })

    // Mark as successful
    success = true

    // Log performance metrics
    await perfLogger.logMetrics(user.id, platformGameId, success)

    console.log(
      `🎉 RTG Spin completed successfully in ${perfLogger.metrics.totalExecutionTime.toFixed(2)}ms`
    )

    const clientResponsePayload = {
      success: true,
      result: rgsSpinResponse as unknown as RtgSpinResult,
    }
    return c.json(clientResponsePayload)
  } catch (error: unknown) {
    const typedError = error instanceof RgsProxyError ? error : new Error(String(error))
    errorMessage = typedError.message

    // Log performance metrics even on error
    await perfLogger.logMetrics(buser.id, platformGameId, false, errorMessage)

    console.error(`❌ RTG Spin failed: ${errorMessage}`)

    return c.json({
      success: false,
      error: 'RGS_ERROR',
      message: typedError.message,
      details: typedError instanceof RgsProxyError ? typedError.providerDetails : undefined,
    })
  }
}
