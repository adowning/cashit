#!/usr/bin/env bun

/**
 * Performance Bottleneck Diagnostic Tool
 * Tests each component individually to identify the real performance issue
 */

import { SQL } from 'bun'

const BASE_URL = 'http://localhost:3000'
const AUTH_TOKEN =
  'a5ee3c49b77245cebdd8fbaee90702fd831208a9e98d97fdcf3c97f2055bc00caf6c658f81e9d05356cff2f23b19ca681eb6c542653dea01c1860ffb00b1f8dc'
const GAME_ID_RTG = 'BassBoss'

// Database connection (fixed - using direct host)
const sql = new SQL(
  'postgresql://postgres.acqrudqzutnwrvmvlshc:acqrudqzutnwrvmvlshc@db.acqrudqzutnwrvmvlshc.supabase.co:5432/postgres',
  {
    prepare: false,
    max: 20,
    min: 5,
    idleTimeoutMillis: 30000,
    connectionTimeoutMillis: 5000,
  }
)

function timer() {
  return Bun.nanoseconds()
}

function elapsed(start) {
  return (Bun.nanoseconds() - start) / 1000000
}

async function testDatabaseConnection() {
  console.log('\n🔍 Testing Database Connection...')

  const start = timer()
  try {
    const [result] = await sql`SELECT 1 as test`
    const time = elapsed(start)
    console.log(`✅ Database connection: ${time.toFixed(2)}ms`)
    return time
  } catch (error) {
    const time = elapsed(start)
    console.log(`❌ Database connection failed: ${time.toFixed(2)}ms - ${error.message}`)
    return time
  }
}

async function testSimpleQuery() {
  console.log('\n🔍 Testing Simple Database Query...')

  const start = timer()
  try {
    const result = await sql`SELECT COUNT(*) as count FROM user_profiles LIMIT 1`
    const time = elapsed(start)
    console.log(`✅ Simple query: ${time.toFixed(2)}ms`)
    return time
  } catch (error) {
    const time = elapsed(start)
    console.log(`❌ Simple query failed: ${time.toFixed(2)}ms - ${error.message}`)
    return time
  }
}

async function testComplexQuery() {
  console.log('\n🔍 Testing Complex Database Query (User Profile)...')

  const userId = 'cm4wnqzqy0000hxyg4edkbcyb' // Test user ID
  const start = timer()
  try {
    const [result] = await sql`
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
    `
    const time = elapsed(start)
    console.log(`✅ Complex query: ${time.toFixed(2)}ms`)
    return time
  } catch (error) {
    const time = elapsed(start)
    console.log(`❌ Complex query failed: ${time.toFixed(2)}ms - ${error.message}`)
    return time
  }
}

async function testWalletQuery() {
  console.log('\n🔍 Testing Wallet Query...')

  const userId = 'cm4wnqzqy0000hxyg4edkbcyb'
  const operatorId = 'cm4wnqzqy0001hxyg5f8g9h0i'
  const start = timer()
  try {
    const [result] = await sql`
      INSERT INTO wallets (
        id, "userId", "operatorId", balance, "bonusBalance",
        "paymentMethod", "lockedBalance", "createdAt", "updatedAt"
      )
      VALUES (
        public.generate_cuid(), ${userId}, ${operatorId}, 0, 0,
        'CASH_APP', 0, NOW(), NOW()
      )
      ON CONFLICT ("userId", "operatorId")
      DO UPDATE SET "updatedAt" = NOW()
      RETURNING *
    `
    const time = elapsed(start)
    console.log(`✅ Wallet query: ${time.toFixed(2)}ms`)
    return time
  } catch (error) {
    const time = elapsed(start)
    console.log(`❌ Wallet query failed: ${time.toFixed(2)}ms - ${error.message}`)
    return time
  }
}

async function testTransaction() {
  console.log('\n🔍 Testing Database Transaction...')

  const start = timer()
  try {
    const result = await sql.begin(async (tx) => {
      // Simulate the main transaction operations
      const [wallet] = await tx`SELECT balance FROM wallets LIMIT 1`
      const [user] = await tx`SELECT id FROM user_profiles LIMIT 1`
      const [game] = await tx`SELECT id FROM games LIMIT 1`

      return { wallet, user, game }
    })
    const time = elapsed(start)
    console.log(`✅ Transaction: ${time.toFixed(2)}ms`)
    return time
  } catch (error) {
    const time = elapsed(start)
    console.log(`❌ Transaction failed: ${time.toFixed(2)}ms - ${error.message}`)
    return time
  }
}

