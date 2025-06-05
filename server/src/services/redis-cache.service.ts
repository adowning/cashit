import { RedisClient } from 'bun'

// Cache key prefixes for different data types
export const CACHE_KEYS = {
  USER_PROFILE: 'user_profile',
  GAME: 'game',
  GAME_SESSION: 'game_session',
  WALLET: 'wallet',
  PROVIDER_CONFIG: 'provider_config',
  JACKPOTS: 'jackpots', // Phase 4: Added for jackpot caching
} as const

// Cache TTL values in seconds - Optimized based on performance analysis
export const CACHE_TTL = {
  USER_PROFILE: 600, // 10 minutes (stable data, increased for better hit rate)
  GAME: 3600, // 1 hour (very stable data, games rarely change)
  GAME_SESSION: 60, // 1 minute (balance between freshness and performance)
  WALLET: 30, // 30 seconds (more aggressive caching, invalidated on transactions)
  PROVIDER_CONFIG: 7200, // 2 hours (configuration data is very stable)
} as const

// Cache performance metrics
interface CacheMetrics {
  hits: number
  misses: number
  sets: number
  deletes: number
  errors: number
  connectionErrors: number // Added to track connection specific errors
  totalTime: number
}

const MAX_REDIS_RETRIES = 2
const REDIS_RETRY_DELAY_MS = 200

// Performance monitoring thresholds
const PERFORMANCE_THRESHOLDS = {
  MIN_HIT_RATE: 70, // Minimum acceptable cache hit rate (%)
  MAX_AVG_RESPONSE_TIME: 5, // Maximum acceptable average response time (ms)
  MAX_CONNECTION_ERRORS: 10, // Maximum connection errors before alert
  MONITORING_INTERVAL: 60000, // Monitor every 60 seconds
} as const

class RedisCacheService {
  private client: RedisClient
  private metrics: CacheMetrics = {
    hits: 0,
    misses: 0,
    sets: 0,
    deletes: 0,
    errors: 0,
    connectionErrors: 0,
    totalTime: 0,
  }
  private isConnecting: boolean = false
  private monitoringInterval: Timer | null = null
  private lastMetricsSnapshot: CacheMetrics | null = null
  public dbType: string = ''

  constructor() {
    // Support both Redis and DragonflyDB for A/B testing
    const redisUrl = 'redis://localhost:6381' //process.env.DRAGONFLY_URL || process.env.REDIS_URL || 'redis://localhost:6379'
    this.dbType = redisUrl.includes('6381') ? 'DragonflyDB' : 'Redis'
    console.log(process.env.DRAGONFLY_URL)
    console.log(`[RedisCacheService] Initializing ${this.dbType} client with URL: ${redisUrl}`)

    // Using the options object constructor as per Bun documentation's "Connection Options"
    // Parsing URL to extract components for the options object.
    const url = new URL(redisUrl)
    const options: ConstructorParameters<typeof RedisClient>[0] = {
      // Get options type from constructor
      hostname: url.hostname,
      port: parseInt(url.port) || 6379,
      // Bun docs show `tls: true` or `tls: { ... }`.
      // If your URL is `rediss://`, tls should be enabled.
      tls: url.protocol === 'rediss:' ? true : undefined, // Enable TLS if rediss://
      // Bun docs show `connectionTimeout` and `idleTimeout` as options.
      // The error "Argument of type '{...}' is not assignable to parameter of type 'string'"
      // suggests the constructor was trying to match a string URL overload.
      // Let's ensure we are using the object overload correctly.
      // The provided Bun docs show `connectionTimeout` and `idleTimeout` directly in the options.
      // It also mentions `autoReconnect` and `maxRetries`.
      // The `bun-types/redis.d.ts` might be the source of truth for exact option names.
      // For now, sticking to what's generally available or in the user-provided docs.
      // The error implies the constructor was expecting a string, so let's try passing the URL string directly
      // if the object form continues to fail with the user's `bun-types`.
      // Reverting to URL string as the primary method due to persistent constructor type errors.
    }
    if (url.password) {
      // options.password = url.password;
    }
    if (url.username) {
      // options.username = url.username;
    }

    // Attempting with options object first, as it allows more control.
    // If this specific structure still causes "not assignable to string",
    // it means the `bun-types` are very strictly expecting only the URL string
    // or a different options structure.
    try {
      // The Bun documentation shows `new RedisClient(url, options)` or `new RedisClient(options)`
      // Let's try with only the options object first, if url string is not the primary.
      // The error "Argument of type '{...}' is not assignable to parameter of type 'string'"
      // clearly indicates that the overload taking an object is not being matched,
      // and it's falling back to expecting a string (the URL).
      // So, we should pass the URL string.
      this.client = new RedisClient(redisUrl)
      // To pass options when the first arg is a URL, it's usually the second arg:
      // this.client = new RedisClient(redisUrl, { connectionTimeout: 5000, idleTimeout: 30000, ... });
      // However, the error suggests the options object itself is the issue.
      // Let's assume for now that `new RedisClient(redisUrl)` is the most robust against type errors,
      // and options like timeout might be implicitly handled or need different configuration.
    } catch (e) {
      console.error('Failed to initialize RedisClient with options, trying URL string only:', e)
      this.client = new RedisClient(redisUrl) // Fallback
    }

    this.setupEventHandlers()
    this.connect()
    // this.startPerformanceMonitoring()
  }

