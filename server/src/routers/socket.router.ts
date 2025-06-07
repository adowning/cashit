import { handleJoinRoom, handleSendMessage } from '@/handlers/chat.handler'
import { handlePing } from '@/handlers/heartbeat.handler'
import { nolimitProxyMessageHandler, NoLimitProxyWsData } from '@/handlers/nolimit-proxy.handler'
import { cacheService } from '@/services/redis.service' // Import the Redis service
import { WebSocketMonitorService } from '@/services/websocket-monitor.service'
import { safeJsonParse, subscribeToTopic, unsubscribeFromTopic, validateAndSend } from '@/utils'
import type { Server, ServerWebSocket, WebSocketHandler } from 'bun'
import {
  AppWsData,
  CloseHandler,
  CloseHandlerContext,
  GenericWsResponse,
  JoinRoom,
  LaravelCommand,
  MessageHandler,
  MessageHandlerContext,
  MessageHandlerEntry,
  MessageSchemaType,
  OpenHandler,
  OpenHandlerContext,
  Ping,
  SendFunction,
  SendMessage,
  SubscribeToGeneralTournaments,
  SubscribeToTournamentTopic,
  UnsubscribeFromGeneralTournaments,
  UnsubscribeFromTournamentTopic,
  UpgradeRequestOptions,
  UserBalanceUpdate,
  UserBalanceUpdatePayload,
  UserLeft,
} from 'shared'
import { v4 as randomUUIDv7 } from 'uuid'
import { z } from 'zod'

// export type AppWsData = WsData & {
//   userId?: string
//   username?: string
//   token: string
//   key?: string
//   isNoLimitProxy?: boolean
//   nolimitSessionKey?: string
//   nolimitRemoteWs?: WebSocket
//   nolimitMessageCounter?: number
//   nolimitRememberedData?: { extPlayerKey?: string }
//   nolimitGameCodeString?: string
//   nolimitClientString?: string
//   nolimitLanguage?: string
//   nolimitToken?: string
//   subscribedTournamentTopics?: Set<string>
//   mode?: string
//   gameCodeString?: string
//   kaToken?: string
//   gameId?: string
//   isKaGamingProxy?: boolean
// }

// --- Tournament Topic Subscription Handlers ---
import {
  kagamingProxyMessageHandler,
  KaGamingProxyWsData,
} from '@/handlers/kagaming-proxy.handler'
import { handleLaravelCommand } from '@/handlers/php-slots.handler'
import { AppEvents, typedAppEventEmitter } from '@/lib/events'

function handleSubscribeToTournamentTopic(
  context: MessageHandlerContext<typeof SubscribeToTournamentTopic, AppWsData>
) {
  const { ws, payload, send } = context
  const topic = `tournament:${payload.tournamentId}:${payload.topicType}`
  subscribeToTopic(ws, topic) // Corrected
  if (!ws.data.subscribedTournamentTopics) {
    ws.data.subscribedTournamentTopics = new Set()
  }
  ws.data.subscribedTournamentTopics.add(topic)
  console.log(`User ${ws.data.userId || ws.data.clientId} subscribed to ${topic}`)
  send(GenericWsResponse, { success: true, message: `Subscribed to ${topic}` })
}

function handleUnsubscribeFromTournamentTopic(
  context: MessageHandlerContext<typeof UnsubscribeFromTournamentTopic, AppWsData>
) {
  const { ws, payload, send } = context
  const topic = `tournament:${payload.tournamentId}:${payload.topicType}`
  unsubscribeFromTopic(ws, topic, 'Client request') // Corrected, using the correct function
  ws.data.subscribedTournamentTopics?.delete(topic)
  console.log(`User ${ws.data.userId || ws.data.clientId} unsubscribed from ${topic}`)
  send(GenericWsResponse, { success: true, message: `Unsubscribed from ${topic}` })
}

function handleSubscribeToGeneralTournaments(
  context: MessageHandlerContext<typeof SubscribeToGeneralTournaments, AppWsData>
) {
  const { ws, send } = context
  const topic = `tournaments:general`
  subscribeToTopic(ws, topic) // Corrected
  if (!ws.data.subscribedTournamentTopics) {
    ws.data.subscribedTournamentTopics = new Set()
  }
  ws.data.subscribedTournamentTopics.add(topic)
  console.log(`User ${ws.data.userId || ws.data.clientId} subscribed to ${topic}`)
  send(GenericWsResponse, { success: true, message: `Subscribed to ${topic}` })
}

function handleUnsubscribeFromGeneralTournaments(
  context: MessageHandlerContext<typeof UnsubscribeFromGeneralTournaments, AppWsData>
) {
  const { ws, send } = context
  const topic = `tournaments:general`
  unsubscribeFromTopic(ws, topic, 'Client request') // Corrected, using the correct function
  ws.data.subscribedTournamentTopics?.delete(topic)
  console.log(`User ${ws.data.userId || ws.data.clientId} unsubscribed from ${topic}`)
  send(GenericWsResponse, { success: true, message: `Unsubscribed from ${topic}` })
}

