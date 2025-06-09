export interface PgRealtimeClientOptions {
  user?: string
  password?: string
  host?: string
  port?: number
  database?: string
  minPoolConnections?: number
  maxPoolConnections?: number
  channel?: string
  bufferInterval?: number
  maxBufferSize?: number
  onError?: (error: Error) => void
}

export enum Operation {
  INSERT = 'INSERT',
  UPDATE = 'UPDATE',
  DELETE = 'DELETE',
  ALL = '*',
}

export interface PendingEvent {
  type: 'INSERT' | 'UPDATE' | 'DELETE'
  timestamp: string
  operation: Operation
  schema: string
  table: string
  data: Record<string, any>
  primaryKeyData: Record<string, any>
  columnNamesChanged?: string[]
}

// Export utility functions from their respective files
// export * from './ws'
// export * from './proxy'
// export * from './chat'
