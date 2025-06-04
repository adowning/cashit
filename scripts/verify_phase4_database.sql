-- Phase 4 Database Verification Script
-- Verifies jackpot processing integration and data integrity

-- =====================================================
-- JACKPOT SYSTEM VERIFICATION
-- =====================================================

-- 1. Check current jackpot states
SELECT 
    type,
    "currentAmountCoins",
    "seedAmountCoins", 
    "lastWonAt",
    "isActive",
    "createdAt"
FROM jackpots 
ORDER BY type;

-- 2. Check recent jackpot contributions (last 24 hours)
SELECT 
    jc.id,
    j.type as jackpot_type,
    jc."contributionAmountCoins",
    jc."createdAt",
    gs."wagerAmount",
    gs."gameSessionId"
FROM jackpot_contributions jc
JOIN jackpots j ON jc."jackpotId" = j.id
JOIN game_spins gs ON jc."gameSpinId" = gs.id
WHERE jc."createdAt" > NOW() - INTERVAL '24 hours'
ORDER BY jc."createdAt" DESC
LIMIT 20;

-- 3. Check jackpot wins (if any)
SELECT 
    jw.id,
    j.type as jackpot_type,
    jw."winAmountCoins",
    jw."winnerId",
    up.username,
    jw."createdAt",
    gs."gameSessionId"
FROM jackpot_wins jw
JOIN jackpots j ON jw."jackpotId" = j.id
JOIN user_profiles up ON jw."winnerId" = up.id
JOIN game_spins gs ON jw."gameSpinId" = gs.id
WHERE jw."createdAt" > NOW() - INTERVAL '24 hours'
ORDER BY jw."createdAt" DESC;

-- 4. Verify game spins with jackpot activity
SELECT 
    gs.id,
    gs."gameSessionId",
    gs."wagerAmount",
    gs."grossWinAmount",
    gs."timeStamp",
    COUNT(jc.id) as contribution_count,
    COUNT(jw.id) as win_count
FROM game_spins gs
LEFT JOIN jackpot_contributions jc ON gs.id = jc."gameSpinId"
LEFT JOIN jackpot_wins jw ON gs.id = jw."gameSpinId"
WHERE gs."timeStamp" > NOW() - INTERVAL '24 hours'
GROUP BY gs.id, gs."gameSessionId", gs."wagerAmount", gs."grossWinAmount", gs."timeStamp"
HAVING COUNT(jc.id) > 0 OR COUNT(jw.id) > 0
ORDER BY gs."timeStamp" DESC
LIMIT 10;

-- 5. Check transaction integrity for jackpot wins
SELECT 
    t.id,
    t.type,
    t.amount,
    t.description,
    t."createdAt",
    jw.id as jackpot_win_id,
    jw."winAmountCoins"
FROM transactions t
JOIN jackpot_wins jw ON t.id = jw."transactionId"
WHERE t."createdAt" > NOW() - INTERVAL '24 hours'
ORDER BY t."createdAt" DESC;

-- =====================================================
-- PERFORMANCE VERIFICATION
-- =====================================================

-- 6. Check recent game sessions for SLOTS games
SELECT 
    gs.id,
    g.name as game_name,
    g.category,
    gs."totalWagered",
    gs."totalWon",
    gs."createdAt",
    COUNT(gsp.id) as spin_count
FROM game_sessions gs
JOIN games g ON gs."gameId" = g.id
LEFT JOIN game_spins gsp ON gs.id = gsp."gameSessionId"
WHERE g.category = 'SLOTS' 
AND gs."createdAt" > NOW() - INTERVAL '24 hours'
GROUP BY gs.id, g.name, g.category, gs."totalWagered", gs."totalWon", gs."createdAt"
ORDER BY gs."createdAt" DESC
LIMIT 10;

-- 7. Verify wallet balance consistency
SELECT 
    w.id,
    w."userId",
    w.balance,
    w."updatedAt",
    up.username