export class WebSocketRouter<T extends AppWsData = AppWsData> {
  private server: Server | null = null
  private messageHandlers: Map<string, MessageHandlerEntry<T>> = new Map()
  private openHandlers: OpenHandler<T>[] = []
  private closeHandlers: CloseHandler<T>[] = []
  data: any

  constructor() {
    this.registerMessageHandler(Ping, handlePing as MessageHandler<typeof Ping, T>)
    this.registerMessageHandler(LaravelCommand, ((context) => {
      // Adapter to match MessageHandler signature
      // context: { ws, payload, send, server }
      handleLaravelCommand(context.ws, context.payload, this.server!)
    }) as MessageHandler<typeof LaravelCommand, T>)
    this.registerMessageHandler(JoinRoom, handleJoinRoom as MessageHandler<typeof JoinRoom, T>)
    this.registerMessageHandler(
      SendMessage,
      handleSendMessage as MessageHandler<typeof SendMessage, T>
    )
    this.registerMessageHandler(
      SubscribeToTournamentTopic,
      handleSubscribeToTournamentTopic as MessageHandler<typeof SubscribeToTournamentTopic, T>
    )
    this.registerMessageHandler(
      UnsubscribeFromTournamentTopic,
      handleUnsubscribeFromTournamentTopic as MessageHandler<
        typeof UnsubscribeFromTournamentTopic,
        T
      >
    )
    this.registerMessageHandler(
      SubscribeToGeneralTournaments,
      handleSubscribeToGeneralTournaments as MessageHandler<typeof SubscribeToGeneralTournaments, T>
    )
    this.registerMessageHandler(
      UnsubscribeFromGeneralTournaments,
      handleUnsubscribeFromGeneralTournaments as MessageHandler<
        typeof UnsubscribeFromGeneralTournaments,
        T
      >
    )

    this.addOpenHandler(this.defaultOpenHandler.bind(this))
    this.addCloseHandler(this.defaultCloseHandler.bind(this))
  }

  public setServer(server: Server): void {
    this.server = server
  }

  public registerMessageHandler<Schema extends MessageSchemaType>(
    schema: Schema,
    handler: MessageHandler<Schema, T>
  ): void {
    const messageType = schema.shape.type.value
    if (this.messageHandlers.has(messageType)) {
      console.warn(`Message handler for type "${messageType}" is being overwritten.`)
    }
    this.messageHandlers.set(messageType, {
      schema: schema as MessageSchemaType,
      handler: handler as MessageHandler<MessageSchemaType, T>,
    })
  }

  public addOpenHandler(handler: OpenHandler<T>): void {
    this.openHandlers.push(handler)
  }

  public addCloseHandler(handler: CloseHandler<T>): void {
    this.closeHandlers.push(handler)
  }

  public upgrade(options: UpgradeRequestOptions<Omit<T, 'clientId'>>): string | null {
    const { server, request, data, headers } = options
    const clientId = randomUUIDv7()
    const success = server.upgrade(request, {
      data: { ...data, clientId, subscribedTournamentTopics: new Set() } as T,
      headers,
    })
    return success ? clientId : null
  }

  private defaultOpenHandler = async (context: OpenHandlerContext<T>): Promise<void> => {
    const { ws } = context
    const { request } = ws.data
    const req = request as Request
    const clientId = randomUUIDv7()
    const xForwardedFor = req.headers.get('x-forwarded-for')
    const ip = xForwardedFor
      ? xForwardedFor?.split(',')[0]?.trim()
      : req.headers.get('x-real-ip') || 'unknown'
    const userAgent = req.headers.get('user-agent') || 'unknown'
    const path = new URL(req.url).pathname

    // Log connection to Redis
    const connectionKey = `ws:connections:${clientId}`
    const connectionData = {
      id: clientId,
      ip,
      userAgent,
      path,
      connectedAt: new Date().toISOString(),
      userId: ws.data.userId,
      username: ws.data.username,
      type: ws.data.isNoLimitProxy ? 'game' : 'user',
    }

    await cacheService.set(connectionKey, JSON.stringify(connectionData), 86400) // 24h TTL

    // Increment connection counter
    await cacheService.incr('ws:stats:total_connections')
    await cacheService.incr(`ws:stats:connections:${new Date().toISOString().split('T')[0]}`)

    // Track active connections
    await cacheService.sadd('ws:active_connections', clientId)

    // Set client ID and other metadata on the WebSocket connection
    ws.data = {
      ...ws.data,
      clientId,
      ip,
      userAgent,
      path,
      connectedAt: new Date().toISOString(),
    } as T

    // Log the connection
    await WebSocketMonitorService.logEvent({
      type: 'connect',
      clientId,
      userId: ws.data.userId,
      username: ws.data.username,
      path,
      size: 0,
      ip,
      userAgent,
    })

    const { ws: wsContext, send } = context
    console.log(wsContext.data)
    const userId =
      typeof wsContext.data.user === 'object' &&
      wsContext.data.user !== null &&
      'id' in wsContext.data.user
        ? (wsContext.data.user as { id?: string }).id
        : undefined
    console.log(`WebSocket opened: ${wsContext.data.clientId}, UserID: ${userId || 'Guest'}`)
    subscribeToTopic(wsContext, 'global') // Corrected
    typedAppEventEmitter.on(AppEvents.USER_BALANCE_UPDATED, (payload: UserBalanceUpdatePayload) => {
      const topic = `user:${payload.userId}:balanceUpdated`
      console.log(topic)
      send(UserBalanceUpdate, {
        userId: payload.userId,
        timestamp: Date.now(),
        content: payload,
      })
      console.log(`Published user update for userId ${payload.userId} to topic ${topic}`)
    })
    if (userId) {
      subscribeToTopic(wsContext, `user_${userId}_updates`) // Corrected
    }
  }