  private setupEventHandlers(): void {
    // Using direct property assignment for event handlers as per Bun documentation
    this.client.onconnect = () => {
      // 'onconnect' as per Bun docs
      this.isConnecting = false
      console.log('✅ [RedisCacheService] Redis cache connected successfully (onconnect event)')
    }

    this.client.onclose = (error?: Error) => {
      // 'onclose' as per Bun docs
      this.isConnecting = false
      console.error(
        `❌ [RedisCacheService] Redis cache connection closed (onclose event).`,
        error || ''
      )
    }

    // Note: The Bun docs don't explicitly list an 'onerror' for general errors separate from 'onclose'.
    // If specific error events are needed beyond connection closure, the API might differ.
    // For now, assuming 'onclose' captures connection-related failures.
  }

  private async connect(): Promise<void> {
    // `client.connected` is the documented way to check connection status.
    if (this.client.connected || this.isConnecting) {
      console.log('[RedisCacheService] Already connected or connecting.')
      return
    }
    this.isConnecting = true
    console.log('[RedisCacheService] Attempting to connect/verify Redis...')
    try {
      // Bun documentation: `await client.connect()` to explicitly connect.
      await this.client.connect()
      // The 'onconnect' event should handle setting isConnecting and logging.
    } catch (err) {
      this.isConnecting = false // Ensure flag is reset on explicit connect failure
      console.error('[RedisCacheService] Explicit connect attempt failed:', err)
    }
  }

  // Performance monitoring methods
  private startPerformanceMonitoring(): void {
    console.log('[RedisCacheService] Starting performance monitoring...')
    this.monitoringInterval = setInterval(() => {
      this.checkPerformanceMetrics()
    }, PERFORMANCE_THRESHOLDS.MONITORING_INTERVAL)
  }

