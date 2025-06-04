import { Context } from 'hono'
import { User, Session } from 'better-auth/types' // Assuming these types are external or defined elsewhere
import { SQL } from 'bun' // Changed to use global sql import
import { typedAppEventEmitter, AppEvents } from '../lib/events.js' // Assuming these are project-specific
import { TransactionType, TransactionStatus } from '../../prisma/generated/index.js' // Assuming this path is correct
import type { RTGSpinRequestDto, ProviderSpinResponseData, RtgSpinResult } from 'shared' // Assuming these types are from a shared package
import { proxyRequestToRgs, RgsProxyError } from './rtg.service.js' // Assuming this is a project-specific service
import { toCents } from './transaction.service.js' // Assuming this is a project-specific service
import { cacheService, CACHE_KEYS, CACHE_TTL } from './redis-cache.service.js' // Assuming this is your cache service
const sql = new SQL(
  'postgresql://postgres.acqrudqzutnwrvmvlshc:acqrudqzutnwrvmvlshc@aws-0-us-east-2.pooler.supabase.com:5432/postgres',
  {
    // prepare: false, // Disable persisting named prepared statements on the server
  }
)

const MAX_DB_RETRIES = 2 // Max retries for "prepared statement does not exist" error
const DB_RETRY_DELAY_MS = 100 // Delay between retries

async function executeQueryWithRetry<T>(
  queryFn: () => Promise<T>,
  operationName: string = 'Database query'
): Promise<T> {
  let attempts = 0
  while (true) {
    try {
      return await queryFn()
    } catch (error: any) {
      attempts++
      // Check for the specific "prepared statement does not exist" error
      const isPreparedStmtError =
        error.name === 'PostgresError' && // Bun.sql may wrap pg errors this way
        error.message?.includes('prepared statement') &&
        error.message?.includes('does not exist')

      if (isPreparedStmtError && attempts <= MAX_DB_RETRIES) {
        console.warn(
          `[${operationName}] Postgres prepared statement error detected. Retrying (attempt ${attempts}/${MAX_DB_RETRIES})... Error: ${error.message}`
        )
        await new Promise((resolve) => setTimeout(resolve, DB_RETRY_DELAY_MS * attempts)) // Optional: increasing delay
      } else {
        // For other errors or if max retries are exceeded, re-throw the original error
        console.error(
          `[${operationName}] Failed after ${attempts} attempts. Error: ${error.message}`
        )
        throw error
      }
    }
  }
}

// Cached queries using Bun.sql + Redis
class CachedQueries {
  constructor() {
    // Bun.sql automatically uses DATABASE_URL environment variable
  }

  // User Profile Query with Redis Cache (HOTTEST QUERY #1)
  async getUserProfile(userId: string): Promise<any | null> {
    // Added return type
    const user = await cacheService.getUserProfile(userId)
    if (user) {
      return user // Already parsed by cacheService.get
    }

    // Cache miss - query database
    const [dbUser] = await executeQueryWithRetry(
      () => sql`
      SELECT 
        u.id,
        u.username,
        u.balance,
        u.operator_id AS "operatorId",
        u.role,
        v.level,
        v.current_level_xp AS "currentLevelXp",
        v.total_xp AS "totalXp",
        v.cashback_percentage AS "cashbackPercentage"
      FROM user_profiles u
      LEFT JOIN vip_infos v ON u.vip_info_id = v.id
      WHERE u.id = ${userId}
    `,
      'getUserProfile'
    )

    if (dbUser) {
      await cacheService.setUserProfile(userId, dbUser)
    }
    return dbUser
  }

  // Platform Game Query with Redis Cache
  async getPlatformGame(gameName: string): Promise<any | null> {
    // Added return type
    const game = await cacheService.getGame(gameName)
    if (game) {
      return game
    }

    const [dbGame] = await executeQueryWithRetry(
      () => sql`
      SELECT
        id,
        name,
        title,
        category,
        "gameProviderId" 
      FROM games 
      WHERE name = ${gameName}
    `,
      'getPlatformGame'
    )

    if (dbGame) {
      await cacheService.setGame(gameName, dbGame)
    }
    return dbGame
  }

  // Active Game Session Query with Redis Cache
  async getActiveSession(userId: string, gameId: string): Promise<any | null> {
    // Added return type
    const session = await cacheService.getGameSession(userId, gameId)
    if (session) {
      return session
    }

    const [dbSession] = await executeQueryWithRetry(
      () => sql`
      SELECT
        id,
        "userId",
        "gameId",
        "currencyId",
        "startingBalance",
        "totalWagered",
        "totalWon",
        "isActive"
      FROM game_sessions 
      WHERE "userId" = ${userId} AND "gameId" = ${gameId} AND "isActive" = true
      LIMIT 1
    `,
      'getActiveSession'
    )

    if (dbSession) {
      await cacheService.setGameSession(userId, gameId, dbSession)
    }
    return dbSession
  }

  // Wallet Query with Redis Cache (HOTTEST QUERY #4)
  async getOrCreateWallet(userId: string, operatorId: string): Promise<any | null> {
    // Added return type
    const wallet = await cacheService.getWallet(userId, operatorId)
    if (wallet) {
      return wallet
    }

    const [dbWallet] = await executeQueryWithRetry(
      () => sql`
      INSERT INTO wallets (
        id, 
        "userId",
        "operatorId",
        balance,
        "bonusBalance",
        "paymentMethod",
        "lockedBalance",
        "createdAt",
        "updatedAt"
      )
      VALUES (
        public.generate_cuid(), 
        ${userId},
        ${operatorId},
        0,
        0,
        'CASH_APP', 
        0,
        NOW(),
        NOW()
      )
      ON CONFLICT ("userId", "operatorId") 
      DO UPDATE SET "updatedAt" = NOW()
      RETURNING *
    `,
      'getOrCreateWallet'
    )

    if (dbWallet) {
      await cacheService.setWallet(userId, operatorId, dbWallet)
    }
    return dbWallet
  }

