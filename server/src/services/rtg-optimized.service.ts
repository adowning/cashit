import { Context } from 'hono'
import { User, Session } from 'better-auth/types' // Assuming these types are external or defined elsewhere
import { SQL } from 'bun'
import { typedAppEventEmitter, AppEvents } from '../lib/events.js' // Assuming these are project-specific
import { TransactionType, TransactionStatus } from '../../prisma/generated/index.js' // Assuming this path is correct
import type { RTGSpinRequestDto, ProviderSpinResponseData, RtgSpinResult } from 'shared' // Assuming these types are from a shared package
import { proxyRequestToRgs, RgsProxyError } from './rtg.service.js' // Assuming this is a project-specific service
import { toCents } from './transaction.service.js' // Assuming this is a project-specific service
const sql = new SQL(
  // 'postgresql://postgres.acqrudqzutnwrvmvlshc:acqrudqzutnwrvmvlshc@aws-0-us-east-2.pooler.supabase.com:5432/postgres',
  'postgresql://postgres:password@192.168.1.35:5439/mydatabase',
  {
    // prepare: false, // Disable persisting named prepared statements on the server
  }
)

// Optimized queries using Bun's native SQL support
class OptimizedQueries {
  constructor() {
    // Bun.sql automatically uses DATABASE_URL environment variable
  }

  // User Profile Query with VIP Info (HOTTEST QUERY #1)
  // UserProfile maps to "user_profiles"
  // VipInfo maps to "vip_infos"
  async getUserProfile(userId: string) {
    const [user] = await sql`
      SELECT
        u.id,
        u.username,
        u.balance,
        u.operator_id AS "operatorId", -- Mapped from operatorId
        u.role,
        v.level,
        v.current_level_xp AS "currentLevelXp", -- Mapped from currentLevelXp
        v.total_xp AS "totalXp", -- Mapped from totalXp
        v.cashback_percentage AS "cashbackPercentage" -- Mapped from cashbackPercentage
      FROM user_profiles u
      LEFT JOIN vip_infos v ON u.vip_info_id = v.id -- vip_info_id is the mapped FK
      WHERE u.id = ${userId}
    `
    return user
  }

  // Platform Game Query
  // Game maps to "games"
  async getPlatformGame(gameName: string) {
    const [game] = await sql`
      SELECT
        id,
        name,
        title,
        category,
        "gameProviderId" -- This seems to be the direct column name (no @map in schema for this field name)
      FROM games
      WHERE name = ${gameName + 'RTG'}
    `
    return game
  }

  // Active Game Session Query
  // GameSession maps to "game_sessions"
  async getActiveSession(userId: string, gameId: string) {
    const [session] = await sql`
      SELECT
        id,
        "userId", -- This seems to be the direct column name
        "gameId", -- This seems to be the direct column name
        "currencyId", -- This seems to be the direct column name
        "startingBalance", -- This seems to be the direct column name
        "totalWagered", -- This seems to be the direct column name
        "totalWon", -- This seems to be the direct column name
        "isActive" -- This seems to be the direct column name
      FROM game_sessions
      WHERE "userId" = ${userId} AND "gameId" = ${gameId} AND "isActive" = true
      LIMIT 1
    `
    return session
  }

  // Wallet Query with UPSERT (HOTTEST QUERY #4)
  // Wallet maps to "wallets"
  async getOrCreateWallet(userId: string, operatorId: string) {
    // Note: "paymentMethod" in wallets table is NOT NULL.
    // The original query uses 'CASH_APP'. Ensure this is a valid enum value.
    // Explicitly provide 'id' using a database function like public.generate_cuid()
    const [wallet] = await sql`
      INSERT INTO wallets (
        id, -- Added id column
        "userId", -- Direct column name
        "operatorId", -- Direct column name
        balance,
        "bonusBalance", -- Direct column name
        "paymentMethod", -- Direct column name
        "lockedBalance", -- Direct column name
        "createdAt",
        "updatedAt"
      )
      VALUES (
        public.generate_cuid(), -- Call PostgreSQL function to generate CUID
        ${userId},
        ${operatorId},
        0, 0, 'CASH_APP', 0, NOW(), NOW()
      )
      ON CONFLICT ("userId", "operatorId") -- Assuming this unique constraint exists as per schema @@unique([userId, operatorId])
      DO UPDATE SET "updatedAt" = NOW()
      RETURNING *
    `
    return wallet
  }