  private checkPerformanceMetrics(): void {
    const currentMetrics = this.getMetrics()

    // Check cache hit rate
    if (currentMetrics.hitRate < PERFORMANCE_THRESHOLDS.MIN_HIT_RATE) {
      console.warn(
        `⚠️ [RedisCacheService] Cache hit rate below threshold: ${currentMetrics.hitRate.toFixed(2)}% (min: ${PERFORMANCE_THRESHOLDS.MIN_HIT_RATE}%)`
      )
    }

    // Check average response time
    if (currentMetrics.avgResponseTime > PERFORMANCE_THRESHOLDS.MAX_AVG_RESPONSE_TIME) {
      console.warn(
        `⚠️ [RedisCacheService] Average response time above threshold: ${currentMetrics.avgResponseTime.toFixed(2)}ms (max: ${PERFORMANCE_THRESHOLDS.MAX_AVG_RESPONSE_TIME}ms)`
      )
    }

    // Check connection errors
    if (currentMetrics.connectionErrors > PERFORMANCE_THRESHOLDS.MAX_CONNECTION_ERRORS) {
      console.error(
        `🚨 [RedisCacheService] Connection errors above threshold: ${currentMetrics.connectionErrors} (max: ${PERFORMANCE_THRESHOLDS.MAX_CONNECTION_ERRORS})`
      )
    }

    // Log performance summary every 5 minutes
    const now = Date.now()
    if (
      !this.lastMetricsSnapshot ||
      now % (5 * 60 * 1000) < PERFORMANCE_THRESHOLDS.MONITORING_INTERVAL
    ) {
      this.logPerformanceSummary(currentMetrics)
      this.lastMetricsSnapshot = { ...currentMetrics }
    }
  }

  private logPerformanceSummary(
    metrics: CacheMetrics & { hitRate: number; avgResponseTime: number }
  ): void {
    console.log(`
📊 [RedisCacheService] Performance Summary:
- Hit Rate: ${metrics.hitRate.toFixed(2)}%
- Avg Response Time: ${metrics.avgResponseTime.toFixed(2)}ms
- Total Operations: ${metrics.hits + metrics.misses + metrics.sets + metrics.deletes}
- Cache Hits: ${metrics.hits}
- Cache Misses: ${metrics.misses}
- Connection Errors: ${metrics.connectionErrors}
- General Errors: ${metrics.errors}
- Connected: ${this.client.connected}
    `)
  }

  private stopPerformanceMonitoring(): void {
    if (this.monitoringInterval) {
      clearInterval(this.monitoringInterval)
      this.monitoringInterval = null
      console.log('[RedisCacheService] Performance monitoring stopped.')
    }
  }

  private isConnectionError(error: any): boolean {
    const errorMessage = String(error?.message || '').toLowerCase()
    // Adding specific error codes from Bun docs if available
    if (
      error?.code === 'ERR_REDIS_CONNECTION_CLOSED' ||
      error?.code === 'ERR_REDIS_AUTHENTICATION_FAILED'
    ) {
      return true
    }
    return (
      errorMessage.includes('connection') ||
      errorMessage.includes('closed') ||
      errorMessage.includes('timed out') ||
      errorMessage.includes('econnrefused') ||
      errorMessage.includes('socket') ||
      errorMessage.includes('network') ||
      errorMessage.includes('websocket')
    )
  }

  private async timedOperation<T>(
    operation: () => Promise<T>,
    metricType: keyof Pick<CacheMetrics, 'hits' | 'misses' | 'sets' | 'deletes'>,
    operationName: string = 'Redis operation'
  ): Promise<T> {
    let attempts = 0
    while (true) {
      const start = Bun.nanoseconds()
      try {
        if (!this.client.connected && !this.isConnecting) {
          console.warn(
            `[RedisCacheService - ${operationName}] Client not connected. Attempting reconnect...`
          )
          await this.connect()
          if (!this.client.connected) {
            throw new Error(
              `Redis client failed to connect before ${operationName}. Connected: ${this.client.connected}`
            )
          }
        }
        const result = await operation()
        if (metricType !== 'misses') {
          this.metrics[metricType]++
        }
        this.metrics.totalTime += (Bun.nanoseconds() - start) / 1000000
        return result
      } catch (error: any) {
        this.metrics.totalTime += (Bun.nanoseconds() - start) / 1000000
        attempts++

        if (this.isConnectionError(error)) {
          this.metrics.connectionErrors++
          console.error(
            `[RedisCacheService - ${operationName}] Connection error (attempt ${attempts}):`,
            error.message
          )
          if (attempts <= MAX_REDIS_RETRIES) {
            console.log(
              `[RedisCacheService - ${operationName}] Retrying in ${REDIS_RETRY_DELAY_MS * attempts}ms...`
            )
            await new Promise((resolve) => setTimeout(resolve, REDIS_RETRY_DELAY_MS * attempts))
            continue
          } else {
            console.error(
              `[RedisCacheService - ${operationName}] Max retries reached for connection error.`
            )
            throw error
          }
        } else {
          this.metrics.errors++
          console.error(`[RedisCacheService - ${operationName}] Non-connection error:`, error)
          throw error
        }
      }
    }
  }