  // Optimized Transaction Block using Bun.sql (HOTTEST QUERY #2)
  // Note: Retry logic is NOT applied to the entire transaction block here by default,
  // as retrying complex transactions can have side effects if not idempotent.
  // Individual statements within the transaction could be wrapped if needed,
  // but "prepared statement" errors are less common for DML inside an explicit transaction block
  // compared to standalone SELECTs/INSERTs that Bun.sql might auto-prepare.
  async executeGameRoundTransaction(params: {
    userId: string
    operatorId: string
    walletId: string
    gameSessionId: string
    wagerAmountCents: number
    winAmountCents: number
    providerRoundId: string
    providerSessionId: string
    rgsRawResponse: any
    gameId: string
    providerName: string
  }) {
    const {
      userId,
      operatorId,
      walletId,
      gameSessionId,
      wagerAmountCents,
      winAmountCents,
      providerRoundId,
      providerSessionId,
      rgsRawResponse,
      gameId,
      providerName,
    } = params

    // The sql.begin block handles transaction atomicity.
    // Retrying the entire block for "prepared statement" errors is complex.
    // Such errors are more likely on the initial SELECT for currentWallet.
    const result = await sql.begin(async (tx) => {
      const [currentWallet]: { balance: number }[] = await executeQueryWithRetry(
        () => tx`
        SELECT balance FROM wallets WHERE id = ${walletId}
      `,
        'executeGameRoundTransaction.selectWallet'
      )

      if (!currentWallet) {
        throw new Error(`Wallet with id ${walletId} not found during transaction.`)
      }
      const balanceBeforeCents = Math.round(currentWallet.balance * 100)

      if (balanceBeforeCents < wagerAmountCents) {
        throw new Error('INSUFFICIENT_FUNDS')
      }

      // The subsequent INSERTs/UPDATEs within a transaction are less likely
      // to hit the "prepared statement does not exist" error for statements defined *within* the tx,
      // as the session is stable. If they call pre-existing functions that use prepared statements,
      // those functions might need their own retry logic.
      const [betTx] = await tx`
        INSERT INTO transactions (
          id,"userProfileId", "operatorId", "walletId", type, status, amount, 
          "balanceBefore", "balanceAfter", description, provider, "providerTxId",
          "relatedGameId", "relatedRoundId", "createdAt", "updatedAt"
        ) VALUES (
          public.generate_cuid(),${userId}, ${operatorId}, ${walletId}, ${TransactionType.BET}, ${TransactionStatus.COMPLETED}, 
          ${-wagerAmountCents}, ${balanceBeforeCents}, ${balanceBeforeCents - wagerAmountCents},
          ${'Bet on ' + providerName}, ${providerName}, ${'bet-' + providerRoundId},
          ${gameId}, ${providerRoundId}, NOW(), NOW()
        )
        RETURNING id
      `

      const [updatedWalletBet]: { balance: number }[] = await tx`
        UPDATE wallets 
        SET balance = balance - ${wagerAmountCents / 100}, "updatedAt" = NOW()
        WHERE id = ${walletId}
        RETURNING balance
      `
      if (!updatedWalletBet) {
        throw new Error(
          `Failed to update wallet or retrieve balance for wallet id ${walletId} after bet.`
        )
      }
      const balanceAfterBetCents = Math.round(updatedWalletBet.balance * 100)

      let winTx: { id: string } | null = null
      if (winAmountCents > 0) {
        const [winTransaction] = await tx`
          INSERT INTO transactions (
            id,"userProfileId", "operatorId", "walletId", type, status, amount, 
            "balanceBefore", "balanceAfter", description, provider, "providerTxId",
            "relatedGameId", "relatedRoundId", "createdAt", "updatedAt"
          ) VALUES (
          public.generate_cuid(),  ${userId}, ${operatorId}, ${walletId}, ${TransactionType.WIN}, ${TransactionStatus.COMPLETED}, 
            ${winAmountCents}, ${balanceAfterBetCents}, ${balanceAfterBetCents + winAmountCents},
            ${'Win on ' + providerName}, ${providerName}, ${'win-' + providerRoundId},
            ${gameId}, ${providerRoundId}, NOW(), NOW()
          )
          RETURNING id
        `
        winTx = winTransaction

        await tx`
          UPDATE wallets 
          SET balance = balance + ${winAmountCents / 100}, "updatedAt" = NOW()
          WHERE id = ${walletId}
        `
      }

      const [updatedSession] = await tx`
        UPDATE game_sessions 
        SET "totalWagered" = "totalWagered" + ${wagerAmountCents}, 
            "totalWon" = "totalWon" + ${winAmountCents}, 
            "updatedAt" = NOW()
        WHERE id = ${gameSessionId}
        RETURNING *
      `

      const [gameSpin] = await tx`
        INSERT INTO game_spins (
          id, 
          "gameSessionId",
          "wagerAmount",
          "grossWinAmount",
          "currencyId",
          "spinData",
          "timeStamp", 
          "sessionId",
          "createdAt" 
        ) VALUES (
          public.generate_cuid(), 
          ${gameSessionId},
          ${wagerAmountCents},
          ${winAmountCents},
          ${'USD'}, 
          ${JSON.stringify({ providerRoundId, rgsRawResponse })},
          NOW(), 
          ${providerSessionId},
          NOW()  
        )
        RETURNING id
      `

      const [finalWallet] = await tx`
        SELECT * FROM wallets WHERE id = ${walletId}
      `

      return {
        betTransactionId: betTx.id,
        winTransactionId: winTx?.id || null,
        gameSpinId: gameSpin.id,
        updatedGameSession: updatedSession,
        finalWallet,
        xpAwardedThisSpin: Math.floor(wagerAmountCents / 100),
      }
    })

    await cacheService.invalidateWallet(userId, operatorId)
    await cacheService.invalidateGameSession(userId, gameId)
    // await cacheService.invalidateUserProfile(userId); // Consider if user profile balance needs invalidation

    return result
  }
}