  // Optimized Transaction Block using Bun.sql (HOTTEST QUERY #2)
  // Transaction maps to "transactions"
  // Wallet maps to "wallets"
  // GameSession maps to "game_sessions"
  // GameSpin maps to "game_spins"
  async executeGameRoundTransaction(params: {
    userId: string // This will be UserProfile.id
    operatorId: string
    walletId: string
    gameSessionId: string
    wagerAmountCents: number
    winAmountCents: number
    providerRoundId: string
    providerSessionId: string // Used in game_spins.session_id
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

    return await sql.begin(async (tx) => {
      // 1. Get current wallet balance and check funds
      const [currentWallet]: { balance: number }[] = await tx`
        SELECT balance FROM wallets WHERE id = ${walletId}
      `
      // Wallets.balance is Float, so direct multiplication is fine.
      const balanceBeforeCents = Math.round(currentWallet!.balance * 100)

      if (balanceBeforeCents < wagerAmountCents) {
        throw new Error('INSUFFICIENT_FUNDS')
      }

      // 2. Create bet transaction
      // Transactions table:
      // userProfileId -> "userProfileId" (direct)
      // operatorId -> "operatorId" (direct)
      // walletId -> "walletId" (direct)
      // balanceBefore, balanceAfter are Int?
      // createdAt -> "createdAt" (direct)
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

      // 3. Update wallet balance (deduct bet) - atomic operation
      const [updatedWallet]: { balance: number }[] = await tx`
        UPDATE wallets
        SET balance = balance - ${wagerAmountCents / 100}, "updatedAt" = NOW()
        WHERE id = ${walletId}
        RETURNING balance
      `
      const balanceAfterBetCents = Math.round(updatedWallet!.balance * 100)

      // 4. Create win transaction if there's a win
      let winTx: { id: string } | null = null
      if (winAmountCents > 0) {
        const [winTransaction] = await tx`
          INSERT INTO transactions (
            id,"userProfileId", "operatorId", "walletId", type, status, amount,
            "balanceBefore", "balanceAfter", description, provider, "providerTxId",
            "relatedGameId", "relatedRoundId", "createdAt", "updatedAt"
          ) VALUES (
            public.generate_cuid(), ${userId}, ${operatorId}, ${walletId}, ${TransactionType.WIN}, ${TransactionStatus.COMPLETED},
            ${winAmountCents}, ${balanceAfterBetCents}, ${balanceAfterBetCents + winAmountCents},
            ${'Win on ' + providerName}, ${providerName}, ${'win-' + providerRoundId},
            ${gameId}, ${providerRoundId}, NOW(), NOW()
          )
          RETURNING id
        `
        winTx = winTransaction

        // Update wallet with winnings - atomic operation
        await tx`
          UPDATE wallets
          SET balance = balance + ${winAmountCents / 100}, "updatedAt" = NOW()
          WHERE id = ${walletId}
        `
      }

      // 5. Update game session - atomic operation
      // game_sessions table:
      // totalWagered -> "totalWagered" (direct)
      // totalWon -> "totalWon" (direct)
      // updatedAt -> "updatedAt" (direct)
      const [updatedSession] = await tx`
        UPDATE game_sessions
        SET "totalWagered" = "totalWagered" + ${wagerAmountCents},
            "totalWon" = "totalWon" + ${winAmountCents},
            "updatedAt" = NOW()
        WHERE id = ${gameSessionId}
        RETURNING *
      `

      // 6. Create game spin record
      // game_spins table:
      // gameSessionId -> "gameSessionId" (direct)
      // wagerAmount -> "wagerAmount" (direct)
      // grossWinAmount -> "grossWinAmount" (direct)
      // currencyId -> "currencyId" (direct)
      // spinData -> "spinData" (direct)
      // timeStamp -> "timeStamp" (direct)
      // sessionId -> "sessionId" (direct)
      // createdAt -> "createdAt" (direct)
      const [gameSpin] = await tx`
        INSERT INTO game_spins (
          id, "gameSessionId", "wagerAmount", "grossWinAmount", "currencyId",
          "spinData", "timeStamp", "sessionId", "createdAt"
        ) VALUES (
          public.generate_cuid(), ${gameSessionId}, ${wagerAmountCents}, ${winAmountCents}, ${'USD'}, -- Assuming USD, adjust if dynamic
          ${JSON.stringify({ providerRoundId, rgsRawResponse })}, NOW(), ${providerSessionId}, NOW()
        )
        RETURNING id
      `

      // 7. Get final wallet state
      const [finalWallet] = await tx`
        SELECT * FROM wallets WHERE id = ${walletId}
      `

      return {
        betTransactionId: betTx.id,
        winTransactionId: winTx?.id,
        finalWallet,
        updatedSession,
        gameSpinId: gameSpin.id,
        xpAwardedThisSpin: Math.floor(wagerAmountCents / 100), // Assuming 1 cent = 1 XP for this logic
      }
    })
  }
}

// Performance logger for optimized version
class OptimizedPerformanceLogger {
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
      optimizedTransactionTime: 0,
      totalExecutionTime: 0,
    }
  }

  startTimer() {
    return Bun.nanoseconds()
  }

  endTimer(start: number) {
    return (Bun.nanoseconds() - start) / 1000000 // Convert nanoseconds to milliseconds
  }

  async logMetrics(userId: string, gameId: string, success: boolean, error?: string) {
    this.metrics.totalExecutionTime = this.endTimer(this.startTime)

    const logText = `
=== OPTIMIZED RTG SPIN PERFORMANCE LOG ===
Timestamp: ${new Date().toISOString()}
User ID: ${userId}
Game ID: ${gameId}
Success: ${success}
${error ? `Error: ${error}` : ''}

OPTIMIZED PERFORMANCE METRICS (Bun.sql):
- Total Execution Time: ${this.metrics.totalExecutionTime.toFixed(2)}ms
- User Profile Query (Bun.sql): ${this.metrics.userProfileQueryTime.toFixed(2)}ms
- Game Query (Bun.sql): ${this.metrics.gameQueryTime.toFixed(2)}ms
- Session Query (Bun.sql): ${this.metrics.sessionQueryTime.toFixed(2)}ms
- Wallet Query (Bun.sql): ${this.metrics.walletQueryTime.toFixed(2)}ms
- RGS Call Time: ${this.metrics.rgsCallTime.toFixed(2)}ms
- Optimized Transaction (Bun.sql): ${this.metrics.optimizedTransactionTime.toFixed(2)}ms

PERFORMANCE IMPROVEMENT vs BASELINE:
- Target: <500ms total execution time
- Previous Baseline: ~3800ms average (example value)
- Current Optimized: ${this.metrics.totalExecutionTime.toFixed(2)}ms
- Improvement: ${(((3800 - this.metrics.totalExecutionTime) / 3800) * 100).toFixed(2)}% (example calculation)

BUN.SQL PERFORMANCE BREAKDOWN:
- Database Operations: ${(((this.metrics.userProfileQueryTime + this.metrics.gameQueryTime + this.metrics.sessionQueryTime + this.metrics.walletQueryTime + this.metrics.optimizedTransactionTime) / this.metrics.totalExecutionTime) * 100).toFixed(2)}%
- RGS Call: ${((this.metrics.rgsCallTime / this.metrics.totalExecutionTime) * 100).toFixed(2)}%

OPTIMIZATION TECHNIQUES APPLIED:
✅ Bun.sql native PostgreSQL driver
✅ Single atomic transaction block
✅ Prepared statements (automatic with tagged template literals)
✅ Connection pooling (automatic by Bun.sql)
✅ Reduced object creation overhead
✅ Direct wire protocol communication (handled by Bun.sql)

=====================================
`

    const logFile = `performance-logs/rtg-spin-optimized-${Date.now()}.txt`
    try {
      await Bun.write(logFile, logText, { createPath: true })
      console.log(`🚀 Optimized performance metrics logged to: ${logFile}`)
    } catch (err) {
      console.error('❌ Failed to write optimized performance log:', err)
    }
  }
}

