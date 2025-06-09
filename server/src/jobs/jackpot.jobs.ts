import prisma from '@/prisma/'
import { JackpotService } from '../services/jackpot.service.js'
import { JACKPOT_CONFIG, JackpotUtils } from '@/types'

const jackpotService = new JackpotService()

/**
 * Jackpot maintenance and monitoring jobs
 */
export class JackpotJobs {
  private static instance: JackpotJobs
  private maintenanceInterval: NodeJS.Timeout | null = null
  private monitoringInterval: NodeJS.Timeout | null = null

  private constructor() {}

  static getInstance(): JackpotJobs {
    if (!JackpotJobs.instance) {
      JackpotJobs.instance = new JackpotJobs()
    }
    return JackpotJobs.instance
  }

  /**
   * Start all jackpot background jobs
   */
  async startJobs(): Promise<void> {
    console.log('🎰 Starting jackpot background jobs...')

    // Initialize jackpots if they don't exist
    await jackpotService.initializeJackpots()

    // Start maintenance job (runs every 5 minutes)
    this.startMaintenanceJob()

    // Start monitoring job (runs every minute)
    this.startMonitoringJob()

    console.log('✅ Jackpot background jobs started successfully')
  }

  /**
   * Stop all jackpot background jobs
   */
  stopJobs(): void {
    console.log('🛑 Stopping jackpot background jobs...')

    if (this.maintenanceInterval) {
      clearInterval(this.maintenanceInterval)
      this.maintenanceInterval = null
    }

    if (this.monitoringInterval) {
      clearInterval(this.monitoringInterval)
      this.monitoringInterval = null
    }

    console.log('✅ Jackpot background jobs stopped')
  }

  /**
   * Maintenance job - runs every 5 minutes
   * - Validates jackpot integrity
   * - Cleans up old records
   * - Ensures jackpots are active
   */
  private startMaintenanceJob(): void {
    this.maintenanceInterval = setInterval(
      async () => {
        try {
          await this.runMaintenanceTasks()
        } catch (error) {
          console.error('❌ Error in jackpot maintenance job:', error)
        }
      },
      15 * 60 * 1000
    ) // 5 minutes

    console.log('🔧 Jackpot maintenance job started (runs every 5 minutes)')
  }

  /**
   * Monitoring job - runs every minute
   * - Logs jackpot status
   * - Checks for anomalies
   * - Updates metrics
   */
  private startMonitoringJob(): void {
    this.monitoringInterval = setInterval(async () => {
      try {
        await this.runMonitoringTasks()
      } catch (error) {
        console.error('❌ Error in jackpot monitoring job:', error)
      }
    }, 60 * 1000) // 1 minute

    console.log('📊 Jackpot monitoring job started (runs every minute)')
  }

  /**
   * Run maintenance tasks
   */
  private async runMaintenanceTasks(): Promise<void> {
    console.log('🔧 Running jackpot maintenance tasks...')

    // 1. Ensure all jackpots exist and are properly configured
    await this.ensureJackpotsExist()

    // 2. Validate jackpot amounts are not negative
    await this.validateJackpotAmounts()

    // 3. Clean up old contribution records (older than 30 days)
    await this.cleanupOldContributions()

    // 4. Verify jackpot win transactions are completed
    await this.verifyJackpotWinTransactions()

    console.log('✅ Jackpot maintenance tasks completed')
  }

  /**
   * Run monitoring tasks
   */
  private async runMonitoringTasks(): Promise<void> {
    // Get current jackpot stats
    const stats = await jackpotService.getJackpotStats()

    // Log current status (only log every 10 minutes to avoid spam)
    const now = new Date()
    if (now.getMinutes() % 10 === 0) {
      console.log('📊 Jackpot Status:')
      stats.jackpots.forEach((jackpot: any) => {
        console.log(
          `  ${jackpot.type}: $${jackpot.currentAmountDollars.toFixed(2)} (${jackpot.currentAmountCoins} coins)`
        )
      })
      console.log(`  Total Pool: $${stats.totalPoolDollars.toFixed(2)}`)
    }

    // Check for anomalies
    await this.checkForAnomalies(stats)
  }