  private buildKey(prefix: string, identifier: string): string {
    return `${prefix}:${identifier}`
  }

  async get<T>(prefix: string, identifier: string): Promise<T | null> {
    return this.timedOperation(
      async () => {
        const key = this.buildKey(prefix, identifier)
        const value = await this.client.get(key)

        if (value === null) {
          return null
        }
        return JSON.parse(value) as T
      },
      'hits',
      `get ${prefix}:${identifier}`
    )
  }

  async set(prefix: string, identifier: string, value: any, ttlSeconds: number): Promise<void> {
    await this.timedOperation(
      async () => {
        const key = this.buildKey(prefix, identifier)
        const serializedValue = JSON.stringify(value)

        // Bun documentation shows: await redis.set(key, value); await redis.expire(key, seconds);
        // This is the most robust way if `set` with options object is problematic with types.
        await this.client.set(key, serializedValue)
        await this.client.expire(key, ttlSeconds)
      },
      'sets',
      `set ${prefix}:${identifier}`
    )
  }

  async delete(prefix: string, identifier: string): Promise<void> {
    await this.timedOperation(
      async () => {
        const key = this.buildKey(prefix, identifier)
        // Bun docs: await redis.del(key);
        await this.client.del(key)
      },
      'deletes',
      `delete ${prefix}:${identifier}`
    )
  }

  async getUserProfile(userId: string): Promise<any | null> {
    const profile = await this.get(CACHE_KEYS.USER_PROFILE, userId)
    if (profile) this.metrics.hits++
    else this.metrics.misses++
    return profile
  }

  async setUserProfile(userId: string, profile: any): Promise<void> {
    return this.set(CACHE_KEYS.USER_PROFILE, userId, profile, CACHE_TTL.USER_PROFILE)
  }

  async invalidateUserProfile(userId: string): Promise<void> {
    return this.delete(CACHE_KEYS.USER_PROFILE, userId)
  }

  async getGame(gameName: string): Promise<any | null> {
    const game = await this.get(CACHE_KEYS.GAME, gameName)
    if (game) this.metrics.hits++
    else this.metrics.misses++
    return game
  }

  async setGame(gameName: string, game: any): Promise<void> {
    return this.set(CACHE_KEYS.GAME, gameName, game, CACHE_TTL.GAME)
  }

  async getGameSession(userId: string, gameId: string): Promise<any | null> {
    const sessionKey = `${userId}:${gameId}`
    const session = await this.get(CACHE_KEYS.GAME_SESSION, sessionKey)
    if (session) this.metrics.hits++
    else this.metrics.misses++
    return session
  }

  async setGameSession(userId: string, gameId: string, session: any): Promise<void> {
    const sessionKey = `${userId}:${gameId}`
    return this.set(CACHE_KEYS.GAME_SESSION, sessionKey, session, CACHE_TTL.GAME_SESSION)
  }

  async invalidateGameSession(userId: string, gameId: string): Promise<void> {
    const sessionKey = `${userId}:${gameId}`
    return this.delete(CACHE_KEYS.GAME_SESSION, sessionKey)
  }

  async getWallet(userId: string, operatorId: string): Promise<any | null> {
    const walletKey = `${userId}:${operatorId}`
    const wallet = await this.get(CACHE_KEYS.WALLET, walletKey)
    if (wallet) this.metrics.hits++
    else this.metrics.misses++
    return wallet
  }