const optimizedQueries = new OptimizedQueries()

export async function rtgSpinOptimized(
  c: Context,
  buser: User, // Assuming User type has at least 'id'
  session: Session, // Assuming Session type has at least 'token'
  platformGameIdInput: string // Renamed to avoid conflict with platformGame variable
): Promise<Response> {
  const perfLogger = new OptimizedPerformanceLogger()
  let success = false
  let errorMessage = ''
  const userIdForLog = buser?.id || 'unknown_user'
  const gameIdForLog = platformGameIdInput || 'unknown_game'

  try {
    // 1. User Profile Query (Optimized with Bun.sql)
    const userQueryStart = perfLogger.startTimer()
    if (!platformGameIdInput) {
      errorMessage = 'platformGameIdInput is missing'
      await perfLogger.logMetrics(userIdForLog, gameIdForLog, false, errorMessage)
      return c.json({ success: false, error: errorMessage }, 500)
    }
    // Ensure buser and buser.id are valid before querying
    if (!buser || !buser.id) {
      errorMessage = 'UNAUTHENTICATED_MISSING_USER_ID'
      await perfLogger.logMetrics(userIdForLog, gameIdForLog, false, errorMessage)
      return c.json({ success: false, error: errorMessage }, 401)
    }
    console.log('🚀 [1/7] Starting optimized user profile query...')

    const userProfile = await optimizedQueries.getUserProfile(buser.id) // userProfile from DB

    perfLogger.metrics.userProfileQueryTime = perfLogger.endTimer(userQueryStart)
    console.log(
      `✅ User profile query completed in ${perfLogger.metrics.userProfileQueryTime.toFixed(2)}ms`
    )

    if (!userProfile || !session) {
      errorMessage = 'UNAUTHENTICATED_OR_INCOMPLETE_DATA'
      // Use buser.id for logging if userProfile is null
      await perfLogger.logMetrics(buser.id, gameIdForLog, false, errorMessage)
      return c.json({ success: false, error: errorMessage }, 401)
    }

    // Ensure userProfile.operatorId is available for wallet creation and transactions
    if (!userProfile.operatorId) {
      errorMessage = 'USER_PROFILE_MISSING_OPERATOR_ID'
      await perfLogger.logMetrics(userProfile.id, gameIdForLog, false, errorMessage)
      return c.json({ success: false, error: errorMessage }, 400) // Or appropriate error code
    }

    // 2. Platform Game Query (Optimized with Bun.sql)
    console.log('🚀 [2/7] Starting optimized game query...')
    const gameQueryStart = perfLogger.startTimer()

    // Assuming platformGameIdInput is the 'name' field from 'games' table
    const platformGame = await optimizedQueries.getPlatformGame(platformGameIdInput)

    perfLogger.metrics.gameQueryTime = perfLogger.endTimer(gameQueryStart)
    console.log(`✅ Game query completed in ${perfLogger.metrics.gameQueryTime.toFixed(2)}ms`)

    if (!platformGame) {
      errorMessage = 'GAME_NOT_FOUND'
      await perfLogger.logMetrics(userProfile.id, gameIdForLog, false, errorMessage)
      return c.json({ success: false, error: errorMessage }, 404)
    }

    // 3. Parse client request
    const clientSpinRequest = (await c.req.json()) as RTGSpinRequestDto
    console.log('clientSpinRequest', clientSpinRequest)
    const wagerAmountCents = toCents(parseFloat(clientSpinRequest.stake.toString()))

    // 4. Active Game Session Query (Optimized with Bun.sql)
    console.log('🚀 [3/7] Starting optimized session query...')
    const sessionQueryStart = perfLogger.startTimer()

    const activeGameSession = await optimizedQueries.getActiveSession(
      userProfile.id,
      platformGame.id
    )

    perfLogger.metrics.sessionQueryTime = perfLogger.endTimer(sessionQueryStart)
    console.log(`✅ Session query completed in ${perfLogger.metrics.sessionQueryTime.toFixed(2)}ms`)

    if (!activeGameSession) {
      errorMessage = 'NO_ACTIVE_VALID_SESSION'
      await perfLogger.logMetrics(userProfile.id, gameIdForLog, false, errorMessage)
      return c.json({ success: false, error: { code: errorMessage } }, 400)
    }

    // 5. Wallet Query (Optimized with Bun.sql)
    console.log('🚀 [4/7] Starting optimized wallet query...')
    const walletQueryStart = perfLogger.startTimer()

    // userProfile.operatorId is already checked for null above
    const wallet = await optimizedQueries.getOrCreateWallet(userProfile.id, userProfile.operatorId!)

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
      >('spin', 'POST', clientSpinRequest, session.token) // Assuming session.token is the auth token for RGS
      rgsSpinResponse = (rgsResponse as any).result as ProviderSpinResponseData // Adjust based on actual RGS response structure
    } else {
      // Ensure the path to the JSON file is correct relative to the execution context
      const importedData = (await import('./json/rtg-spin-lose.result.json')) as any
      rgsSpinResponse = importedData.default[0].result as ProviderSpinResponseData
    }

    perfLogger.metrics.rgsCallTime = perfLogger.endTimer(rgsCallStart)
    console.log(`✅ RGS call completed in ${perfLogger.metrics.rgsCallTime.toFixed(2)}ms`)

    const actualWinAmountCents = toCents(parseFloat(rgsSpinResponse.game.win.total.toString()))
    const providerRoundIdFromRgs =
      rgsSpinResponse.transactions.roundId?.toString() || `spin-${Date.now()}`

    // 7. Optimized Transaction Block (Bun.sql)
    console.log('🚀 [6/7] Starting optimized transaction...')
    const transactionStart = perfLogger.startTimer()

    const transactionResult = await optimizedQueries.executeGameRoundTransaction({
      userId: userProfile.id,
      operatorId: userProfile.operatorId!, // Already checked for null
      walletId: wallet.id,
      gameSessionId: activeGameSession.id,
      wagerAmountCents,
      winAmountCents: actualWinAmountCents,
      providerRoundId: providerRoundIdFromRgs,
      providerSessionId: clientSpinRequest.sessionId, // This is from the client request
      rgsRawResponse: rgsSpinResponse,
      gameId: platformGame.id,
      providerName: 'RTG', // Or dynamically get from platformGame.providerName if available
    })

    perfLogger.metrics.optimizedTransactionTime = perfLogger.endTimer(transactionStart)
    console.log(
      `✅ Optimized transaction completed in ${perfLogger.metrics.optimizedTransactionTime.toFixed(2)}ms`
    )

    // Emit events
    typedAppEventEmitter.emit(AppEvents.USER_BALANCE_UPDATED, {
      userId: userProfile.id,
      newBalance: transactionResult.finalWallet.balance, // finalWallet.balance is in dollars (float)
      table: 'wallets',
      changeAmount: (actualWinAmountCents - wagerAmountCents) / 100, // change in dollars
      transactionType: TransactionType.BET, // Or determine based on win/loss
      relatedTransactionId: transactionResult.betTransactionId,
    })

    success = true
    await perfLogger.logMetrics(userProfile.id, gameIdForLog, success)

    console.log(
      `🎉 Optimized RTG Spin completed in ${perfLogger.metrics.totalExecutionTime.toFixed(2)}ms`
    )

    // 8. Return response (Step 7/7 in terms of major operations)
    return c.json({
      success: true,
      result: rgsSpinResponse as unknown as RtgSpinResult, // Cast to expected client type
    })
  } catch (error: unknown) {
    const typedError = error instanceof RgsProxyError ? error : new Error(String(error))
    errorMessage = typedError.message

    // Use userIdForLog and gameIdForLog as they are guaranteed to be defined
    await perfLogger.logMetrics(userIdForLog, gameIdForLog, false, errorMessage)
    console.error(`❌ Optimized RTG Spin failed: ${errorMessage}`)

    return c.json({
      success: false,
      error: 'RGS_ERROR', // Generic error type for client
      message: typedError.message,
      details: typedError instanceof RgsProxyError ? typedError.providerDetails : undefined,
    })
  }
}