FROM wallets w
JOIN user_profiles up ON w."userId" = up.id
WHERE w."updatedAt" > NOW() - INTERVAL '24 hours'
ORDER BY w."updatedAt" DESC
LIMIT 10;

-- =====================================================
-- JACKPOT STATISTICS
-- =====================================================

-- 8. Jackpot contribution statistics
SELECT 
    j.type,
    COUNT(jc.id) as total_contributions,
    SUM(jc."contributionAmountCoins") as total_contributed,
    AVG(jc."contributionAmountCoins") as avg_contribution,
    MIN(jc."createdAt") as first_contribution,
    MAX(jc."createdAt") as last_contribution
FROM jackpots j
LEFT JOIN jackpot_contributions jc ON j.id = jc."jackpotId"
WHERE jc."createdAt" > NOW() - INTERVAL '24 hours' OR jc."createdAt" IS NULL
GROUP BY j.type
ORDER BY j.type;

-- 9. Game spin performance metrics
SELECT 
    DATE_TRUNC('hour', gs."timeStamp") as hour,
    COUNT(*) as total_spins,
    COUNT(jc.id) as spins_with_jackpot_contributions,
    COUNT(jw.id) as spins_with_jackpot_wins,
    ROUND(COUNT(jc.id)::numeric / COUNT(*)::numeric * 100, 2) as contribution_rate_percent
FROM game_spins gs
LEFT JOIN jackpot_contributions jc ON gs.id = jc."gameSpinId"
LEFT JOIN jackpot_wins jw ON gs.id = jw."gameSpinId"
WHERE gs."timeStamp" > NOW() - INTERVAL '24 hours'
GROUP BY DATE_TRUNC('hour', gs."timeStamp")
ORDER BY hour DESC;

-- 10. Check for any data integrity issues
-- Orphaned jackpot contributions
SELECT 'Orphaned Contributions' as issue_type, COUNT(*) as count
FROM jackpot_contributions jc
LEFT JOIN game_spins gs ON jc."gameSpinId" = gs.id
WHERE gs.id IS NULL

UNION ALL

-- Orphaned jackpot wins  
SELECT 'Orphaned Wins' as issue_type, COUNT(*) as count
FROM jackpot_wins jw
LEFT JOIN game_spins gs ON jw."gameSpinId" = gs.id
WHERE gs.id IS NULL

UNION ALL

-- Jackpot wins without transactions
SELECT 'Wins Without Transactions' as issue_type, COUNT(*) as count
FROM jackpot_wins jw
LEFT JOIN transactions t ON jw."transactionId" = t.id
WHERE jw."transactionId" IS NULL OR t.id IS NULL;

-- =====================================================
-- CACHE VERIFICATION QUERIES
-- =====================================================

-- 11. Most frequently accessed games (for cache optimization)
SELECT 
    g.name,
    g.category,
    COUNT(gs.id) as session_count,
    COUNT(gsp.id) as spin_count,
    MAX(gs."updatedAt") as last_activity
FROM games g
LEFT JOIN game_sessions gs ON g.id = gs."gameId"
LEFT JOIN game_spins gsp ON gs.id = gsp."gameSessionId"
WHERE gs."createdAt" > NOW() - INTERVAL '24 hours' OR gs."createdAt" IS NULL
GROUP BY g.id, g.name, g.category
ORDER BY spin_count DESC
LIMIT 10;

-- 12. User activity patterns (for cache warming)
SELECT 
    up.id,
    up.username,
    COUNT(DISTINCT gs.id) as active_sessions,
    COUNT(gsp.id) as total_spins,
    MAX(gs."updatedAt") as last_activity,
    SUM(gsp."wagerAmount") as total_wagered
FROM user_profiles up
LEFT JOIN game_sessions gs ON up.id = gs."userId"
LEFT JOIN game_spins gsp ON gs.id = gsp."gameSessionId"
WHERE gs."createdAt" > NOW() - INTERVAL '24 hours' OR gs."createdAt" IS NULL
GROUP BY up.id, up.username
HAVING COUNT(gsp.id) > 0
ORDER BY total_spins DESC
LIMIT 10;
