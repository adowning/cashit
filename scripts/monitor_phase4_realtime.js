#!/usr/bin/env bun

/**
 * Phase 4 Real-time Monitoring Script
 * Monitors performance logs and console output for jackpot activity
 */

import { watch } from 'fs'
import { readFile, stat } from 'fs/promises'
import { join } from 'path'

const PERFORMANCE_LOG_DIR = 'server/performance-logs'
const MONITOR_INTERVAL = 2000 // 2 seconds

// Track processed files to avoid duplicates
const processedFiles = new Set()
let lastLogCheck = Date.now()

// ANSI color codes for console output
const colors = {
  reset: '\x1b[0m',
  bright: '\x1b[1m',
  red: '\x1b[31m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  magenta: '\x1b[35m',
  cyan: '\x1b[36m',
}

// Format timestamp for display
function formatTime(date) {
  return date.toLocaleTimeString('en-US', {
    hour12: false,
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
  })
}

// Parse and display performance metrics
async function processNewLog(filePath) {
  try {
    const content = await readFile(filePath, 'utf-8')

    // Extract key metrics
    const timestampMatch = content.match(/Timestamp: (.+)/)
    const totalTimeMatch = content.match(/Total Execution Time: ([\d.]+)ms/)
    const cacheHitRateMatch = content.match(/Cache Hit Rate: ([\d.]+)%/)
    const cacheAvgTimeMatch = content.match(/Cache Avg Response Time: ([\d.]+)ms/)
    const jackpotContribMatch = content.match(/Jackpot Contributions: (\d+)/)
    const jackpotWinMatch = content.match(/Jackpot Win: (.+)/)
    const dbTypeMatch = content.match(/CacheDatabase Used: (.+)/)
    const userIdMatch = content.match(/User ID: (.+)/)
    const gameIdMatch = content.match(/Game ID: (.+)/)

    if (!timestampMatch || !totalTimeMatch) {
      return
    }

    const timestamp = new Date(timestampMatch[1])
    const totalTime = parseFloat(totalTimeMatch[1])
    const cacheHitRate = cacheHitRateMatch ? parseFloat(cacheHitRateMatch[1]) : 0
    const cacheAvgTime = cacheAvgTimeMatch ? parseFloat(cacheAvgTimeMatch[1]) : 0
    const jackpotContribs = jackpotContribMatch ? parseInt(jackpotContribMatch[1]) : 0
    const jackpotWin = jackpotWinMatch ? jackpotWinMatch[1].trim() : null
    const dbType = dbTypeMatch ? dbTypeMatch[1].trim() : 'Unknown'
    const userId = userIdMatch ? userIdMatch[1].trim() : 'Unknown'
    const gameId = gameIdMatch ? gameIdMatch[1].trim() : 'Unknown'

    // Color code based on performance
    let timeColor = colors.green
    if (totalTime > 500) timeColor = colors.red
    else if (totalTime > 350) timeColor = colors.yellow

    let cacheColor = colors.green
    if (cacheHitRate < 70) cacheColor = colors.red
    else if (cacheHitRate < 80) cacheColor = colors.yellow

    // Display the metrics
    console.log(
      `\n${colors.cyan}[${formatTime(timestamp)}]${colors.reset} ${colors.bright}New Spin Processed${colors.reset}`
    )
    console.log(
      `  🎮 Game: ${colors.blue}${gameId}${colors.reset} | User: ${userId.substring(0, 8)}...`
    )
    console.log(
      `  ⏱️  Time: ${timeColor}${totalTime.toFixed(2)}ms${colors.reset} | Cache: ${cacheColor}${cacheHitRate.toFixed(1)}%${colors.reset} (${cacheAvgTime.toFixed(2)}ms)`
    )
    console.log(`  🐉 DB: ${colors.magenta}${dbType}${colors.reset}`)

    // Highlight jackpot activity
    if (jackpotContribs > 0) {
      console.log(`  ${colors.yellow}💰 Jackpot Contributions: ${jackpotContribs}${colors.reset}`)
    }

    if (jackpotWin && !jackpotWin.includes('None')) {
      console.log(`  ${colors.green}${colors.bright}🎰 JACKPOT WIN! ${jackpotWin}${colors.reset}`)
    }

    // Performance alerts
    if (totalTime > 500) {
      console.log(`  ${colors.red}⚠️  SLOW PERFORMANCE ALERT (>500ms)${colors.reset}`)
    } else if (totalTime < 300) {
      console.log(`  ${colors.green}✨ EXCELLENT PERFORMANCE (<300ms)${colors.reset}`)
    }

    if (cacheHitRate < 70) {
      console.log(`  ${colors.red}⚠️  LOW CACHE HIT RATE (<70%)${colors.reset}`)
    }
  } catch (error) {
    console.error(`${colors.red}Error processing log file:${colors.reset}`, error)
  }
}

// Check for new log files
async function checkForNewLogs() {
  try {
    const { readdir } = await import('fs/promises')
    const files = await readdir(PERFORMANCE_LOG_DIR)

    const cachedLogFiles = files
      .filter((file) => file.startsWith('rtg-spin-cached-') && file.endsWith('.txt'))
      .map((file) => join(PERFORMANCE_LOG_DIR, file))

    for (const filePath of cachedLogFiles) {
      if (!processedFiles.has(filePath)) {
        try {
          const stats = await stat(filePath)

          // Only process files created after we started monitoring
          if (stats.mtime.getTime() > lastLogCheck) {
            await processNewLog(filePath)
            processedFiles.add(filePath)
          }
        } catch (error) {
          // File might be being written, skip for now
        }
      }
    }
  } catch (error) {
    console.error(`${colors.red}Error checking for new logs:${colors.reset}`, error)
  }
}

// Display monitoring statistics
function displayStats() {
  const now = new Date()
  const uptime = Math.floor((Date.now() - lastLogCheck) / 1000)

  console.log(`\n${colors.cyan}=== PHASE 4 MONITORING STATS ===${colors.reset}`)
  console.log(
    `${colors.bright}Monitoring since:${colors.reset} ${formatTime(new Date(lastLogCheck))}`
  )
  console.log(`${colors.bright}Uptime:${colors.reset} ${uptime}s`)
  console.log(`${colors.bright}Processed logs:${colors.reset} ${processedFiles.size}`)
  console.log(`${colors.bright}Current time:${colors.reset} ${formatTime(now)}`)
  console.log(`${colors.cyan}=================================${colors.reset}\n`)
}

// Main monitoring function
async function startMonitoring() {
  console.log(
    `${colors.green}${colors.bright}🚀 Phase 4 Real-time Monitoring Started${colors.reset}`
  )
  console.log(
    `${colors.cyan}Watching for new performance logs in: ${PERFORMANCE_LOG_DIR}${colors.reset}`
  )
  console.log(`${colors.yellow}Press Ctrl+C to stop monitoring${colors.reset}\n`)

  lastLogCheck = Date.now()

  // Initial stats display
  displayStats()

  // Set up periodic checking
  const checkInterval = setInterval(checkForNewLogs, MONITOR_INTERVAL)

  // Display stats every 30 seconds
  const statsInterval = setInterval(displayStats, 30000)

  // Set up file system watcher for immediate detection
  try {
    const watcher = watch(PERFORMANCE_LOG_DIR, { recursive: false }, (eventType, filename) => {
      if (filename && filename.startsWith('rtg-spin-cached-') && filename.endsWith('.txt')) {
        // Small delay to ensure file is fully written
        setTimeout(() => {
          const filePath = join(PERFORMANCE_LOG_DIR, filename)
          if (!processedFiles.has(filePath)) {
            processNewLog(filePath)
            processedFiles.add(filePath)
          }
        }, 100)
      }
    })

    console.log(`${colors.green}✅ File system watcher active${colors.reset}`)

    // Handle graceful shutdown
    process.on('SIGINT', () => {
      console.log(`\n${colors.yellow}Shutting down monitoring...${colors.reset}`)
      clearInterval(checkInterval)
      clearInterval(statsInterval)
      watcher.close()

      console.log(`${colors.green}Final stats:${colors.reset}`)
      displayStats()
      console.log(`${colors.green}Monitoring stopped. Goodbye!${colors.reset}`)
      process.exit(0)
    })
  } catch (error) {
    console.warn(`${colors.yellow}File watcher not available, using polling only${colors.reset}`)
  }

  // Keep the process running
  process.stdin.resume()
}

// Display help information
function showHelp() {
  console.log(`${colors.bright}Phase 4 Real-time Monitoring${colors.reset}`)
  console.log(
    `${colors.cyan}Monitors performance logs for jackpot activity and performance metrics${colors.reset}\n`
  )

  console.log(`${colors.bright}Usage:${colors.reset}`)
  console.log(`  bun run scripts/monitor_phase4_realtime.js`)
  console.log(`  node scripts/monitor_phase4_realtime.js\n`)

  console.log(`${colors.bright}What it monitors:${colors.reset}`)
  console.log(`  • Execution times and performance alerts`)
  console.log(`  • Cache hit rates and response times`)
  console.log(`  • Jackpot contributions and wins`)
  console.log(`  • DragonflyDB usage confirmation`)
  console.log(`  • Real-time performance trends\n`)

  console.log(`${colors.bright}Color coding:${colors.reset}`)
  console.log(`  ${colors.green}Green${colors.reset} - Good performance (<350ms, >80% cache hit)`)
  console.log(`  ${colors.yellow}Yellow${colors.reset} - Warning (350-500ms, 70-80% cache hit)`)
  console.log(`  ${colors.red}Red${colors.reset} - Poor performance (>500ms, <70% cache hit)`)
  console.log(`  ${colors.magenta}Magenta${colors.reset} - Database type (DragonflyDB/Redis)`)
  console.log(`  ${colors.cyan}Cyan${colors.reset} - Timestamps and headers\n`)
}

// Check command line arguments
if (process.argv.includes('--help') || process.argv.includes('-h')) {
  showHelp()
  process.exit(0)
}

// Start monitoring
startMonitoring().catch((error) => {
  console.error(`${colors.red}Failed to start monitoring:${colors.reset}`, error)
  process.exit(1)
})