// import { Context } from 'hono'
// import { User, Session } from 'better-auth/types'
// import { sql } from 'bun'
// import { typedAppEventEmitter, AppEvents } from '../lib/events.js'
// import { TransactionType, TransactionStatus } from '../../prisma/generated/index.js'
// import type { RTGSpinRequestDto, ProviderSpinResponseData, RtgSpinResult } from 'shared'
// import { proxyRequestToRgs, RgsProxyError } from './rtg.service.js'
// import { toCents } from './transaction.service.js'

// // Optimized queries using Bun's native SQL support
// class OptimizedQueries {
//   constructor() {
//     // Bun.sql automatically uses DATABASE_URL environment variable
//   }

//   // User Profile Query with VIP Info (HOTTEST QUERY #1)
//   async getUserProfile(userId: string) {
//     const [user] = await sql`
//       SELECT
//         u.id, u.username, u.balance, u."operatorId", u.role,
//         v.level, v."currentLevelXp", v."totalXp", v."cashbackPercentage"
//       FROM user_profiles u
//       LEFT JOIN vip_infos v ON u."vipInfoId" = v.id
//       WHERE u.id = ${userId}
//     `
//     return user
//   }

//   // Platform Game Query
//   async getPlatformGame(gameName: string) {
//     const [game] = await sql`
//       SELECT id, name, title, category, "gameProviderId"
//       FROM games
//       WHERE name = ${gameName}
//     `
//     return game
//   }

