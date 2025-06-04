# Phase 4 Testing Guide: Jackpot Processing Optimization

## 🎯 Overview

Phase 4 integrates jackpot processing into the main transaction with DragonflyDB caching for maximum performance. This guide provides comprehensive testing strategies to validate the implementation.

## 📋 Prerequisites

### 1. Environment Setup
```bash
# Ensure DragonflyDB is running
docker run -d -p 6379:6379 --name dragonfly docker.dragonflydb.io/dragonflydb/dragonfly

# Verify server is running with Phase 4 code
# Check that jackpot tables exist in database
```

### 2. Test Data
- **Token**: `a5ee3c49b77245cebdd8fbaee90702fd831208a9e98d97fdcf3c97f2055bc00caf6c658f81e9d05356cff2f23b19ca681eb6c542653dea01c1860ffb00b1f8dc`
- **Game**: `BassBoss` (SLOTS category - jackpot eligible)
- **User ID**: `8256602`

## 🚀 Quick Test (2 minutes)

**Start here for immediate validation:**

```bash
./scripts/quick_phase4_test.sh
```

**Expected output:**
```
✅ Settings call successful
✅ Spin completed successfully
💰 Jackpot Contributions: 2
⏱️  Execution Time: 285.45ms
✅ Performance target achieved (<350ms)
🐉 Database Type: DragonflyDB
```

## 🧪 Comprehensive Test Suite (10 minutes)

**Full automated testing:**

```bash
./scripts/test_phase4_jackpots.sh
```

**What it tests:**
- ✅ **RTG Settings** initialization before each spin
- ✅ **Different bet sizes** (0.5, 2.0, 5.0) for jackpot eligibility
- ✅ **Cache performance** with repeated requests
- ✅ **Load testing** with 10 consecutive spins
- ✅ **DragonflyDB connection** verification
- ✅ **Performance log analysis** after each test

## 📊 Real-time Monitoring (Continuous)

**Monitor live jackpot activity:**

```bash
bun run scripts/monitor_phase4_realtime.js
```

**What you'll see:**
```
[14:32:15] New Spin Processed
  🎮 Game: BassBoss | User: 8256602...
  ⏱️  Time: 285.45ms | Cache: 85.7% (0.85ms)
  🐉 DB: DragonflyDB
  💰 Jackpot Contributions: 2
  ✨ EXCELLENT PERFORMANCE (<300ms)
```

## 📈 Performance Analysis

**Analyze historical performance:**

```bash
bun run scripts/analyze_phase4_performance.js
```

**Expected results:**
- 📊 **Average execution time**: <350ms
- 💾 **Cache hit rate**: >80%
- 🎯 **Performance improvement**: 15-20% vs Phase 3
- 🎰 **Jackpot activity**: Contributions and wins tracked

## 🗄️ Database Verification

**Check jackpot data integrity:**

```sql
-- Connect to your database and run:
\i scripts/verify_phase4_database.sql
```

**Key queries verify:**
- ✅ **Jackpot contributions** are being created
- ✅ **Jackpot amounts** are updating correctly
- ✅ **Transaction integrity** for jackpot wins
- ✅ **Data consistency** across tables

## 🎯 Manual Testing Scenarios

### Scenario 1: Basic Jackpot Processing
```bash
# Test SLOTS game with medium bet (should trigger MINOR + MAJOR jackpots)
curl -X POST http://localhost:3000/rtg/games/rtg/platform/BassBossRTG/[token]/game/spin \
  -H "Content-Type: application/json" \
  -d '{
    "token": "a5ee3c49b77245cebdd8fbaee90702fd831208a9e98d97fdcf3c97f2055bc00caf6c658f81e9d05356cff2f23b19ca681eb6c542653dea01c1860ffb00b1f8dc",
    "sessionId": "manual-test-1",
    "playMode": "test",
    "gameId": "BassBoss",
    "userData": {
        "userId": 8256602,
        "affiliate": "",
        "lang": "en",
        "channel": "I",
        "userType": "U",
        "fingerprint": "18d24995-0f1d-49f7-a7e6-c5346f013207"
    },
    "custom": {
        "siteId": "",
        "extras": ""
    },
    "stake": 2.0,
    "bonusId": null,
    "extras": null
  }'
```