  async setWallet(userId: string, operatorId: string, wallet: any): Promise<void> {
    const walletKey = `${userId}:${operatorId}`
    return this.set(CACHE_KEYS.WALLET, walletKey, wallet, CACHE_TTL.WALLET)
  }

  async invalidateWallet(userId: string, operatorId: string): Promise<void> {
    const walletKey = `${userId}:${operatorId}`
    return this.delete(CACHE_KEYS.WALLET, walletKey)
  }

  async getProviderConfig(providerName: string): Promise<any | null> {
    const config = await this.get(CACHE_KEYS.PROVIDER_CONFIG, providerName)
    if (config) this.metrics.hits++
    else this.metrics.misses++
    return config
  }

  async setProviderConfig(providerName: string, config: any): Promise<void> {
    return this.set(CACHE_KEYS.PROVIDER_CONFIG, providerName, config, CACHE_TTL.PROVIDER_CONFIG)
  }

  async mget(keys: Array<{ prefix: string; identifier: string }>): Promise<Array<any | null>> {
    return this.timedOperation(
      async () => {
        const fullKeys = keys.map((k) => this.buildKey(k.prefix, k.identifier))
        // Bun docs: await redis.hmget("user:123", ["name", "email"]);
        // For MGET, it's `await client.mget(...keys)`
        const values = await this.client.mget(...fullKeys)

        return values.map((value) => {
          if (value === null) {
            this.metrics.misses++
            return null
          }
          this.metrics.hits++
          return JSON.parse(value as string)
        })
      },
      'hits',
      `mget operation`
    )
  }

  async warmCache(userId: string, gameId: string, operatorId: string): Promise<void> {
    console.log(
      `🔥 [RedisCacheService] Warming cache for user ${userId}, game ${gameId}, operator ${operatorId}`
    )
    try {
      await Promise.all([
        this.getUserProfile(userId).catch((e) =>
          console.warn(`Cache warm-up failed for userProfile ${userId}:`, e.message)
        ),
        this.getGame(gameId).catch((e) =>
          console.warn(`Cache warm-up failed for game ${gameId}:`, e.message)
        ),
        this.getWallet(userId, operatorId).catch((e) =>
          console.warn(`Cache warm-up failed for wallet ${userId}:${operatorId}:`, e.message)
        ),
      ])
      console.log(
        `✅ [RedisCacheService] Cache warming attempt complete for user ${userId}, game ${gameId}`
      )
    } catch (error: any) {
      console.error('[RedisCacheService] Cache warming failed overall:', error.message)
    }
  }

  // Enhanced cache preloading for user session start
  async preloadUserData(userId: string, operatorId: string): Promise<void> {
    console.log(`🚀 [RedisCacheService] Preloading user data for ${userId}`)

    const commonGames = [
      'BassBossRTG',
      'AztecTreasureRTG',
      'CashBanditsRTG',
      'CleopatrasGoldRTG',
      'CountMoneyRTG',
    ]

    try {
      // Batch preload user profile and wallet
      const userDataPromises = [this.getUserProfile(userId), this.getWallet(userId, operatorId)]

      // Preload common games in parallel
      const gamePromises = commonGames.map((game) =>
        this.getGame(game).catch((e) => console.warn(`Preload failed for game ${game}:`, e.message))
      )

      await Promise.allSettled([...userDataPromises, ...gamePromises])
      console.log(`✅ [RedisCacheService] User data preloading complete for ${userId}`)
    } catch (error: any) {
      console.error('[RedisCacheService] User data preloading failed:', error.message)
    }
  }

