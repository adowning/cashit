#!/usr/bin/env bun

/**
 * Phase 4 Performance Analysis Script
 * Analyzes performance logs to compare Phase 3 vs Phase 4 performance
 */

import { readdir, readFile } from 'fs/promises';
import { join } from 'path';

const PERFORMANCE_LOG_DIR = 'server/performance-logs';

// Performance metrics structure
interface PerformanceMetrics {
  timestamp: string;
  totalExecutionTime: number;
  cacheHitRate: number;
  cacheAvgResponseTime: number;
  jackpotContributions?: number;
  jackpotWin?: boolean;
  dbType: string;
}

// Parse a performance log file
async function parsePerformanceLog(filePath: string): Promise<PerformanceMetrics | null> {
  try {
    const content = await readFile(filePath, 'utf-8');
    
    // Extract metrics using regex
    const timestampMatch = content.match(/Timestamp: (.+)/);
    const totalTimeMatch = content.match(/Total Execution Time: ([\d.]+)ms/);
    const cacheHitRateMatch = content.match(/Cache Hit Rate: ([\d.]+)%/);
    const cacheAvgTimeMatch = content.match(/Cache Avg Response Time: ([\d.]+)ms/);
    const jackpotContribMatch = content.match(/Jackpot Contributions: (\d+)/);
    const jackpotWinMatch = content.match(/Jackpot Win: (?!None)/);
    const dbTypeMatch = content.match(/CacheDatabase Used: (.+)/);
    
    if (!timestampMatch || !totalTimeMatch) {
      return null;
    }
    
    return {
      timestamp: timestampMatch[1],
      totalExecutionTime: parseFloat(totalTimeMatch[1]),
      cacheHitRate: cacheHitRateMatch ? parseFloat(cacheHitRateMatch[1]) : 0,
      cacheAvgResponseTime: cacheAvgTimeMatch ? parseFloat(cacheAvgTimeMatch[1]) : 0,
      jackpotContributions: jackpotContribMatch ? parseInt(jackpotContribMatch[1]) : 0,
      jackpotWin: !!jackpotWinMatch,
      dbType: dbTypeMatch ? dbTypeMatch[1].trim() : 'Unknown'
    };
  } catch (error) {
    console.error(`Error parsing ${filePath}:`, error);
    return null;
  }
}