  /**
   * Ensure all required jackpots exist
   */
  private async ensureJackpotsExist(): Promise<void> {
    const existingJackpots = await prisma.jackpot.findMany()
    const existingTypes = existingJackpots.map((j) => j.type)

    for (const [typeName, config] of Object.entries(JACKPOT_CONFIG)) {
      if (!existingTypes.includes(config.type)) {
        console.log(`⚠️ Missing ${typeName} jackpot, creating...`)

        await prisma.jackpot.create({
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

        console.log(`✅ Created missing ${typeName} jackpot`)
      }
    }
  }

  /**
   * Validate jackpot amounts are not negative
   */
  private async validateJackpotAmounts(): Promise<void> {
    const jackpots = await prisma.jackpot.findMany({
      where: {
        currentAmountCoins: {
          lt: 0,
        },
      },
    })

    for (const jackpot of jackpots) {
      console.log(
        `⚠️ Jackpot ${jackpot.type} has negative amount: ${jackpot.currentAmountCoins}, resetting to seed amount`
      )

      const config = JACKPOT_CONFIG[jackpot.type]
      const newSeedAmount = JackpotUtils.generateRandomSeedAmount(config.seedAmountCoins)

      await prisma.jackpot.update({
        where: { id: jackpot.id },
        data: {
          currentAmountCoins: newSeedAmount,
        },
      })

      console.log(`✅ Reset ${jackpot.type} jackpot to ${newSeedAmount} coins`)
    }
  }

  /**
   * Clean up old contribution records
   */
  private async cleanupOldContributions(): Promise<void> {
    const thirtyDaysAgo = new Date()
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30)

    const deletedCount = await prisma.jackpotContribution.deleteMany({
      where: {
        createdAt: {
          lt: thirtyDaysAgo,
        },
      },
    })

    if (deletedCount.count > 0) {
      console.log(`🗑️ Cleaned up ${deletedCount.count} old jackpot contribution records`)
    }
  }

  /**
   * Verify jackpot win transactions are completed
   */
  private async verifyJackpotWinTransactions(): Promise<void> {
    const pendingWins = await prisma.jackpotWin.findMany({
      where: {
        transactionId: null,
      },
      include: {
        jackpot: true,
      },
    })

    if (pendingWins.length > 0) {
      console.log(`⚠️ Found ${pendingWins.length} jackpot wins without transactions`)
      // In a real implementation, you might want to create the missing transactions
      // or alert administrators
    }
  }

  /**
   * Check for anomalies in jackpot data
   */
  private async checkForAnomalies(stats: any): Promise<void> {
    // Check if any jackpot is unusually high
    stats.jackpots.forEach((jackpot: any) => {
      const config = JACKPOT_CONFIG[jackpot.type as keyof typeof JACKPOT_CONFIG]
      const maxExpectedAmount = config.seedAmountCoins * 100 // 100x seed amount

      if (jackpot.currentAmountCoins > maxExpectedAmount) {
        console.log(
          `⚠️ ANOMALY: ${jackpot.type} jackpot is unusually high: $${jackpot.currentAmountDollars}`
        )
      }
    })

    // Check if total pool is unusually low
    if (stats.totalPoolCoins < 1000) {
      // Less than $10 total
      console.log(`⚠️ ANOMALY: Total jackpot pool is unusually low: $${stats.totalPoolDollars}`)
    }
  }

  /**
   * Manual maintenance trigger (for admin use)
   */
  async runManualMaintenance(): Promise<void> {
    console.log('🔧 Running manual jackpot maintenance...')
    await this.runMaintenanceTasks()
    console.log('✅ Manual jackpot maintenance completed')
  }

  /**
   * Get job status
   */
  getJobStatus(): { maintenance: boolean; monitoring: boolean } {
    return {
      maintenance: this.maintenanceInterval !== null,
      monitoring: this.monitoringInterval !== null,
    }
  }
}

// Export singleton instance
export const jackpotJobs = JackpotJobs.getInstance()
