import type { Server, ServerWebSocket } from 'bun'
import type { AppWsData, MessageSchemaType } from 'shared'
import { z, ZodTypeAny } from 'zod'

export interface WebSocketMessage {
  type: string
  meta: Record<string, any>
  payload?: any
}

export function safeJsonParse(message: string | Buffer): {
  success: boolean
  data?: any
  error?: Error
} {
  try {
    const data = typeof message === 'string' ? JSON.parse(message) : JSON.parse(message.toString())
    return { success: true, data }
  } catch (error) {
    return { success: false, error: error as Error }
  }
}

export function validateMessage<Schema extends MessageSchemaType>(
  schema: Schema,
  payload: any,
  meta: Partial<Omit<z.infer<Schema['shape']['meta']>, 'timestamp'>> = {}
): z.infer<Schema> | undefined {
  try {
    const message = {
      type: schema.shape.type._def.value,
      meta: {
        timestamp: Date.now(),
        ...meta,
      },
      ...(schema.shape.payload && payload !== undefined && { payload }),
    }

    const validationResult = schema.safeParse(message)
    if (!validationResult.success) {
      console.error(
        `[WS UTILS] Validation failed for type "${schema.shape.type._def.value}":`,
        validationResult.error.flatten()
      )
      return undefined
    }

    return validationResult.data as z.infer<Schema>
  } catch (error) {
    console.error(
      `[WS UTILS] Error validating message type "${schema.shape.type._def.value}":`,
      error
    )
    return undefined
  }
}

export function subscribeToTopic(ws: ServerWebSocket<AppWsData>, topic: string): void {
  ws.subscribe(topic)
  console.log(`[WS UTILS] Subscribed to topic: ${topic}`)
}

export function unsubscribeFromTopic(
  ws: ServerWebSocket<AppWsData>,
  topic: string,
  reason: string
): void {
  ws.unsubscribe(topic)
  console.log(`[WS UTILS] Unsubscribed from topic: ${topic} because ${reason}`)
}

export function publish<Schema extends MessageSchemaType>(
  ws: ServerWebSocket<AppWsData>,
  server: Server,
  topic: string,
  schema: Schema,
  payload: Schema['shape'] extends { payload: infer P }
    ? P extends ZodTypeAny
      ? z.infer<P>
      : unknown
    : unknown,
  meta: Partial<Omit<z.infer<Schema['shape']['meta']>, 'clientId' | 'timestamp'>> = {}
): boolean {
  try {
    const messageType = schema.shape.type._def.value

    const message = {
      type: messageType,
      meta: {
        clientId: ws.data.clientId,
        userId: ws.data.user.id,
        timestamp: Date.now(),
        ...meta,
      },
      ...(schema.shape.payload && payload !== undefined && { payload }),
    }

    const validationResult = schema.safeParse(message)
    if (!validationResult.success) {
      console.error(
        `[WS PUBLISH] Validation failed for type "${messageType}" on topic "${topic}":`,
        validationResult.error.flatten()
      )
      return false
    }

    const publishedBytes = server.publish(topic, JSON.stringify(validationResult.data))
    return publishedBytes > 0
  } catch (error) {
    console.error(`[WS PUBLISH] Error publishing message to topic "${topic}":`, error)
    return false
  }
}

export function validateAndSend(ws: any, schema: any, payload: any, meta: any) {
  const validatedMsg = validateMessage(schema, payload, meta)
  if (validatedMsg) {
    ws.send(JSON.stringify(validatedMsg))
  }

  // console.warn(
  //   '[WS UTILS] validateAndSend is a placeholder function and does not perform any action.',
  // );
}

export function validateAndPublish(
  server: Server,
  userTopic: string,
  dbUpdate: any,
  messageType: string,
  payload: any,
  meta: any
) {
  // const validatedMsg = validateMessage(dbUpdate, payload, meta);

  if (userTopic) {
    server.publish(userTopic, JSON.stringify({ type: messageType, payload, dbUpdate, meta }))
  }

  console.warn(`[WS UTILS] published tableName ${payload.table} to topic: ${userTopic}`)
}