//   // Active Game Session Query
//   async getActiveSession(userId: string, gameId: string) {
//     const [session] = await sql`
//       SELECT id, "userId", "gameId", "currencyId", "startingBalance", "totalWagered", "totalWon", "isActive"
//       FROM game_sessions
//       WHERE "userId" = ${userId} AND "gameId" = ${gameId} AND "isActive" = true
//       LIMIT 1
//     `
//     return session
//   }

//   // Wallet Query with UPSERT (HOTTEST QUERY #4)
//   async getOrCreateWallet(userId: string, operatorId: string) {
//     const [wallet] = await sql`
//       INSERT INTO wallets ("userId", "operatorId", balance, "bonusBalance", "paymentMethod", "lockedBalance")
//       VALUES (${userId}, ${operatorId}, 0, 0, 'CASH_APP', 0)
//       ON CONFLICT ("userId", "operatorId")
//       DO UPDATE SET "updatedAt" = NOW()
//       RETURNING *
//     `
//     return wallet
//   }

//   // Optimized Transaction Block using Bun.sql (HOTTEST QUERY #2)
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
//     return await sql.begin(async (tx) => {
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
//         winTransactionId: winTx?.id,
//         finalWallet,
//         updatedSession,
//         gameSpinId: gameSpin.id,
//         xpAwardedThisSpin: Math.floor(wagerAmountCents / 100),
//       }
//     })
//   }
// }