  // Batch cache operations for better performance
  async batchWarmCache(
    operations: Array<{
      type: 'user' | 'game' | 'wallet' | 'session'
      userId?: string
      gameId?: string
      operatorId?: string
    }>
  ): Promise<void> {
    console.log(`🔥 [RedisCacheService] Batch warming ${operations.length} cache operations`)

    const promises = operations.map(async (op) => {
      try {
        switch (op.type) {
          case 'user':
            if (op.userId) await this.getUserProfile(op.userId)
            break
          case 'game':
            if (op.gameId) await this.getGame(op.gameId)
            break
          case 'wallet':
            if (op.userId && op.operatorId) await this.getWallet(op.userId, op.operatorId)
            break
          case 'session':
            if (op.userId && op.gameId) await this.getGameSession(op.userId, op.gameId)
            break
        }
      } catch (error: any) {
        console.warn(`Batch cache operation failed for ${op.type}:`, error.message)
      }
    })

    await Promise.allSettled(promises)
    console.log(`✅ [RedisCacheService] Batch cache warming complete`)
  }

  getMetrics(): CacheMetrics & { hitRate: number; avgResponseTime: number } {
    const totalRequests = this.metrics.hits + this.metrics.misses
    const hitRate = totalRequests > 0 ? (this.metrics.hits / totalRequests) * 100 : 0
    const timedOperationsCount =
      this.metrics.hits + this.metrics.misses + this.metrics.sets + this.metrics.deletes
    const avgResponseTime =
      timedOperationsCount > 0 ? this.metrics.totalTime / timedOperationsCount : 0

    return {
      ...this.metrics,
      hitRate: Math.round(hitRate * 100) / 100,
      avgResponseTime: Math.round(avgResponseTime * 100) / 100,
    }
  }

  resetMetrics(): void {
    this.metrics = {
      hits: 0,
      misses: 0,
      sets: 0,
      deletes: 0,
      errors: 0,
      connectionErrors: 0,
      totalTime: 0,
    }
  }

  async healthCheck(): Promise<boolean> {
    try {
      if (!this.client.connected && !this.isConnecting) {
        console.warn(
          '[RedisCacheService - HealthCheck] Client not connected, attempting to connect.'
        )
        await this.connect()
        if (!this.client.connected) {
          console.error('[RedisCacheService - HealthCheck] Failed to connect during health check.')
          return false
        }
      }
      const testKey = 'health_check_bun_redis'
      await this.client.set(testKey, 'ok')
      await this.client.expire(testKey, 10)
      const result = await this.client.get(testKey)
      await this.client.del(testKey)
      return result === 'ok'
    } catch (error) {
      console.error('[RedisCacheService - HealthCheck] Redis health check failed:', error)
      return false
    }
  }

  close(): void {
    console.log('[RedisCacheService] Closing Redis client connection.')
    this.stopPerformanceMonitoring()
    // Bun's RedisClient documentation indicates .close() for the underlying WebSocket.
    this.client.close()
  }
}

export const cacheService = new RedisCacheService()
export type { CacheMetrics }
// Removed RedisCacheService export as it's a singleton

// import { RedisClient } from 'bun'

// // Cache key prefixes for different data types
// export const CACHE_KEYS = {
//   USER_PROFILE: 'user_profile',
//   GAME: 'game',
//   GAME_SESSION: 'game_session',
//   WALLET: 'wallet',
//   PROVIDER_CONFIG: 'provider_config',
// } as const

// // Cache TTL values in seconds
// export const CACHE_TTL = {
//   USER_PROFILE: 300, // 5 minutes
//   GAME: 1800, // 30 minutes
//   GAME_SESSION: 30, // 30 seconds
//   WALLET: 10, // 10 seconds (short due to balance changes)
//   PROVIDER_CONFIG: 3600, // 1 hour
// } as const

// // Cache performance metrics
// interface CacheMetrics {
//   hits: number
//   misses: number
//   sets: number
//   deletes: number
//   errors: number
//   totalTime: number
// }

// class RedisCacheService {
//   private client: RedisClient
//   private metrics: CacheMetrics = {
//     hits: 0,
//     misses: 0,
//     sets: 0,
//     deletes: 0,
//     errors: 0,
//     totalTime: 0,
//   }