  private defaultCloseHandler = async (context: CloseHandlerContext<T>): Promise<void> => {
    const { ws, code, reason } = context
    const { clientId } = ws.data

    console.log(`Client disconnected: ${clientId}, code: ${code}, reason: ${reason}`)

    // Log disconnection to Redis
    const connectionKey = `ws:connections:${clientId}`
    const connectionData = await cacheService.get(connectionKey)

    if (connectionData) {
      const conn: any = {}
      conn.disconnectedAt = new Date().toISOString()
      conn.disconnectReason = reason
      conn.disconnectCode = code

      // Move to closed connections with 1h TTL
      await cacheService.set(`ws:closed_connections:${clientId}`, JSON.stringify(conn), 3600)
      await cacheService.delete(connectionKey)
    }

    // Remove from active connections
    await cacheService.srem('ws:active_connections', clientId)

    // Update stats
    await cacheService.decr('ws:stats:total_connections')
    await cacheService.incr('ws:stats:total_disconnections')

    // Unsubscribe from all tracked topics on close
    if (ws.data.subscribedTournamentTopics) {
      ws.data.subscribedTournamentTopics.forEach((topic: string) => {
        unsubscribeFromTopic(ws, topic, reason || 'Connection closed') // Corrected, using correct function and reason
      })
      ws.data.subscribedTournamentTopics.clear()
    }
    unsubscribeFromTopic(ws, 'global', reason || 'Connection closed') // Corrected
    if (ws.data.user.id) {
      unsubscribeFromTopic(ws, `user:${ws.data.user.id}`, reason || 'Connection closed') // Corrected
    }

    if (ws.data.currentRoomId && ws.data.user.id && this.server && ws.data.username) {
      this.server.publish(
        ws.data.currentRoomId,
        JSON.stringify({
          type: UserLeft.shape.type.value,
          payload: { userId: ws.data.user.id, username: ws.data.username },
          meta: { timestamp: new Date().toISOString() },
        })
      )
    }
  }