// // Performance logger for optimized version
// class OptimizedPerformanceLogger {
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
//       optimizedTransactionTime: 0,
//       totalExecutionTime: 0,
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

//     const logText = `
// === OPTIMIZED RTG SPIN PERFORMANCE LOG ===
// Timestamp: ${new Date().toISOString()}
// User ID: ${userId}
// Game ID: ${gameId}
// Success: ${success}
// ${error ? `Error: ${error}` : ''}

// OPTIMIZED PERFORMANCE METRICS (Bun.sql):
// - Total Execution Time: ${this.metrics.totalExecutionTime.toFixed(2)}ms
// - User Profile Query (Bun.sql): ${this.metrics.userProfileQueryTime.toFixed(2)}ms
// - Game Query (Bun.sql): ${this.metrics.gameQueryTime.toFixed(2)}ms
// - Session Query (Bun.sql): ${this.metrics.sessionQueryTime.toFixed(2)}ms
// - Wallet Query (Bun.sql): ${this.metrics.walletQueryTime.toFixed(2)}ms
// - RGS Call Time: ${this.metrics.rgsCallTime.toFixed(2)}ms
// - Optimized Transaction (Bun.sql): ${this.metrics.optimizedTransactionTime.toFixed(2)}ms

// PERFORMANCE IMPROVEMENT vs BASELINE:
// - Target: <500ms total execution time
// - Previous Baseline: ~3800ms average
// - Current Optimized: ${this.metrics.totalExecutionTime.toFixed(2)}ms
// - Improvement: ${(((3800 - this.metrics.totalExecutionTime) / 3800) * 100).toFixed(2)}%

// BUN.SQL PERFORMANCE BREAKDOWN:
// - Database Operations: ${(((this.metrics.userProfileQueryTime + this.metrics.gameQueryTime + this.metrics.sessionQueryTime + this.metrics.walletQueryTime + this.metrics.optimizedTransactionTime) / this.metrics.totalExecutionTime) * 100).toFixed(2)}%
// - RGS Call: ${((this.metrics.rgsCallTime / this.metrics.totalExecutionTime) * 100).toFixed(2)}%

// OPTIMIZATION TECHNIQUES APPLIED:
// ✅ Bun.sql native PostgreSQL driver
// ✅ Single atomic transaction block
// ✅ Prepared statements (automatic)
// ✅ Connection pooling (automatic)
// ✅ Reduced object creation overhead
// ✅ Direct wire protocol communication