// Performance logger for cached version
class CachedPerformanceLogger {
  private startTime: number
  public metrics: any

  constructor() {
    this.startTime = Bun.nanoseconds()
    this.metrics = {
      userProfileQueryTime: 0,
      gameQueryTime: 0,
      sessionQueryTime: 0,
      walletQueryTime: 0,
      rgsCallTime: 0,
      cachedTransactionTime: 0,
      totalExecutionTime: 0,
    }
  }

  startTimer() {
    return Bun.nanoseconds()
  }

  endTimer(start: number) {
    return (Bun.nanoseconds() - start) / 1000000
  }

  async logMetrics(userId: string, gameId: string, success: boolean, error?: string) {
    this.metrics.totalExecutionTime = this.endTimer(this.startTime)
    const cacheMetrics = cacheService.getMetrics()

    const logText = `
=== CACHED RTG SPIN PERFORMANCE LOG ===
Timestamp: ${new Date().toISOString()}
User ID: ${userId}
Game ID: ${gameId}
Success: ${success}
CacheDatabase Used: ${cacheService.dbType}
${error ? `Error: ${error}` : ''}

CACHED PERFORMANCE METRICS (Bun.sql + Redis):
- Total Execution Time: ${this.metrics.totalExecutionTime.toFixed(2)}ms
- User Profile Query (Cached): ${this.metrics.userProfileQueryTime.toFixed(2)}ms
- Game Query (Cached): ${this.metrics.gameQueryTime.toFixed(2)}ms
- Session Query (Cached): ${this.metrics.sessionQueryTime.toFixed(2)}ms
- Wallet Query (Cached): ${this.metrics.walletQueryTime.toFixed(2)}ms
- RGS Call Time: ${this.metrics.rgsCallTime.toFixed(2)}ms
- Cached Transaction (Bun.sql): ${this.metrics.cachedTransactionTime.toFixed(2)}ms

CACHE PERFORMANCE (Metrics from CacheService):
- Cache Hit Rate: ${cacheMetrics.hitRate.toFixed(2)}%
- Cache Hits: ${cacheMetrics.hits}
- Cache Misses: ${cacheMetrics.misses}
- Cache Avg Response Time: ${cacheMetrics.avgResponseTime.toFixed(2)}ms
- Cache Errors: ${cacheMetrics.errors}

PERFORMANCE IMPROVEMENT vs BASELINE:
- Target: <300ms total execution time
- Previous Baseline: ~3800ms average (example value)
- Previous Optimized: ~580ms average (example value)
- Current Cached: ${this.metrics.totalExecutionTime.toFixed(2)}ms
- Improvement vs Baseline: ${(((3800 - this.metrics.totalExecutionTime) / 3800) * 100).toFixed(2)}% (example calculation)
- Improvement vs Optimized: ${(((580 - this.metrics.totalExecutionTime) / 580) * 100).toFixed(2)}% (example calculation)

CACHED PERFORMANCE BREAKDOWN:
- Database Operations (incl. transaction): ${(((this.metrics.userProfileQueryTime + this.metrics.gameQueryTime + this.metrics.sessionQueryTime + this.metrics.walletQueryTime + this.metrics.cachedTransactionTime) / this.metrics.totalExecutionTime) * 100).toFixed(2)}%
- RGS Call: ${((this.metrics.rgsCallTime / this.metrics.totalExecutionTime) * 100).toFixed(2)}%
- Cache Operations (estimated): ${Math.max(0, ((this.metrics.totalExecutionTime - this.metrics.rgsCallTime - this.metrics.cachedTransactionTime - this.metrics.userProfileQueryTime - this.metrics.gameQueryTime - this.metrics.sessionQueryTime - this.metrics.walletQueryTime) / this.metrics.totalExecutionTime) * 100).toFixed(2)}%

OPTIMIZATION TECHNIQUES APPLIED:
✅ Bun.sql native PostgreSQL driver
✅ Redis caching layer (via cacheService)
✅ Single atomic transaction block
✅ Intelligent cache invalidation
✅ Cache warming capabilities (via cacheService.warmCache)
✅ Performance metrics tracking
✅ Retry mechanism for transient \"prepared statement\" DB errors

=====================================
`

    const logFile = `performance-logs/rtg-spin-cached-${Date.now()}.txt`
    try {
      await Bun.write(logFile, logText, { createPath: true })
      console.log(`🚀 Cached performance metrics logged to: ${logFile}`)
    } catch (err) {
      console.error('❌ Failed to write cached performance log:', err)
    }
  }
}

const cachedQueries = new CachedQueries()

