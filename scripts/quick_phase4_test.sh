#!/bin/bash

# Quick Phase 4 Test Script
# Simple test to verify jackpot processing is working

echo "🚀 QUICK PHASE 4 TEST"
echo "===================="

# Configuration
BASE_URL="http://localhost:3000"
GAME_ID="BassBoss"
GAME_ID_RTG="BassBossRTG"
TOKEN="a5ee3c49b77245cebdd8fbaee90702fd831208a9e98d97fdcf3c97f2055bc00caf6c658f81e9d05356cff2f23b19ca681eb6c542653dea01c1860ffb00b1f8dc"
AUTH_TOKEN="Am72z4iHfZIUY6QZtbHcslwXWfhWxncw"
USER_ID="8256602"
SESSION_ID="quick-test-$(date +%s)"

echo "🎯 Testing Phase 4 jackpot processing..."
echo "Session ID: $SESSION_ID"
echo ""

# Step 1: Call RTG Settings
echo "⚙️  Step 1: Calling RTG Settings..."

settings_payload='{
    "token": "'$TOKEN'",
    "sessionId": "'$SESSION_ID'",
    "playMode": "test",
    "gameId": "'$GAME_ID'",
    "userData": {
        "userId": "demo-user",
        "hash": "",
        "affiliate": "",
        "lang": "en",
        "channel": "I",
        "userType": "U",
        "fingerprint": "18d24995-0f1d-49f7-a7e6-c5346f013207"
    },
    "custom": {
        "siteId": "",
        "extras": ""
    }
}'

settings_response=$(curl -s -w "\n%{http_code}" \
    -X POST "$BASE_URL/rtg/games/rtg/platform/$AUTH_TOKEN/$GAME_ID/game/settings" \
    -H "Content-Type: application/json" \
    -d "$settings_payload")

settings_http_code=$(echo "$settings_response" | tail -n1)

if [ "$settings_http_code" = "200" ]; then
    echo "✅ Settings call successful"
else
    echo "❌ Settings call failed (HTTP $settings_http_code)"
    echo "Response: $(echo "$settings_response" | head -n -1)"
    exit 1
fi

echo ""

# Step 2: Make a spin request
echo "🎰 Step 2: Making spin request (stake: 2.0)..."

spin_payload='{
    "token": "'$TOKEN'",
    "sessionId": "'$SESSION_ID'",
    "playMode": "test",
    "gameId": "'$GAME_ID'",
    "userData": {
        "userId": '$USER_ID',
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

echo "Making request to: $BASE_URL/rtg/games/rtg/platform/$AUTH_TOKEN/$GAME_ID/game/spin"

start_time=$(date +%s%3N)

spin_response=$(curl -s -w "\n%{http_code}\n%{time_total}" \
    -X POST "$BASE_URL/rtg/games/rtg/platform/$AUTH_TOKEN/$GAME_ID/game/spin" \
    -H "Content-Type: application/json" \
    -d "$spin_payload")

end_time=$(date +%s%3N)

# Parse response
http_code=$(echo "$spin_response" | tail -n2 | head -n1)
curl_time=$(echo "$spin_response" | tail -n1)
response_body=$(echo "$spin_response" | head -n -2)
total_time=$((end_time - start_time))

echo "✅ Spin HTTP Status: $http_code"
echo "⏱️  Total Time: ${total_time}ms"
echo "🌐 Curl Time: ${curl_time}s"

if [ "$http_code" = "200" ]; then
    echo "✅ Spin completed successfully"
    
    # Check for jackpot activity
    if echo "$response_body" | grep -q "jackpot"; then
        echo "🎰 Jackpot activity detected!"
    else
        echo "💰 No jackpot activity in response"
    fi
    
    # Show partial response
    echo ""
    echo "📄 Response preview:"
    echo "$response_body" | head -c 500
    echo "..."
    
else
    echo "❌ Spin failed (HTTP $http_code)"
    echo "Response: $response_body"
    exit 1
fi

echo ""

# Step 3: Check performance log
echo "📊 Step 3: Checking latest performance log..."

PERFORMANCE_LOG_DIR="server/performance-logs"
latest_log=$(ls -t $PERFORMANCE_LOG_DIR/rtg-spin-cached-*.txt 2>/dev/null | head -n1)

if [ -n "$latest_log" ]; then
    echo "📄 Latest log: $(basename $latest_log)"
    
    # Extract key metrics
    total_time_log=$(grep "Total Execution Time:" "$latest_log" | grep -o '[0-9.]*ms' | head -n1)
    cache_hit_rate=$(grep "Cache Hit Rate:" "$latest_log" | grep -o '[0-9.]*%' | head -n1)
    jackpot_contributions=$(grep "Jackpot Contributions:" "$latest_log" | grep -o '[0-9]*' | head -n1)
    jackpot_win=$(grep "Jackpot Win:" "$latest_log" | grep -v "None")
    db_type=$(grep "CacheDatabase Used:" "$latest_log" | cut -d: -f2 | xargs)
    
    echo "⏱️  Execution Time: $total_time_log"
    echo "💾 Cache Hit Rate: $cache_hit_rate"
    echo "🐉 Database Type: $db_type"
    
    if [ -n "$jackpot_contributions" ] && [ "$jackpot_contributions" -gt 0 ]; then
        echo "💰 Jackpot Contributions: $jackpot_contributions"
        echo "✅ PHASE 4 JACKPOT PROCESSING IS WORKING!"
    else
        echo "⚠️  No jackpot contributions detected"
    fi
    
    if [ -n "$jackpot_win" ]; then
        echo "🎰 JACKPOT WIN DETECTED!"
        echo "$jackpot_win"
    fi
    
    # Performance check
    if [ -n "$total_time_log" ]; then
        time_value=$(echo "$total_time_log" | grep -o '[0-9.]*')
        if (( $(echo "$time_value < 350" | bc -l) )); then
            echo "✅ Performance target achieved (<350ms)"
        else
            echo "⚠️  Performance target not met (>350ms)"
        fi
    fi
    
else
    echo "❌ No performance log found"
fi

echo ""
echo "🎉 QUICK TEST COMPLETE"
echo "====================="

# Summary
echo "📋 SUMMARY:"
echo "- Settings call: $([ "$settings_http_code" = "200" ] && echo "✅ Success" || echo "❌ Failed")"
echo "- Spin call: $([ "$http_code" = "200" ] && echo "✅ Success" || echo "❌ Failed")"
echo "- Total time: ${total_time}ms"

if [ -n "$db_type" ]; then
    echo "- Database: $db_type"
fi

if [ -n "$jackpot_contributions" ] && [ "$jackpot_contributions" -gt 0 ]; then
    echo "- Jackpot processing: ✅ Active ($jackpot_contributions contributions)"
else
    echo "- Jackpot processing: ⚠️  Not detected"
fi

echo ""
echo "💡 Next steps:"
echo "1. Run full test suite: ./scripts/test_phase4_jackpots.sh"
echo "2. Start monitoring: bun run scripts/monitor_phase4_realtime.js"
echo "3. Analyze performance: bun run scripts/analyze_phase4_performance.js"
