import { ref, computed } from 'vue'
import { useNuxtApp } from '#app'

export interface WebSocketMessage {
  id: string
  clientId: string
  userId?: string
  username?: string
  path: string
  direction: 'in' | 'out'
  timestamp: number
  size: number
  type: string
  data: any
}

export interface WebSocketConnection {
  id: string
  ip: string
  userAgent: string
  path: string
  connectedAt: string
  userId?: string
  username?: string
  type: 'game' | 'user'
  disconnectedAt?: string
  disconnectReason?: string
  disconnectCode?: number
}

export interface WebSocketStats {
  totalConnections: number
  activeConnections: number
  totalMessages: number
  messagesPerMinute: number
  userConnections: number
  gameConnections: number
}

export function useWebSocketMonitor() {
  const { $redis } = useNuxtApp()
  
  const messages = ref<WebSocketMessage[]>([])
  const connections = ref<WebSocketConnection[]>([])
  const stats = ref<WebSocketStats>({
    totalConnections: 0,
    activeConnections: 0,
    totalMessages: 0,
    messagesPerMinute: 0,
    userConnections: 0,
    gameConnections: 0
  })
  const isLoading = ref(false)
  const error = ref<Error | null>(null)

  // Format timestamp to human-readable format
  const formatTime = (timestamp: number) => {
    return new Date(timestamp).toLocaleTimeString()
  }

  // Format bytes to human-readable size
  const formatSize = (bytes: number) => {
    if (bytes === 0) return '0 B'
    const k = 1024
    const sizes = ['B', 'KB', 'MB', 'GB']
    const i = Math.floor(Math.log(bytes) / Math.log(k))
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i]
  }

  // Fetch recent WebSocket messages
  const fetchMessages = async (limit = 50) => {
    try {
      isLoading.value = true
      const messageKeys = await $redis.lrange('ws:recent_messages', 0, limit - 1)
      const messagePromises = messageKeys.map(async (key: string) => {
        const message = await $redis.get(key)
        return message ? JSON.parse(message) : null
      })
      const fetchedMessages = await Promise.all(messagePromises)
      messages.value = fetchedMessages.filter(Boolean).reverse()
    } catch (err) {
      error.value = err as Error
      console.error('Error fetching WebSocket messages:', err)
    } finally {
      isLoading.value = false
    }
  }

  // Fetch active WebSocket connections
  const fetchConnections = async () => {
    try {
      isLoading.value = true
      const connectionIds = await $redis.smembers('ws:active_connections')
      const connectionPromises = connectionIds.map(async (id: string) => {
        const conn = await $redis.get(`ws:connections:${id}`)
        return conn ? JSON.parse(conn) : null
      })
      const fetchedConnections = await Promise.all(connectionPromises)
      connections.value = fetchedConnections.filter(Boolean)
    } catch (err) {
      error.value = err as Error
      console.error('Error fetching WebSocket connections:', err)
    } finally {
      isLoading.value = false
    }
  }

  // Fetch WebSocket statistics
  const fetchStats = async () => {
    try {
      isLoading.value = true
      const [
        totalConnections,
        activeConnections,
        totalMessages,
        messagesPerMinute,
        userConnections,
        gameConnections,
      ] = await Promise.all([
        $redis.get('ws:stats:total_connections') || 0,
        $redis.scard('ws:active_connections') || 0,
        $redis.get('ws:stats:total_messages') || 0,
        $redis.get('ws:stats:messages_per_minute') || 0,
        $redis.scard('ws:user_connections') || 0,
        $redis.scard('ws:game_connections') || 0,
      ])

      stats.value = {
        totalConnections: parseInt(totalConnections as string) || 0,
        activeConnections: parseInt(activeConnections as string) || 0,
        totalMessages: parseInt(totalMessages as string) || 0,
        messagesPerMinute: parseInt(messagesPerMinute as string) || 0,
        userConnections: parseInt(userConnections as string) || 0,
        gameConnections: parseInt(gameConnections as string) || 0,
      }
    } catch (err) {
      error.value = err as Error
      console.error('Error fetching WebSocket stats:', err)
    } finally {
      isLoading.value = false
    }
  }

  // Refresh all data
  const refresh = async () => {
    await Promise.all([
      fetchMessages(),
      fetchConnections(),
      fetchStats(),
    ])
  }

  // Set up auto-refresh
  const startAutoRefresh = (intervalMs = 5000) => {
    const interval = setInterval(refresh, intervalMs)
    return () => clearInterval(interval)
  }

  return {
    // State
    messages,
    connections,
    stats,
    isLoading,
    error,
    
    // Methods
    fetchMessages,
    fetchConnections,
    fetchStats,
    refresh,
    startAutoRefresh,
    
    // Helpers
    formatTime,
    formatSize,
  }
}

export default useWebSocketMonitor