export async function rtgSpinCached(
  c: Context,
  buser: User,
  session: Session,
  platformGameIdInput: string
): Promise<Response> {
  const perfLogger = new CachedPerformanceLogger()
  let success = false
  let errorMessage = ''
  const userIdForLog = buser?.id || 'unknown_user'
  const gameIdForLog = platformGameIdInput || 'unknown_game'

  let userOperatorIdForWarmCache: string | undefined | null = null

  try {
    if (!buser || !buser.id) {
      errorMessage = 'UNAUTHENTICATED_MISSING_USER_ID'
      await perfLogger.logMetrics(userIdForLog, gameIdForLog, false, errorMessage)
      return c.json({ success: false, error: errorMessage }, 401)
    }

    // Attempt to get operatorId for cache warming
    const profileForWarming = await cachedQueries.getUserProfile(buser.id)
    if (profileForWarming && profileForWarming.operatorId) {
      userOperatorIdForWarmCache = profileForWarming.operatorId
    }

    // Enhanced cache warming if operatorId is available
    if (userOperatorIdForWarmCache) {
      // Preload user data and common games
      await cacheService.preloadUserData(userIdForLog, userOperatorIdForWarmCache)
      // Also warm cache for this specific game
      await cacheService.warmCache(userIdForLog, gameIdForLog, userOperatorIdForWarmCache)
    } else {
      console.warn(
        `Cache warming skipped for user ${userIdForLog}, game ${gameIdForLog}: operatorId could not be determined beforehand or is missing.`
      )
    }

    // 1. User Profile Query (Cached)
    console.log('🚀 [1/7] Starting cached user profile query...')
    const userQueryStart = perfLogger.startTimer()

    const userProfile = profileForWarming || (await cachedQueries.getUserProfile(buser.id))

    perfLogger.metrics.userProfileQueryTime = perfLogger.endTimer(userQueryStart)
    console.log(
      `✅ User profile query completed in ${perfLogger.metrics.userProfileQueryTime.toFixed(2)}ms`
    )

    if (!userProfile || !session) {
      errorMessage = 'UNAUTHENTICATED_OR_INCOMPLETE_DATA'
      await perfLogger.logMetrics(userIdForLog, gameIdForLog, false, errorMessage)
      return c.json({ success: false, error: errorMessage }, 401)
    }

    if (!userProfile.operatorId) {
      errorMessage = 'USER_PROFILE_MISSING_OPERATOR_ID'
      await perfLogger.logMetrics(userProfile.id || userIdForLog, gameIdForLog, false, errorMessage)
      return c.json({ success: false, error: errorMessage }, 400)
    }

    // 2. Platform Game Query (Cached)
    console.log('🚀 [2/7] Starting cached game query...')
    const gameQueryStart = perfLogger.startTimer()

    const platformGame = await cachedQueries.getPlatformGame(platformGameIdInput)

    perfLogger.metrics.gameQueryTime = perfLogger.endTimer(gameQueryStart)
    console.log(`✅ Game query completed in ${perfLogger.metrics.gameQueryTime.toFixed(2)}ms`)

    if (!platformGame) {
      errorMessage = 'GAME_NOT_FOUND'
      await perfLogger.logMetrics(userProfile.id, gameIdForLog, false, errorMessage)
      return c.json({ success: false, error: errorMessage }, 404)
    }

    // 3. Parse client request
    const clientSpinRequest = (await c.req.json()) as RTGSpinRequestDto
    const wagerAmountCents = toCents(parseFloat(clientSpinRequest.stake.toString()))

    // 4. Active Game Session Query (Cached)
    console.log('🚀 [3/7] Starting cached session query...')
    const sessionQueryStart = perfLogger.startTimer()

    const activeGameSession = await cachedQueries.getActiveSession(userProfile.id, platformGame.id)

    perfLogger.metrics.sessionQueryTime = perfLogger.endTimer(sessionQueryStart)
    console.log(`✅ Session query completed in ${perfLogger.metrics.sessionQueryTime.toFixed(2)}ms`)

    if (!activeGameSession) {
      errorMessage = 'NO_ACTIVE_VALID_SESSION'
      await perfLogger.logMetrics(userProfile.id, gameIdForLog, false, errorMessage)
      return c.json({ success: false, error: { code: errorMessage } }, 400)
    }

    // 5. Wallet Query (Cached)
    console.log('🚀 [4/7] Starting cached wallet query...')
    const walletQueryStart = perfLogger.startTimer()

    const wallet = await cachedQueries.getOrCreateWallet(userProfile.id, userProfile.operatorId)

    perfLogger.metrics.walletQueryTime = perfLogger.endTimer(walletQueryStart)
    console.log(`✅ Wallet query completed in ${perfLogger.metrics.walletQueryTime.toFixed(2)}ms`)

    if (!wallet) {
      errorMessage = 'WALLET_OPERATION_FAILED'
      await perfLogger.logMetrics(userProfile.id, gameIdForLog, false, errorMessage)
      return c.json({ success: false, error: errorMessage }, 500)
    }

    // 6. RGS Call
    console.log('🚀 [5/7] Starting RGS call...')
    const rgsCallStart = perfLogger.startTimer()

    let rgsSpinResponse: ProviderSpinResponseData
    const DEVMODE = clientSpinRequest.playMode === 'test'

    if (!DEVMODE) {
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

    const actualWinAmountCents = toCents(parseFloat(rgsSpinResponse.game.win.total.toString()))
    const providerRoundIdFromRgs =
      rgsSpinResponse.transactions.roundId?.toString() || `spin-${Date.now()}`

    // 7. Cached Transaction Block (Bun.sql with cache invalidation)
    console.log('🚀 [6/7] Starting cached transaction...')
    const transactionStart = perfLogger.startTimer()

    const transactionResult = await cachedQueries.executeGameRoundTransaction({
      userId: userProfile.id,
      operatorId: userProfile.operatorId,
      walletId: wallet.id,
      gameSessionId: activeGameSession.id,
      wagerAmountCents,
      winAmountCents: actualWinAmountCents,
      providerRoundId: providerRoundIdFromRgs,
      providerSessionId: clientSpinRequest.sessionId,
      rgsRawResponse: rgsSpinResponse,
      gameId: platformGame.id,
      providerName: 'RTG',
    })

    perfLogger.metrics.cachedTransactionTime = perfLogger.endTimer(transactionStart)
    console.log(
      `✅ Cached transaction completed in ${perfLogger.metrics.cachedTransactionTime.toFixed(2)}ms`
    )

    // Emit events
    typedAppEventEmitter.emit(AppEvents.USER_BALANCE_UPDATED, {
      userId: userProfile.id,
      newBalance: transactionResult.finalWallet.balance,
      table: 'wallets',
      changeAmount: (actualWinAmountCents - wagerAmountCents) / 100,
      transactionType: TransactionType.BET,
      relatedTransactionId: transactionResult.betTransactionId,
    })

    success = true
    await perfLogger.logMetrics(userProfile.id, gameIdForLog, success)

    console.log(
      `🎉 Cached RTG Spin completed in ${perfLogger.metrics.totalExecutionTime.toFixed(2)}ms`
    )

    // 8. Return response (Step 7/7 in terms of major operations)
    return c.json({
      success: true,
      result: rgsSpinResponse as unknown as RtgSpinResult,
    })
  } catch (error: unknown) {
    const typedError = error instanceof RgsProxyError ? error : new Error(String(error))
    errorMessage = typedError.message

    await perfLogger.logMetrics(userIdForLog, gameIdForLog, false, errorMessage)
    console.error(`❌ Cached RTG Spin failed: ${errorMessage}`)

    return c.json({
      success: false,
      error: 'RGS_ERROR',
      message: typedError.message,
      details: typedError instanceof RgsProxyError ? typedError.providerDetails : undefined,
    })
  }
}

// import { Context } from 'hono'
// import { User, Session } from 'better-auth/types'
// import { SQL } from 'bun'
// import { typedAppEventEmitter, AppEvents } from '../lib/events.js'
// import { TransactionType, TransactionStatus } from '../../prisma/generated/index.js'
// import type { RTGSpinRequestDto, ProviderSpinResponseData, RtgSpinResult } from 'shared'
// import { proxyRequestToRgs, RgsProxyError } from './rtg.service.js'
// import { toCents } from './transaction.service.js'
// import { cacheService } from './redis-cache.service.js'

// // Cached queries using Bun.sql + Redis
// class CachedQueries {
//   private sql: SQL

//   constructor() {
//     // Initialize Bun SQL with connection string
//     const connectionString = process.env.DATABASE_URL!
//     this.sql = new SQL(connectionString)
//   }

//   // User Profile Query with Redis Cache (HOTTEST QUERY #1)
//   async getUserProfile(userId: string) {
//     // Try cache first
//     const cached = await cacheService.getUserProfile(userId)
//     if (cached) {
//       return cached
//     }

//     // Cache miss - query database
//     const [user] = await this.sql`
//       SELECT
//         u.id, u.username, u.balance, u."operatorId", u.role,
//         v.level, v."currentLevelXp", v."totalXp", v."cashbackPercentage"
//       FROM user_profiles u
//       LEFT JOIN vip_infos v ON u."vipInfoId" = v.id
//       WHERE u.id = ${userId}
//     `

//     if (user) {
//       // Cache the result
//       await cacheService.setUserProfile(userId, user)
//     }

//     return user
//   }

//   // Platform Game Query with Redis Cache
//   async getPlatformGame(gameName: string) {
//     // Try cache first
//     const cached = await cacheService.getGame(gameName)
//     if (cached) {
//       return cached
//     }

//     // Cache miss - query database
//     const [game] = await this.sql`
//       SELECT id, name, title, category, "gameProviderId"
//       FROM games
//       WHERE name = ${gameName}
//     `

//     if (game) {
//       // Cache the result
//       await cacheService.setGame(gameName, game)
//     }

//     return game
//   }

//   // Active Game Session Query with Redis Cache
//   async getActiveSession(userId: string, gameId: string) {
//     // Try cache first
//     const cached = await cacheService.getGameSession(userId, gameId)
//     if (cached) {
//       return cached
//     }

//     // Cache miss - query database
//     const [session] = await this.sql`
//       SELECT id, "userId", "gameId", "currencyId", "startingBalance", "totalWagered", "totalWon", "isActive"
//       FROM game_sessions
//       WHERE "userId" = ${userId} AND "gameId" = ${gameId} AND "isActive" = true
//       LIMIT 1
//     `

//     if (session) {
//       // Cache the result (short TTL since sessions change frequently)
//       await cacheService.setGameSession(userId, gameId, session)
//     }

//     return session
//   }

//   // Wallet Query with Redis Cache (HOTTEST QUERY #4)
//   async getOrCreateWallet(userId: string, operatorId: string) {
//     // Try cache first
//     const cached = await cacheService.getWallet(userId, operatorId)
//     if (cached) {
//       return cached
//     }

//     // Cache miss - query/create in database
//     const [wallet] = await this.sql`
//       INSERT INTO wallets ("userId", "operatorId", balance, "bonusBalance", "paymentMethod", "lockedBalance")
//       VALUES (${userId}, ${operatorId}, 0, 0, 'CASH_APP', 0)
//       ON CONFLICT ("userId", "operatorId")
//       DO UPDATE SET "updatedAt" = NOW()
//       RETURNING *
//     `

//     if (wallet) {
//       // Cache the result (short TTL since balance changes frequently)
//       await cacheService.setWallet(userId, operatorId, wallet)
//     }

//     return wallet
//   }

//   // Optimized Transaction Block using Bun.sql (HOTTEST QUERY #2)
//   // Note: This is not cached as it's a write operation that changes state
//   async executeGameRoundTransaction(params: {
//     userId: string
//     operatorId: string
//     walletId: string
//     gameSessionId: string
//     wagerAmountCents: number
//     winAmountCents: number
//     providerRoundId: string
//     providerSessionId: string
//     rgsRawResponse: any
//     gameId: string
//     providerName: string
//   }) {
//     const {
//       userId,
//       operatorId,
//       walletId,
//       gameSessionId,
//       wagerAmountCents,
//       winAmountCents,
//       providerRoundId,
//       providerSessionId,
//       rgsRawResponse,
//       gameId,
//       providerName,
//     } = params

//     // Execute all operations in a single transaction using Bun.sql
//     const result = await this.sql.begin(async (tx) => {
//       // 1. Get current wallet balance and check funds
//       const [currentWallet] = await tx`
//         SELECT balance FROM wallets WHERE id = ${walletId}
//       `
//       const balanceBeforeCents = Math.round(currentWallet.balance * 100)

//       if (balanceBeforeCents < wagerAmountCents) {
//         throw new Error('INSUFFICIENT_FUNDS')
//       }

//       // 2. Create bet transaction
//       const [betTx] = await tx`
//         INSERT INTO transactions (
//           "userProfileId", "operatorId", "walletId", type, status, amount,
//           "balanceBefore", "balanceAfter", description, provider, "providerTxId",
//           "relatedGameId", "relatedRoundId", "createdAt"
//         ) VALUES (
//           ${userId}, ${operatorId}, ${walletId}, ${TransactionType.BET}, ${TransactionStatus.COMPLETED},
//           ${-wagerAmountCents}, ${balanceBeforeCents}, ${balanceBeforeCents - wagerAmountCents},
//           ${'Bet on ' + providerName}, ${providerName}, ${'bet-' + providerRoundId},
//           ${gameId}, ${providerRoundId}, NOW()
//         )
//         RETURNING id
//       `

//       // 3. Update wallet balance (deduct bet) - atomic operation
//       const [updatedWallet] = await tx`
//         UPDATE wallets
//         SET balance = balance - ${wagerAmountCents / 100}, "updatedAt" = NOW()
//         WHERE id = ${walletId}
//         RETURNING balance
//       `

//       // 4. Create win transaction if there's a win
//       let winTx: { id: string } | null = null
//       if (winAmountCents > 0) {
//         const [winTransaction] = await tx`
//           INSERT INTO transactions (
//             "userProfileId", "operatorId", "walletId", type, status, amount,
//             "balanceBefore", "balanceAfter", description, provider, "providerTxId",
//             "relatedGameId", "relatedRoundId", "createdAt"
//           ) VALUES (
//             ${userId}, ${operatorId}, ${walletId}, ${TransactionType.WIN}, ${TransactionStatus.COMPLETED},
//             ${winAmountCents}, ${Math.round(updatedWallet.balance * 100)}, ${Math.round(updatedWallet.balance * 100) + winAmountCents},
//             ${'Win on ' + providerName}, ${providerName}, ${'win-' + providerRoundId},
//             ${gameId}, ${providerRoundId}, NOW()
//           )
//           RETURNING id
//         `
//         winTx = winTransaction

//         // Update wallet with winnings - atomic operation
//         await tx`
//           UPDATE wallets
//           SET balance = balance + ${winAmountCents / 100}, "updatedAt" = NOW()
//           WHERE id = ${walletId}
//         `
//       }

//       // 5. Update game session - atomic operation
//       const [updatedSession] = await tx`
//         UPDATE game_sessions
//         SET "totalWagered" = "totalWagered" + ${wagerAmountCents},
//             "totalWon" = "totalWon" + ${winAmountCents},
//             "updatedAt" = NOW()
//         WHERE id = ${gameSessionId}
//         RETURNING *
//       `

//       // 6. Create game spin record
//       const [gameSpin] = await tx`
//         INSERT INTO game_spins (
//           "gameSessionId", "wagerAmount", "grossWinAmount", "currencyId",
//           "spinData", "timeStamp", "sessionId"
//         ) VALUES (
//           ${gameSessionId}, ${wagerAmountCents}, ${winAmountCents}, ${'USD'},
//           ${JSON.stringify({ providerRoundId, rgsRawResponse })}, NOW(), ${providerSessionId}
//         )
//         RETURNING id
//       `

//       // 7. Get final wallet state
//       const [finalWallet] = await tx`
//         SELECT * FROM wallets WHERE id = ${walletId}
//       `

//       return {
//         betTransactionId: betTx.id,
//         winTransactionId: winTx?.id || null,
//         gameSpinId: gameSpin.id,
//         updatedGameSession: updatedSession,
//         finalWallet,
//         xpAwardedThisSpin: Math.floor(wagerAmountCents / 100),
//       }
//     })

//     // Invalidate wallet cache after transaction
//     await cacheService.invalidateWallet(userId, operatorId)

//     // Invalidate game session cache after update
//     await cacheService.invalidateGameSession(userId, gameId)

//     return result
//   }
// }

// // Performance logger for cached version
// class CachedPerformanceLogger {
//   private startTime: number
//   public metrics: any

//   constructor() {
//     this.startTime = Bun.nanoseconds()
//     this.metrics = {
//       userProfileQueryTime: 0,
//       gameQueryTime: 0,
//       sessionQueryTime: 0,
//       walletQueryTime: 0,
//       rgsCallTime: 0,
//       cachedTransactionTime: 0,
//       totalExecutionTime: 0,
//       cacheHits: 0,
//       cacheMisses: 0,
//     }
//   }

//   startTimer() {
//     return Bun.nanoseconds()
//   }

//   endTimer(start: number) {
//     return (Bun.nanoseconds() - start) / 1000000
//   }

//   async logMetrics(userId: string, gameId: string, success: boolean, error?: string) {
//     this.metrics.totalExecutionTime = this.endTimer(this.startTime)

//     // Get cache metrics
//     const cacheMetrics = cacheService.getMetrics()

//     const logText = `
// === CACHED RTG SPIN PERFORMANCE LOG ===
// Timestamp: ${new Date().toISOString()}
// User ID: ${userId}
// Game ID: ${gameId}
// Success: ${success}
// ${error ? `Error: ${error}` : ''}

// CACHED PERFORMANCE METRICS (Bun.sql + Redis):
// - Total Execution Time: ${this.metrics.totalExecutionTime.toFixed(2)}ms
// - User Profile Query (Cached): ${this.metrics.userProfileQueryTime.toFixed(2)}ms
// - Game Query (Cached): ${this.metrics.gameQueryTime.toFixed(2)}ms
// - Session Query (Cached): ${this.metrics.sessionQueryTime.toFixed(2)}ms
// - Wallet Query (Cached): ${this.metrics.walletQueryTime.toFixed(2)}ms
// - RGS Call Time: ${this.metrics.rgsCallTime.toFixed(2)}ms
// - Cached Transaction (Bun.sql): ${this.metrics.cachedTransactionTime.toFixed(2)}ms

// CACHE PERFORMANCE:
// - Cache Hit Rate: ${cacheMetrics.hitRate.toFixed(2)}%
// - Cache Hits: ${cacheMetrics.hits}
// - Cache Misses: ${cacheMetrics.misses}
// - Cache Avg Response Time: ${cacheMetrics.avgResponseTime.toFixed(2)}ms
// - Cache Errors: ${cacheMetrics.errors}

// PERFORMANCE IMPROVEMENT vs BASELINE:
// - Target: <300ms total execution time
// - Previous Baseline: ~3800ms average
// - Previous Optimized: ~580ms average
// - Current Cached: ${this.metrics.totalExecutionTime.toFixed(2)}ms
// - Improvement vs Baseline: ${(((3800 - this.metrics.totalExecutionTime) / 3800) * 100).toFixed(2)}%
// - Improvement vs Optimized: ${(((580 - this.metrics.totalExecutionTime) / 580) * 100).toFixed(2)}%

// CACHED PERFORMANCE BREAKDOWN:
// - Database Operations: ${(((this.metrics.userProfileQueryTime + this.metrics.gameQueryTime + this.metrics.sessionQueryTime + this.metrics.walletQueryTime + this.metrics.cachedTransactionTime) / this.metrics.totalExecutionTime) * 100).toFixed(2)}%
// - RGS Call: ${((this.metrics.rgsCallTime / this.metrics.totalExecutionTime) * 100).toFixed(2)}%
// - Cache Operations: ${(((this.metrics.totalExecutionTime - this.metrics.rgsCallTime - this.metrics.cachedTransactionTime) / this.metrics.totalExecutionTime) * 100).toFixed(2)}%

// OPTIMIZATION TECHNIQUES APPLIED:
// ✅ Bun.sql native PostgreSQL driver
// ✅ Redis caching layer with Bun native client
// ✅ Single atomic transaction block
// ✅ Intelligent cache invalidation
// ✅ Cache warming capabilities
// ✅ Performance metrics tracking

// =====================================
// `

//     const logFile = `performance-logs/rtg-spin-cached-${Date.now()}.txt`
//     try {
//       await Bun.write(logFile, logText, { createPath: true })
//       console.log(`🚀 Cached performance metrics logged to: ${logFile}`)
//     } catch (err) {
//       console.error('❌ Failed to write cached performance log:', err)
//     }
//   }
// }

// const cachedQueries = new CachedQueries()

// export async function rtgSpinCached(
//   c: Context,
//   buser: User,
//   session: Session,
//   platformGameId: string
// ): Promise<Response> {
//   const perfLogger = new CachedPerformanceLogger()
//   let success = false
//   let errorMessage = ''

//   try {
//     // Warm cache for this user/game combination
//     await cacheService.warmCache(buser.id, platformGameId, 'default')

//     // 1. User Profile Query (Cached)
//     console.log('🚀 [1/6] Starting cached user profile query...')
//     const userQueryStart = perfLogger.startTimer()

//     const user = await cachedQueries.getUserProfile(buser.id)

//     perfLogger.metrics.userProfileQueryTime = perfLogger.endTimer(userQueryStart)
//     console.log(
//       `✅ User profile query completed in ${perfLogger.metrics.userProfileQueryTime.toFixed(2)}ms`
//     )

//     if (!user || !session) {
//       errorMessage = 'UNAUTHENTICATED_OR_INCOMPLETE_DATA'
//       await perfLogger.logMetrics(buser.id, platformGameId, false, errorMessage)
//       return c.json({ success: false, error: errorMessage }, 401)
//     }

//     // 2. Platform Game Query (Cached)
//     console.log('🚀 [2/6] Starting cached game query...')
//     const gameQueryStart = perfLogger.startTimer()

//     const platformGame = await cachedQueries.getPlatformGame(platformGameId + 'RTG')

//     perfLogger.metrics.gameQueryTime = perfLogger.endTimer(gameQueryStart)
//     console.log(`✅ Game query completed in ${perfLogger.metrics.gameQueryTime.toFixed(2)}ms`)

//     if (!platformGame) {
//       errorMessage = 'GAME_NOT_FOUND'
//       await perfLogger.logMetrics(user.id, platformGameId, false, errorMessage)
//       return c.json({ success: false, error: errorMessage }, 404)
//     }

//     // 3. Parse client request
//     const clientSpinRequest = (await c.req.json()) as RTGSpinRequestDto
//     const wagerAmountCents = toCents(parseFloat(clientSpinRequest.stake.toString()))

//     // 4. Active Game Session Query (Cached)
//     console.log('🚀 [3/6] Starting cached session query...')
//     const sessionQueryStart = perfLogger.startTimer()

//     const activeGameSession = await cachedQueries.getActiveSession(user.id, platformGame.id)

//     perfLogger.metrics.sessionQueryTime = perfLogger.endTimer(sessionQueryStart)
//     console.log(`✅ Session query completed in ${perfLogger.metrics.sessionQueryTime.toFixed(2)}ms`)

//     if (!activeGameSession) {
//       errorMessage = 'NO_ACTIVE_VALID_SESSION'
//       await perfLogger.logMetrics(user.id, platformGameId, false, errorMessage)
//       return c.json({ success: false, error: { code: errorMessage } }, 400)
//     }

//     // 5. Wallet Query (Cached)
//     console.log('🚀 [4/6] Starting cached wallet query...')
//     const walletQueryStart = perfLogger.startTimer()

//     const wallet = await cachedQueries.getOrCreateWallet(user.id, user.operatorId)

//     perfLogger.metrics.walletQueryTime = perfLogger.endTimer(walletQueryStart)
//     console.log(`✅ Wallet query completed in ${perfLogger.metrics.walletQueryTime.toFixed(2)}ms`)

//     // 6. RGS Call
//     console.log('🚀 [5/6] Starting RGS call...')
//     const rgsCallStart = perfLogger.startTimer()

//     let rgsSpinResponse: ProviderSpinResponseData
//     const DEVMODE = clientSpinRequest.playMode === 'test'

//     if (!DEVMODE) {
//       const rgsResponse = await proxyRequestToRgs<
//         typeof clientSpinRequest,
//         ProviderSpinResponseData
//       >('spin', 'POST', clientSpinRequest, session.token)
//       rgsSpinResponse = (rgsResponse as any).result as ProviderSpinResponseData
//     } else {
//       const importedData = (await import('./json/rtg-spin-lose.result.json')) as any
//       rgsSpinResponse = importedData.default[0].result as ProviderSpinResponseData
//     }

//     perfLogger.metrics.rgsCallTime = perfLogger.endTimer(rgsCallStart)
//     console.log(`✅ RGS call completed in ${perfLogger.metrics.rgsCallTime.toFixed(2)}ms`)

//     const actualWinAmountCents = toCents(parseFloat(rgsSpinResponse.game.win.total.toString()))
//     const providerRoundIdFromRgs =
//       rgsSpinResponse.transactions.roundId?.toString() || `spin-${Date.now()}`

//     // 7. Cached Transaction Block (Bun.sql with cache invalidation)
//     console.log('🚀 [6/6] Starting cached transaction...')
//     const transactionStart = perfLogger.startTimer()

//     const transactionResult = await cachedQueries.executeGameRoundTransaction({
//       userId: user.id,
//       operatorId: user.operatorId,
//       walletId: wallet.id,
//       gameSessionId: activeGameSession.id,
//       wagerAmountCents,
//       winAmountCents: actualWinAmountCents,
//       providerRoundId: providerRoundIdFromRgs,
//       providerSessionId: clientSpinRequest.sessionId,
//       rgsRawResponse: rgsSpinResponse,
//       gameId: platformGame.id,
//       providerName: 'RTG',
//     })

//     perfLogger.metrics.cachedTransactionTime = perfLogger.endTimer(transactionStart)
//     console.log(
//       `✅ Cached transaction completed in ${perfLogger.metrics.cachedTransactionTime.toFixed(2)}ms`
//     )

//     // Emit events
//     typedAppEventEmitter.emit(AppEvents.USER_BALANCE_UPDATED, {
//       userId: user.id,
//       newBalance: transactionResult.finalWallet.balance,
//       table: 'wallets',
//       changeAmount: (actualWinAmountCents - wagerAmountCents) / 100,
//       transactionType: TransactionType.BET,
//       relatedTransactionId: transactionResult.betTransactionId,
//     })

//     success = true
//     await perfLogger.logMetrics(user.id, platformGameId, success)

//     console.log(
//       `🎉 Cached RTG Spin completed in ${perfLogger.metrics.totalExecutionTime.toFixed(2)}ms`
//     )

//     return c.json({
//       success: true,
//       result: rgsSpinResponse as unknown as RtgSpinResult,
//     })
//   } catch (error: unknown) {
//     const typedError = error instanceof RgsProxyError ? error : new Error(String(error))
//     errorMessage = typedError.message

//     await perfLogger.logMetrics(buser.id, platformGameId, false, errorMessage)
//     console.error(`❌ Cached RTG Spin failed: ${errorMessage}`)

//     return c.json({
//       success: false,
//       error: 'RGS_ERROR',
//       message: typedError.message,
//       details: typedError instanceof RgsProxyError ? typedError.providerDetails : undefined,
//     })
//   }
// }