  private async handleClose(
    ws: ServerWebSocket<T>,
    code: number,
    reasonMessage: string
  ): Promise<void> {
    console.log(
      `WebSocket closed: ${ws.data.clientId}, UserID: ${ws.data.userId || 'Guest'}, Code: ${code}, Reason: ${reasonMessage}`
    )
    const send = this.createSendFunction(ws)
    // Pass the actual reason message from the close event to the context
    const context: CloseHandlerContext<T> = { ws, code, reason: reasonMessage, send }

    for (const handler of this.closeHandlers) {
      try {
        await handler(context)
      } catch (error) {
        console.error(`Error in close handler for ${ws.data.clientId}:`, error)
      }
    }
  }
  private async handleOpen(ws: ServerWebSocket<T>): Promise<void> {
    const send = this.createSendFunction(ws)
    const context: OpenHandlerContext<T> = { ws, send }
    for (const handler of this.openHandlers) {
      try {
        await handler(context)
      } catch (error) {
        console.error(`Error in open handler for ${ws.data.clientId}:`, error)
      }
    }
  }
  private async handleMessage(ws: ServerWebSocket<T>, message: string | Buffer): Promise<void> {
    const rawMessage = typeof message === 'string' ? message : message.toString('utf-8')
    const messageSize = Buffer.byteLength(rawMessage, 'utf8')
    let parsedMessage: any
    const timestamp = Date.now()
    const messageId = `${ws.data.clientId}:${timestamp}`

    try {
      parsedMessage = safeJsonParse(rawMessage)
      if (!parsedMessage) {
        console.error('Failed to parse message as JSON:', rawMessage)
        return
      }

      // Log message to Redis
      const messageKey = `ws:messages:${messageId}`
      const messageData = {
        id: messageId,
        clientId: ws.data.clientId,
        userId: ws.data.userId,
        username: ws.data.username,
        path: ws.data['path'],
        direction: 'in',
        timestamp,
        size: messageSize,
        type: parsedMessage.type || 'unknown',
        data: parsedMessage,
      }

      // Store message with 1h TTL
      await cacheService.set(messageKey, JSON.stringify(messageData), 3600)

      // Add to recent messages list (keep last 1000 messages)
      await cacheService.lpush('ws:recent_messages', messageKey)
      await cacheService.ltrim('ws:recent_messages', 0, 999)

      // Update message counters
      await cacheService.incr('ws:stats:total_messages')
      await cacheService.incr(`ws:stats:messages:${new Date().toISOString().split('T')[0]}`)
    } catch (error) {
      console.error('Error parsing message:', error)
      return
    }

    if (ws.data.isNoLimitProxy && typeof nolimitProxyMessageHandler === 'function') {
      nolimitProxyMessageHandler(ws as ServerWebSocket<NoLimitProxyWsData>, message)
      return
    }
    if (ws.data.isKaGamingProxy && typeof kagamingProxyMessageHandler === 'function') {
      kagamingProxyMessageHandler(ws as ServerWebSocket<KaGamingProxyWsData>, message)
      return
    }
    if (ws.data['isphpProxy'] && typeof phpProxyOpenHandler === 'function') {
      phpProxyMessageHandler({ ws: ws as any, send: this.createSendFunction(ws as any) })
      return
    }
    const messageString = message instanceof Buffer ? message.toString() : message
    const parseResult = safeJsonParse(messageString) as any

    if (parseResult.action) {
      handleLaravelCommand(ws, parseResult, this.server as Server)
    }

    if (!parseResult.success || !parseResult.data) {
      console.warn(
        `Received malformed or unparseable WebSocket message from ${ws.data.clientId}: ${messageString}`,
        parseResult.error
      )
      const send = this.createSendFunction(ws)
      send(GenericWsResponse, {
        success: false,
        message: 'Malformed WebSocket message.',
        details: { error: parseResult.error?.message },
      })
      return
    }

    const actualMessageData = parseResult.data

    if (typeof actualMessageData.type !== 'string') {
      console.warn(
        `Parsed WebSocket message from ${ws.data.clientId} lacks a string 'type' property:`,
        actualMessageData
      )
      const send = this.createSendFunction(ws)
      send(GenericWsResponse, {
        success: false,
        message: "Message 'type' property is missing or not a string.",
      })
      return
    }

    const entry = this.messageHandlers.get(actualMessageData.type)
    if (entry) {
      try {
        actualMessageData.payload = {
          userId: ws.data.user.id,
          content: '',
        }

        const validatedMessage = entry.schema.parse(actualMessageData)

        const send = this.createSendFunction(ws)
        const context: MessageHandlerContext<MessageSchemaType, T> = {
          ws,
          ...(validatedMessage as any),
          send,
          server: this.server!,
        }
        await entry.handler(context)
      } catch (error) {
        console.error(
          `Error processing WebSocket message type ${actualMessageData.type} from ${ws.data.clientId}:`,
          error
        )
        const send = this.createSendFunction(ws)
        if (error instanceof z.ZodError) {
          send(GenericWsResponse, {
            success: false,
            message: 'Invalid message structure or payload.',
            details: error.flatten(),
          })
        } else if (error instanceof Error) {
          send(GenericWsResponse, {
            success: false,
            message: error.message || 'Failed to process message.',
          })
        } else {
          send(GenericWsResponse, {
            success: false,
            message: 'An unknown error occurred while processing the message.',
          })
        }
      }
    } else {
      console.warn(
        `No WebSocket message handler registered for type "${actualMessageData.type}" from ${ws.data.clientId}`
      )
      const send = this.createSendFunction(ws)
      send(GenericWsResponse, {
        success: false,
        message: `Unknown message type: ${actualMessageData.type}`,
      })
    }
  }

  private createSendFunction(ws: ServerWebSocket<T>): SendFunction {
    return (schema: any, payload: any, meta: any) => {
      validateAndSend(ws, schema, payload, meta)
    }
  }

  public get websocket(): WebSocketHandler<T> {
    return {
      open: (ws) => this.handleOpen(ws as ServerWebSocket<T>),
      message: (ws, message) => this.handleMessage(ws as ServerWebSocket<T>, message),
      close: (ws, code, reason) => this.handleClose(ws as ServerWebSocket<T>, code, reason),
    }
  }
}
