// // src/jobs/cashapp-watcher.job.ts
// import { runCashAppPaymentCheckJob } from '@/services/cashapp-payment-processing.service' // Adjust path as needed

// const CASHAPP_CHECK_INTERVAL_MS = parseInt(
//   process.env.CASHAPP_CHECK_INTERVAL_MS || (5 * 60 * 1000).toString()
// ) // Default 5 minutes
// let cashAppCheckIntervalId: NodeJS.Timeout | null = null

// export class CashAppWatcherJobs {
//   private static instance: CashAppWatcherJobs
//   private isRunning: boolean = false

//   private constructor() {}

//   public static getInstance(): CashAppWatcherJobs {
//     if (!CashAppWatcherJobs.instance) {
//       CashAppWatcherJobs.instance = new CashAppWatcherJobs()
//     }
//     return CashAppWatcherJobs.instance
//   }

//   async startJobs(): Promise<void> {
//     if (this.isRunning) {
//       console.log('CashApp Watcher Job is already running.')
//       return
//     }
//     console.log('💰 Starting CashApp Watcher Job...')
//     try {
//       // Run once on start, then set interval
//       await runCashAppPaymentCheckJob()
//     } catch (error) {
//       console.error('Initial CashApp payment check failed:', error)
//     }

//     cashAppCheckIntervalId = setInterval(async () => {
//       try {
//         await runCashAppPaymentCheckJob()
//       } catch (error) {
//         console.error('Periodic CashApp payment check failed:', error)
//       }
//     }, CASHAPP_CHECK_INTERVAL_MS)

//     this.isRunning = true
//     console.log(
//       `✅ CashApp Watcher Job scheduled. Interval: ${CASHAPP_CHECK_INTERVAL_MS / 1000 / 60} minutes.`
//     )
//   }

//   stopJobs(): void {
//     if (!this.isRunning) {
//       console.log('CashApp Watcher Job is not running.')
//       return
//     }
//     console.log('🛑 Stopping CashApp Watcher Job...')
//     if (cashAppCheckIntervalId) {
//       clearInterval(cashAppCheckIntervalId)
//       cashAppCheckIntervalId = null
//     }
//     this.isRunning = false
//     console.log('✅ CashApp Watcher Job stopped.')
//   }

//   getJobStatus(): { cashAppWatcher: boolean } {
//     return {
//       cashAppWatcher: this.isRunning,
//     }
//   }
// }

// export const cashAppWatcherJobs = CashAppWatcherJobs.getInstance()