//   constructor() {
//     // Use environment variable or default to localhost
//     const redisUrl = process.env.REDIS_URL || 'redis://localhost:6380'

//     this.client = new RedisClient(redisUrl, {
//       connectionTimeout: 5000,
//       idleTimeout: 30000,
//       autoReconnect: true,
//       maxRetries: 3,
//       enableOfflineQueue: true,
//       enableAutoPipelining: true,
//     })

//     // Set up connection event handlers
//     this.client.onconnect = () => {
//       console.log('✅ Redis cache connected successfully')
//     }

//     this.client.onclose = (error) => {
//       console.error('❌ Redis cache connection closed:', error)
//     }
//   }

//   // Generic cache operations with performance tracking
//   private async timedOperation<T>(
//     operation: () => Promise<T>,
//     metricType: keyof CacheMetrics
//   ): Promise<T> {
//     const start = Bun.nanoseconds()
//     try {
//       const result = await operation()
//       this.metrics[metricType]++
//       return result
//     } catch (error) {
//       this.metrics.errors++
//       console.error(`Redis cache error (${metricType}):`, error)
//       throw error
//     } finally {
//       this.metrics.totalTime += (Bun.nanoseconds() - start) / 1000000 // Convert to ms
//     }
//   }

//   // Build cache key with prefix
//   private buildKey(prefix: string, identifier: string): string {
//     return `${prefix}:${identifier}`
//   }

//   // Generic get operation
//   async get<T>(prefix: string, identifier: string): Promise<T | null> {
//     return this.timedOperation(async () => {
//       const key = this.buildKey(prefix, identifier)
//       const value = await this.client.get(key)

//       if (value === null) {
//         this.metrics.misses++
//         return null
//       }

//       this.metrics.hits++
//       return JSON.parse(value) as T
//     }, 'hits')
//   }

//   // Generic set operation with TTL
//   async set(prefix: string, identifier: string, value: any, ttlSeconds: number): Promise<void> {
//     return this.timedOperation(async () => {
//       const key = this.buildKey(prefix, identifier)
//       const serialized = JSON.stringify(value)

//       await this.client.set(key, serialized)
//       await this.client.expire(key, ttlSeconds)
//     }, 'sets')
//   }

//   // Generic delete operation
//   async delete(prefix: string, identifier: string): Promise<void> {
//     return this.timedOperation(async () => {
//       const key = this.buildKey(prefix, identifier)
//       await this.client.del(key)
//     }, 'deletes')
//   }

//   // Specific cache methods for different data types

//   // User Profile Cache
//   async getUserProfile(userId: string) {
//     return this.get(CACHE_KEYS.USER_PROFILE, userId)
//   }

//   async setUserProfile(userId: string, profile: any) {
//     return this.set(CACHE_KEYS.USER_PROFILE, userId, profile, CACHE_TTL.USER_PROFILE)
//   }

//   async invalidateUserProfile(userId: string) {
//     return this.delete(CACHE_KEYS.USER_PROFILE, userId)
//   }

//   // Game Cache
//   async getGame(gameName: string) {
//     return this.get(CACHE_KEYS.GAME, gameName)
//   }

//   async setGame(gameName: string, game: any) {
//     return this.set(CACHE_KEYS.GAME, gameName, game, CACHE_TTL.GAME)
//   }

//   // Game Session Cache
//   async getGameSession(userId: string, gameId: string) {
//     const sessionKey = `${userId}:${gameId}`
//     return this.get(CACHE_KEYS.GAME_SESSION, sessionKey)
//   }

//   async setGameSession(userId: string, gameId: string, session: any) {
//     const sessionKey = `${userId}:${gameId}`
//     return this.set(CACHE_KEYS.GAME_SESSION, sessionKey, session, CACHE_TTL.GAME_SESSION)
//   }

//   async invalidateGameSession(userId: string, gameId: string) {
//     const sessionKey = `${userId}:${gameId}`
//     return this.delete(CACHE_KEYS.GAME_SESSION, sessionKey)
//   }