// Analyze performance trends
function analyzePerformance(metrics: PerformanceMetrics[]) {
  if (metrics.length === 0) {
    console.log('❌ No performance data found');
    return;
  }
  
  // Sort by timestamp
  metrics.sort((a, b) => new Date(a.timestamp).getTime() - new Date(b.timestamp).getTime());
  
  // Calculate statistics
  const totalTimes = metrics.map(m => m.totalExecutionTime);
  const cacheHitRates = metrics.map(m => m.cacheHitRate);
  const cacheResponseTimes = metrics.map(m => m.cacheAvgResponseTime);
  
  const avgTotalTime = totalTimes.reduce((a, b) => a + b, 0) / totalTimes.length;
  const minTotalTime = Math.min(...totalTimes);
  const maxTotalTime = Math.max(...totalTimes);
  
  const avgCacheHitRate = cacheHitRates.reduce((a, b) => a + b, 0) / cacheHitRates.length;
  const avgCacheResponseTime = cacheResponseTimes.reduce((a, b) => a + b, 0) / cacheResponseTimes.length;
  
  // Count jackpot activity
  const spinsWithContributions = metrics.filter(m => m.jackpotContributions && m.jackpotContributions > 0).length;
  const spinsWithWins = metrics.filter(m => m.jackpotWin).length;
  const totalContributions = metrics.reduce((sum, m) => sum + (m.jackpotContributions || 0), 0);
  
  // Database type analysis
  const dbTypes = metrics.reduce((acc, m) => {
    acc[m.dbType] = (acc[m.dbType] || 0) + 1;
    return acc;
  }, {} as Record<string, number>);
  
  console.log('📊 PHASE 4 PERFORMANCE ANALYSIS');
  console.log('================================');
  console.log(`📈 Total Samples: ${metrics.length}`);
  console.log(`📅 Time Range: ${metrics[0].timestamp} to ${metrics[metrics.length - 1].timestamp}`);
  console.log('');
  
  console.log('⏱️  EXECUTION TIME METRICS:');
  console.log(`   Average: ${avgTotalTime.toFixed(2)}ms`);
  console.log(`   Best: ${minTotalTime.toFixed(2)}ms`);
  console.log(`   Worst: ${maxTotalTime.toFixed(2)}ms`);
  console.log(`   Target: <350ms`);
  
  if (avgTotalTime < 350) {
    console.log('   ✅ PHASE 4 TARGET ACHIEVED!');
  } else {
    console.log('   ⚠️  Phase 4 target not yet achieved');
  }
  console.log('');
  
  console.log('💾 CACHE PERFORMANCE:');
  console.log(`   Average Hit Rate: ${avgCacheHitRate.toFixed(2)}%`);
  console.log(`   Average Response Time: ${avgCacheResponseTime.toFixed(2)}ms`);
  console.log(`   Target Hit Rate: >80%`);
  
  if (avgCacheHitRate > 80) {
    console.log('   ✅ Cache hit rate target achieved!');
  } else {
    console.log('   ⚠️  Cache hit rate below target');
  }
  console.log('');
  
  console.log('🎰 JACKPOT ACTIVITY (Phase 4):');
  console.log(`   Spins with Contributions: ${spinsWithContributions}/${metrics.length} (${(spinsWithContributions/metrics.length*100).toFixed(1)}%)`);
  console.log(`   Spins with Wins: ${spinsWithWins}/${metrics.length} (${(spinsWithWins/metrics.length*100).toFixed(1)}%)`);
  console.log(`   Total Contributions: ${totalContributions} coins`);
  
  if (spinsWithContributions > 0) {
    console.log('   ✅ Jackpot processing is active!');
  } else {
    console.log('   ⚠️  No jackpot contributions detected');
  }
  console.log('');
  
  console.log('🐉 DATABASE TYPE USAGE:');
  Object.entries(dbTypes).forEach(([type, count]) => {
    console.log(`   ${type}: ${count} samples (${(count/metrics.length*100).toFixed(1)}%)`);
  });
  console.log('');
  
  // Performance trend analysis
  if (metrics.length >= 5) {
    const recent = metrics.slice(-5);
    const older = metrics.slice(0, Math.min(5, metrics.length - 5));
    
    if (older.length > 0) {
      const recentAvg = recent.reduce((a, b) => a + b.totalExecutionTime, 0) / recent.length;
      const olderAvg = older.reduce((a, b) => a + b.totalExecutionTime, 0) / older.length;
      const improvement = ((olderAvg - recentAvg) / olderAvg) * 100;
      
      console.log('📈 PERFORMANCE TREND:');
      console.log(`   Recent Average (last 5): ${recentAvg.toFixed(2)}ms`);
      console.log(`   Earlier Average (first 5): ${olderAvg.toFixed(2)}ms`);
      
      if (improvement > 0) {
        console.log(`   ✅ Performance improved by ${improvement.toFixed(1)}%`);
      } else {
        console.log(`   ⚠️  Performance degraded by ${Math.abs(improvement).toFixed(1)}%`);
      }
      console.log('');
    }
  }
  
  // Phase comparison
  console.log('🚀 PHASE COMPARISON:');
  console.log('   Phase 1 (Bun.sql): ~580ms (84.8% improvement vs baseline)');
  console.log('   Phase 2 (+ Redis): ~425ms (88.8% improvement vs baseline)');
  console.log('   Phase 3 (+ DragonflyDB): ~431ms (maintained performance)');
  console.log(`   Phase 4 (+ Jackpots): ${avgTotalTime.toFixed(2)}ms (current)`);
  
  const phase3Baseline = 431;
  const phase4Improvement = ((phase3Baseline - avgTotalTime) / phase3Baseline) * 100;
  
  if (phase4Improvement > 0) {
    console.log(`   ✅ Phase 4 improved by ${phase4Improvement.toFixed(1)}% vs Phase 3`);
  } else {
    console.log(`   ⚠️  Phase 4 is ${Math.abs(phase4Improvement).toFixed(1)}% slower than Phase 3`);
  }
  
  const baselineImprovement = ((3800 - avgTotalTime) / 3800) * 100;
  console.log(`   🎯 Total improvement vs original: ${baselineImprovement.toFixed(1)}%`);
}

// Main execution
async function main() {
  try {
    console.log('🔍 Analyzing Phase 4 performance logs...\n');
    
    // Read all cached performance log files
    const files = await readdir(PERFORMANCE_LOG_DIR);
    const cachedLogFiles = files
      .filter(file => file.startsWith('rtg-spin-cached-') && file.endsWith('.txt'))
      .map(file => join(PERFORMANCE_LOG_DIR, file));
    
    console.log(`📁 Found ${cachedLogFiles.length} cached performance log files`);
    
    // Parse all log files
    const allMetrics: PerformanceMetrics[] = [];
    
    for (const filePath of cachedLogFiles) {
      const metrics = await parsePerformanceLog(filePath);
      if (metrics) {
        allMetrics.push(metrics);
      }
    }
    
    console.log(`✅ Successfully parsed ${allMetrics.length} performance records\n`);
    
    // Analyze the data
    analyzePerformance(allMetrics);
    
    // Recommendations
    console.log('💡 RECOMMENDATIONS:');
    
    const avgTime = allMetrics.reduce((a, b) => a + b.totalExecutionTime, 0) / allMetrics.length;
    const avgHitRate = allMetrics.reduce((a, b) => a + b.cacheHitRate, 0) / allMetrics.length;
    
    if (avgTime > 350) {
      console.log('   🔧 Consider optimizing slow queries or increasing cache TTL');
    }
    
    if (avgHitRate < 80) {
      console.log('   🔧 Consider cache warming strategies or longer TTL values');
    }
    
    const jackpotSpins = allMetrics.filter(m => m.jackpotContributions && m.jackpotContributions > 0).length;
    if (jackpotSpins === 0) {
      console.log('   🔧 Verify jackpot processing is working - no contributions detected');
    }
    
    const dragonflyUsage = allMetrics.filter(m => m.dbType.includes('Dragonfly')).length;
    if (dragonflyUsage === 0) {
      console.log('   🔧 Verify DragonflyDB is being used instead of Redis');
    }
    
    console.log('\n🎉 Analysis complete!');
    
  } catch (error) {
    console.error('❌ Error during analysis:', error);
    process.exit(1);
  }
}

// Run the analysis
main();