async function testRgsCall() {
  console.log('\n🔍 Testing RGS Call...')

  const start = timer()
  try {
    const response = await fetch(
      `${BASE_URL}/rtg/games/rtg/platform/${GAME_ID_RTG}/${AUTH_TOKEN}/rtgsettings`,
      {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({}),
      }
    )

    const time = elapsed(start)
    if (response.ok) {
      console.log(`✅ RGS call: ${time.toFixed(2)}ms`)
    } else {
      console.log(`❌ RGS call failed: ${time.toFixed(2)}ms - Status ${response.status}`)
    }
    return time
  } catch (error) {
    const time = elapsed(start)
    console.log(`❌ RGS call failed: ${time.toFixed(2)}ms - ${error.message}`)
    return time
  }
}

async function testCacheService() {
  console.log('\n🔍 Testing Cache Service...')

  const start = timer()
  try {
    // Test cache set/get
    const testKey = 'performance-test'
    const testData = { test: 'data', timestamp: Date.now() }

    // This would require importing the cache service
    // For now, just measure the time
    const time = elapsed(start)
    console.log(`⚠️  Cache service test skipped (requires service import): ${time.toFixed(2)}ms`)
    return time
  } catch (error) {
    const time = elapsed(start)
    console.log(`❌ Cache service failed: ${time.toFixed(2)}ms - ${error.message}`)
    return time
  }
}

async function testFullSpinEndpoint() {
  console.log('\n🔍 Testing Full Spin Endpoint...')

  const start = timer()
  try {
    const response = await fetch(
      `${BASE_URL}/rtg/games/rtg/platform/${GAME_ID_RTG}/${AUTH_TOKEN}/game/spin`,
      {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          wager: 100,
          lines: 20,
          denomination: 0.01,
        }),
      }
    )

    const time = elapsed(start)
    if (response.ok) {
      console.log(`✅ Full spin endpoint: ${time.toFixed(2)}ms`)
    } else {
      console.log(`❌ Full spin endpoint failed: ${time.toFixed(2)}ms - Status ${response.status}`)
    }
    return time
  } catch (error) {
    const time = elapsed(start)
    console.log(`❌ Full spin endpoint failed: ${time.toFixed(2)}ms - ${error.message}`)
    return time
  }
}

async function runDiagnostics() {
  console.log('🚀 Performance Bottleneck Diagnostic Tool')
  console.log('==========================================')

  const results = {}

  // Test each component
  results.dbConnection = await testDatabaseConnection()
  results.simpleQuery = await testSimpleQuery()
  results.complexQuery = await testComplexQuery()
  results.walletQuery = await testWalletQuery()
  results.transaction = await testTransaction()
  results.rgsCall = await testRgsCall()
  results.cacheService = await testCacheService()
  results.fullEndpoint = await testFullSpinEndpoint()

  // Analysis
  console.log('\n📊 PERFORMANCE ANALYSIS')
  console.log('========================')

  const sortedResults = Object.entries(results)
    .filter(([key, value]) => typeof value === 'number')
    .sort(([, a], [, b]) => b - a)

  console.log('\n🐌 Slowest Components:')
  sortedResults.forEach(([component, time], index) => {
    const emoji = index === 0 ? '🔴' : index === 1 ? '🟡' : '🟢'
    console.log(`${emoji} ${component}: ${time.toFixed(2)}ms`)
  })

  // Recommendations
  console.log('\n💡 RECOMMENDATIONS:')
  console.log('===================')

  const slowestComponent = sortedResults[0]
  if (slowestComponent) {
    const [component, time] = slowestComponent

    if (component === 'fullEndpoint' && time > 500) {
      console.log('🎯 Main bottleneck: Full endpoint (combination of all factors)')
    } else if (component === 'rgsCall' && time > 200) {
      console.log('🎯 Main bottleneck: RGS external service call')
      console.log('   - Consider caching RGS responses')
      console.log('   - Check network latency to RGS service')
    } else if (component.includes('Query') || component === 'transaction') {
      console.log('🎯 Main bottleneck: Database operations')
      console.log('   - Check database indexes')
      console.log('   - Analyze query execution plans')
      console.log('   - Consider database connection latency')
    } else if (component === 'dbConnection' && time > 50) {
      console.log('🎯 Main bottleneck: Database connection')
      console.log('   - Check network latency to Supabase')
      console.log('   - Verify connection pool configuration')
    }
  }

  console.log('\n🔍 Next Steps:')
  if (results.dbConnection > 50) {
    console.log('   1. Test database connection latency')
    console.log('   2. Check Supabase region and network')
  }
  if (results.rgsCall > 200) {
    console.log('   1. Optimize RGS service calls')
    console.log('   2. Add RGS response caching')
  }
  if (results.transaction > 300) {
    console.log('   1. Add database indexes')
    console.log('   2. Analyze slow queries with EXPLAIN')
  }

  console.log('\n✅ Diagnostic complete!')
}

// Run diagnostics
runDiagnostics().catch(console.error)