### Scenario 2: Cache Performance Test
```bash
# First request (cache miss)
curl -X POST [endpoint] -d '{"stake": 2.0, "sessionId": "cache-test-1", ...}'

# Second request (cache hit)
curl -X POST [endpoint] -d '{"stake": 2.0, "sessionId": "cache-test-2", ...}'
```

### Scenario 3: Different Bet Sizes
```bash
# Small bet (MINOR only)
curl -X POST [endpoint] -d '{"stake": 0.5, ...}'

# Large bet (ALL jackpots)
curl -X POST [endpoint] -d '{"stake": 5.0, ...}'
```

## ✅ Success Criteria

### Performance Targets
- ✅ **Average execution time**: <350ms (15-20% improvement vs Phase 3)
- ✅ **Cache hit rate**: >80%
- ✅ **Cache response time**: <1ms
- ✅ **Zero errors** in jackpot processing

### Functional Requirements
- ✅ **Jackpot contributions** created for SLOTS games
- ✅ **Jackpot amounts** updated correctly
- ✅ **Transaction atomicity** maintained
- ✅ **DragonflyDB** being used consistently

### Expected Console Output
```bash
🚀 [6/7] Starting cached transaction...
💰 Jackpot contributions: 2 jackpots, 15 coins total
✅ Cached transaction completed in 285.45ms
🎉 Cached RTG Spin completed in 295.23ms
```

### Expected Performance Log
```
JACKPOT PROCESSING (Phase 4):
- Jackpot Contributions: 2
- Total Contribution: 15 coins
- Jackpot Win: None

CACHED PERFORMANCE METRICS (Bun.sql + DragonflyDB):
- Total Execution Time: 295.23ms
- Cache Hit Rate: 85.67%
- Cache Avg Response Time: 0.85ms
```

## 🔧 Troubleshooting

### Common Issues

**❌ No jackpot contributions:**
- Verify game category is 'SLOTS' in database
- Check minimum bet requirements in JackpotUtils
- Ensure jackpots are seeded and active

**❌ Poor performance (>350ms):**
- Check DragonflyDB connection and status
- Verify cache hit rates are >80%
- Look for database connection pool issues

**❌ Cache misses:**
- Restart DragonflyDB: `docker restart dragonfly`
- Check cache TTL settings (should be 300s for jackpots)
- Verify cache invalidation logic

**❌ Settings call fails:**
- Check authentication token validity
- Verify RTG service endpoints are correct
- Ensure user exists in database

## 📊 Performance Comparison

| Phase | Technology | Avg Time | Improvement |
|-------|------------|----------|-------------|
| Baseline | Prisma ORM | 3,800ms | - |
| Phase 1 | Bun.sql | 580ms | 84.8% |
| Phase 2 | + Redis | 425ms | 88.8% |
| Phase 3 | + DragonflyDB | 431ms | 88.7% |
| **Phase 4** | **+ Jackpots** | **<350ms** | **>90%** |

## 🎉 Next Steps

After successful Phase 4 testing:

1. **Monitor production** performance for 24-48 hours
2. **Analyze real usage** patterns and cache hit rates
3. **Plan Phase 5** optimizations (Tournament processing)
4. **Consider scaling** optimizations (clustering, read replicas)

## 📞 Support

If tests fail or performance doesn't meet targets:

1. **Check logs** in `server/performance-logs/`
2. **Verify database** with SQL verification script
3. **Monitor real-time** with monitoring script
4. **Review console output** for error messages

---

**Ready to test Phase 4?** Start with the quick test, then run the full suite! 🚀
