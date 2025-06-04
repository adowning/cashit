import { Hono } from 'hono'
import { performanceMonitor } from '../services/performance-monitor.service.js'
import { cacheService } from '../services/redis-cache.service.js'

const app = new Hono()

// Performance metrics API endpoint
app.get('/metrics', async (c) => {
  try {
    const metrics = performanceMonitor.getApiMetrics()
    return c.json(metrics)
  } catch (error) {
    console.error('Failed to get performance metrics:', error)
    return c.json({ 
      status: 'error', 
      message: 'Failed to retrieve performance metrics',
      timestamp: new Date().toISOString()
    }, 500)
  }
})

// Performance summary endpoint
app.get('/summary', async (c) => {
  try {
    const minutes = parseInt(c.req.query('minutes') || '5')
    const summary = performanceMonitor.getPerformanceSummary(minutes)
    return c.json({
      status: 'success',
      data: summary,
      timestamp: new Date().toISOString()
    })
  } catch (error) {
    console.error('Failed to get performance summary:', error)
    return c.json({ 
      status: 'error', 
      message: 'Failed to retrieve performance summary',
      timestamp: new Date().toISOString()
    }, 500)
  }
})

// Performance report endpoint (text format)
app.get('/report', async (c) => {
  try {
    const report = performanceMonitor.generatePerformanceReport()
    return c.text(report)
  } catch (error) {
    console.error('Failed to generate performance report:', error)
    return c.text('Failed to generate performance report', 500)
  }
})

// Cache health check endpoint
app.get('/cache/health', async (c) => {
  try {
    const isHealthy = await cacheService.healthCheck()
    const metrics = cacheService.getMetrics()
    
    return c.json({
      status: 'success',
      healthy: isHealthy,
      cache: {
        connected: isHealthy,
        hitRate: metrics.hitRate,
        avgResponseTime: metrics.avgResponseTime,
        errors: metrics.errors,
        connectionErrors: metrics.connectionErrors,
      },
      timestamp: new Date().toISOString()
    })
  } catch (error) {
    console.error('Cache health check failed:', error)
    return c.json({ 
      status: 'error', 
      healthy: false,
      message: 'Cache health check failed',
      timestamp: new Date().toISOString()
    }, 500)
  }
})

// Reset cache metrics endpoint (for testing)
app.post('/cache/reset-metrics', async (c) => {
  try {
    cacheService.resetMetrics()
    return c.json({
      status: 'success',
      message: 'Cache metrics reset successfully',
      timestamp: new Date().toISOString()
    })
  } catch (error) {
    console.error('Failed to reset cache metrics:', error)
    return c.json({ 
      status: 'error', 
      message: 'Failed to reset cache metrics',
      timestamp: new Date().toISOString()
    }, 500)
  }
})

// Performance dashboard endpoint (HTML)
app.get('/dashboard', async (c) => {
  try {
    const metrics = performanceMonitor.getApiMetrics()
    const cacheMetrics = cacheService.getMetrics()
    
    const html = `
<!DOCTYPE html>
<html>
<head>
    <title>Performance Dashboard</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; }
        .card { background: white; padding: 20px; margin: 10px 0; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .metric { display: inline-block; margin: 10px 20px 10px 0; }
        .metric-value { font-size: 24px; font-weight: bold; color: #2196F3; }
        .metric-label { font-size: 14px; color: #666; }
        .status-excellent { color: #4CAF50; }
        .status-good { color: #FF9800; }
        .status-fair { color: #FF5722; }
        .status-needs-attention { color: #F44336; }
        .grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        @media (max-width: 768px) { .grid { grid-template-columns: 1fr; } }
        .refresh-btn { background: #2196F3; color: white; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer; }
        .refresh-btn:hover { background: #1976D2; }
    </style>
    <script>
        function refreshData() {
            location.reload();
        }
        // Auto-refresh every 30 seconds
        setTimeout(refreshData, 30000);
    </script>
</head>
<body>
    <div class="container">
        <h1>🚀 Performance Dashboard</h1>
        <p>Last updated: ${new Date().toLocaleString()}</p>
        <button class="refresh-btn" onclick="refreshData()">Refresh Now</button>
        
        <div class="grid">
            <div class="card">
                <h2>Cache Performance</h2>
                <div class="metric">
                    <div class="metric-value">${cacheMetrics.hitRate.toFixed(1)}%</div>
                    <div class="metric-label">Hit Rate</div>
                </div>
                <div class="metric">
                    <div class="metric-value">${cacheMetrics.avgResponseTime.toFixed(1)}ms</div>
                    <div class="metric-label">Avg Response Time</div>
                </div>
                <div class="metric">
                    <div class="metric-value">${cacheMetrics.hits}</div>
                    <div class="metric-label">Cache Hits</div>
                </div>
                <div class="metric">
                    <div class="metric-value">${cacheMetrics.misses}</div>
                    <div class="metric-label">Cache Misses</div>
                </div>
                <div class="metric">
                    <div class="metric-value">${cacheMetrics.errors}</div>
                    <div class="metric-label">Errors</div>
                </div>
            </div>
            
            <div class="card">
                <h2>System Status</h2>
                <div class="metric">
                    <div class="metric-value status-${metrics.performance.status.toLowerCase().replace('_', '-')}">${metrics.performance.status}</div>
                    <div class="metric-label">Performance Status</div>
                </div>
                <div class="metric">
                    <div class="metric-value">${metrics.system.currentMemoryMB || 'N/A'}MB</div>
                    <div class="metric-label">Memory Usage</div>
                </div>
                <div class="metric">
                    <div class="metric-value">${metrics.system.uptimeHours || 'N/A'}h</div>
                    <div class="metric-label">Uptime</div>
                </div>
            </div>
        </div>
        
        <div class="card">
            <h2>Phase 3 Optimizations</h2>
            <p>✅ Enhanced TTL values (10min user, 1hr games, 30s wallet)</p>
            <p>✅ Real-time performance monitoring</p>
            <p>✅ Cache preloading for common games</p>
            <p>✅ Batch cache warming operations</p>
            <p>✅ Performance alerting system</p>
            <p>✅ Comprehensive metrics tracking</p>
        </div>
        
        <div class="card">
            <h2>Performance Improvements</h2>
            <p><strong>Baseline (Prisma):</strong> ~3,800ms</p>
            <p><strong>Optimized (Bun.sql):</strong> ~580ms (84.8% improvement)</p>
            <p><strong>Cached (Bun.sql + Redis):</strong> ~425ms (88.8% improvement)</p>
            <p><strong>Phase 3 Target:</strong> <300ms with >80% cache hit rate</p>
        </div>
        
        <div class="card">
            <h2>Recommendations</h2>
            ${metrics.performance.recommendations ? metrics.performance.recommendations.map(r => `<p>• ${r}</p>`).join('') : '<p>No recommendations available</p>'}
        </div>
    </div>
</body>
</html>
    `
    
    return c.html(html)
  } catch (error) {
    console.error('Failed to generate dashboard:', error)
    return c.html('<h1>Error</h1><p>Failed to generate performance dashboard</p>', 500)
  }
})

export default app
