import { Elysia } from 'elysia'
import { WebSocketMonitorService } from '@/services/websocket-monitor.service'
import { z } from 'zod'

export const websocketMonitorRouter = new Elysia({ prefix: '/api/websocket-monitor' })
  .get('/events', async ({ query }) => {
    const limit = query.limit ? parseInt(query.limit as string, 10) : 100
    const events = await WebSocketMonitorService.getRecentEvents(limit)
    return { success: true, data: events }
  }, {
    query: z.object({
      limit: z.string().optional(),
    }),
  })
  .get('/stats', async () => {
    const stats = await WebSocketMonitorService.getConnectionStats()
    return { success: true, data: stats }
  })
  .get('/connections', async () => {
    // This is a simplified example - in a real app, you'd track active connections
    const stats = await WebSocketMonitorService.getConnectionStats()
    return { 
      success: true, 
      data: {
        activeConnections: stats.totalConnections,
        userConnections: stats.userConnections,
        gameConnections: stats.gameConnections,
        messagesPerMinute: stats.messagesPerMinute,
      }
    }
  })