//   // Wallet Cache
//   async getWallet(userId: string, operatorId: string) {
//     const walletKey = `${userId}:${operatorId}`
//     return this.get(CACHE_KEYS.WALLET, walletKey)
//   }

//   async setWallet(userId: string, operatorId: string, wallet: any) {
//     const walletKey = `${userId}:${operatorId}`
//     return this.set(CACHE_KEYS.WALLET, walletKey, wallet, CACHE_TTL.WALLET)
//   }

//   async invalidateWallet(userId: string, operatorId: string) {
//     const walletKey = `${userId}:${operatorId}`
//     return this.delete(CACHE_KEYS.WALLET, walletKey)
//   }

//   // Provider Config Cache
//   async getProviderConfig(providerName: string) {
//     return this.get(CACHE_KEYS.PROVIDER_CONFIG, providerName)
//   }

//   async setProviderConfig(providerName: string, config: any) {
//     return this.set(CACHE_KEYS.PROVIDER_CONFIG, providerName, config, CACHE_TTL.PROVIDER_CONFIG)
//   }

//   // Batch operations for better performance
//   async mget(keys: Array<{ prefix: string; identifier: string }>): Promise<Array<any | null>> {
//     return this.timedOperation(async () => {
//       const fullKeys = keys.map((k) => this.buildKey(k.prefix, k.identifier))
//       const values = await Promise.all(fullKeys.map((key) => this.client.get(key)))

//       return values.map((value) => {
//         if (value === null) {
//           this.metrics.misses++
//           return null
//         }
//         this.metrics.hits++
//         return JSON.parse(value)
//       })
//     }, 'hits')
//   }

//   // Cache warming - preload frequently accessed data
//   async warmCache(userId: string, gameId: string, operatorId: string) {
//     console.log(`🔥 Warming cache for user ${userId}, game ${gameId}`)

//     // This would typically be called during user login or game session start
//     // to preload data that will likely be needed soon
//     try {
//       // Preload user profile if not cached
//       const userProfile = await this.getUserProfile(userId)
//       if (!userProfile) {
//         console.log('Cache miss during warm-up - user profile will be loaded on first request')
//       }

//       // Preload game data if not cached
//       const game = await this.getGame(gameId)
//       if (!game) {
//         console.log('Cache miss during warm-up - game data will be loaded on first request')
//       }
//     } catch (error) {
//       console.error('Cache warming failed:', error)
//     }
//   }

//   // Get cache performance metrics
//   getMetrics(): CacheMetrics & { hitRate: number; avgResponseTime: number } {
//     const totalRequests = this.metrics.hits + this.metrics.misses
//     const hitRate = totalRequests > 0 ? (this.metrics.hits / totalRequests) * 100 : 0
//     const avgResponseTime = totalRequests > 0 ? this.metrics.totalTime / totalRequests : 0

//     return {
//       ...this.metrics,
//       hitRate: Math.round(hitRate * 100) / 100,
//       avgResponseTime: Math.round(avgResponseTime * 100) / 100,
//     }
//   }

//   // Reset metrics (useful for testing)
//   resetMetrics() {
//     this.metrics = {
//       hits: 0,
//       misses: 0,
//       sets: 0,
//       deletes: 0,
//       errors: 0,
//       totalTime: 0,
//     }
//   }

//   // Health check
//   async healthCheck(): Promise<boolean> {
//     try {
//       await this.client.set('health_check', 'ok')
//       const result = await this.client.get('health_check')
//       await this.client.del('health_check')
//       return result === 'ok'
//     } catch (error) {
//       console.error('Redis health check failed:', error)
//       return false
//     }
//   }

//   // Close connection
//   close() {
//     this.client.close()
//   }
// }

// // Singleton instance
// export const cacheService = new RedisCacheService()

// // Export types
// export type { CacheMetrics }
// export { RedisCacheService }