// =====================================
// `

//     const logFile = `performance-logs/rtg-spin-optimized-${Date.now()}.txt`
//     try {
//       await Bun.write(logFile, logText, { createPath: true })
//       console.log(`🚀 Optimized performance metrics logged to: ${logFile}`)
//     } catch (err) {
//       console.error('❌ Failed to write optimized performance log:', err)
//     }
//   }
// }

// const optimizedQueries = new OptimizedQueries()

// export async function rtgSpinOptimized(
//   c: Context,
//   buser: User,
//   session: Session,
//   platformGameId: string
// ): Promise<Response> {
//   const perfLogger = new OptimizedPerformanceLogger()
//   let success = false
//   let errorMessage = ''

//   try {
//     // 1. User Profile Query (Optimized with Bun.sql)
//     console.log('🚀 [1/6] Starting optimized user profile query...')
//     const userQueryStart = perfLogger.startTimer()

//     const user = await optimizedQueries.getUserProfile(buser.id)

//     perfLogger.metrics.userProfileQueryTime = perfLogger.endTimer(userQueryStart)
//     console.log(
//       `✅ User profile query completed in ${perfLogger.metrics.userProfileQueryTime.toFixed(2)}ms`
//     )

//     if (!user || !session) {
//       errorMessage = 'UNAUTHENTICATED_OR_INCOMPLETE_DATA'
//       await perfLogger.logMetrics(buser.id, platformGameId, false, errorMessage)
//       return c.json({ success: false, error: errorMessage }, 401)
//     }

//     // 2. Platform Game Query (Optimized with Bun.sql)
//     console.log('🚀 [2/6] Starting optimized game query...')
//     const gameQueryStart = perfLogger.startTimer()

//     const platformGame = await optimizedQueries.getPlatformGame(platformGameId + 'RTG')

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

//     // 4. Active Game Session Query (Optimized with Bun.sql)
//     console.log('🚀 [3/6] Starting optimized session query...')
//     const sessionQueryStart = perfLogger.startTimer()

//     const activeGameSession = await optimizedQueries.getActiveSession(user.id, platformGame.id)

//     perfLogger.metrics.sessionQueryTime = perfLogger.endTimer(sessionQueryStart)
//     console.log(`✅ Session query completed in ${perfLogger.metrics.sessionQueryTime.toFixed(2)}ms`)

//     if (!activeGameSession) {
//       errorMessage = 'NO_ACTIVE_VALID_SESSION'
//       await perfLogger.logMetrics(user.id, platformGameId, false, errorMessage)
//       return c.json({ success: false, error: { code: errorMessage } }, 400)
//     }

//     // 5. Wallet Query (Optimized with Bun.sql)
//     console.log('🚀 [4/6] Starting optimized wallet query...')
//     const walletQueryStart = perfLogger.startTimer()

//     const wallet = await optimizedQueries.getOrCreateWallet(user.id, user.operatorId)

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

//     // 7. Optimized Transaction Block (Bun.sql)
//     console.log('🚀 [6/6] Starting optimized transaction...')
//     const transactionStart = perfLogger.startTimer()

//     const transactionResult = await optimizedQueries.executeGameRoundTransaction({
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

//     perfLogger.metrics.optimizedTransactionTime = perfLogger.endTimer(transactionStart)
//     console.log(
//       `✅ Optimized transaction completed in ${perfLogger.metrics.optimizedTransactionTime.toFixed(2)}ms`
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
//       `🎉 Optimized RTG Spin completed in ${perfLogger.metrics.totalExecutionTime.toFixed(2)}ms`
//     )

//     // 10. Return response
//     return c.json({
//       success: true,
//       result: rgsSpinResponse as unknown as RtgSpinResult,
//     })
//   } catch (error: unknown) {
//     const typedError = error instanceof RgsProxyError ? error : new Error(String(error))
//     errorMessage = typedError.message

//     await perfLogger.logMetrics(buser.id, platformGameId, false, errorMessage)
//     console.error(`❌ Optimized RTG Spin failed: ${errorMessage}`)

//     return c.json({
//       success: false,
//       error: 'RGS_ERROR',
//       message: typedError.message,
//       details: typedError instanceof RgsProxyError ? typedError.providerDetails : undefined,
//     })
//   }
// }
