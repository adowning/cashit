import { AppEvents, typedAppEventEmitter } from '@/lib/events'
import { sendToLaravel } from '@/routers/php.routes.js'
import type { Server, ServerWebSocket } from 'bun'
import {
  OpenHandlerContext,
  UserBalanceUpdate,
  UserBalanceUpdatePayload,
  UserProfile,
  WsData,
} from '@/types'

export interface UserEventWsData extends WsData {
  clientId: string
  user: UserProfile
  token: string
}
export function userEventsOpenHandler(context: OpenHandlerContext<any>) {
  console.log('Setting up tournament WebSocket event listeners...')
  const { send } = context

  typedAppEventEmitter.on(AppEvents.USER_BALANCE_UPDATED, (payload: UserBalanceUpdatePayload) => {
    const topic = `user:${payload.userId}:balanceUpdated`
    console.log(topic)
    send(UserBalanceUpdate, {
      userId: payload.userId,
      timestamp: Date.now(),
      content: payload,
    })
    // validateAndPublish(
    //   server,
    //   topic, // Target specific tournament listeners
    //   UserBalanceUpdateEvent, // You'd use your specific Zod schema for this event
    //   'USER_BALANCE_UPDATED', // The 'type' field for the WS message
    //   payload, // The actual data
    //   {} // Optional meta
    // )
    console.log(`Published user update for userId ${payload.userId} to topic ${topic}`)
  })

  console.log('Tournament WebSocket event listeners setup complete.')
}

// src/handlers.ts

// This should match the data you attach during the initial upgrade in your main server file
export interface UserEventWsData extends WsData {
  clientId: string
  // user: { id: string; name: string } // Assuming UserProfile has at least id and name
  token: string
}

/**
 * Handles a new user connecting.
 * This is where you subscribe them to relevant topics.
 */
export function handleUserConnection(ws: OpenHandlerContext<any>['ws']) {
  const userId = ws.data.user.id
  console.log(`User ${userId} (${ws.data.user.name}) connected. Subscribing to topics.`)

  // Subscribe the user to their own private channel
  // This allows you to send messages directly to this user later
  ws.subscribe(`user:${userId}`)

  // Example: Subscribe user to a general 'chat' room
  ws.subscribe('chat-room:general')

  ws.send(JSON.stringify({ type: 'CONNECTION_SUCCESS', payload: 'Welcome!' }))
}

/**
 * Sets up global event listeners that are NOT tied to a specific user connection.
 * This should be called ONLY ONCE when the server starts up.
 * THIS FIXES THE MEMORY LEAK.
 */
export function initializeGlobalEventListeners(server: Server) {
  console.log('Setting up global application event listeners...')

  typedAppEventEmitter.on(AppEvents.USER_BALANCE_UPDATED, (payload: UserBalanceUpdatePayload) => {
    const topic = `user:${payload.userId}` // The user's private topic
    console.log(`Internal event triggered: USER_BALANCE_UPDATED for user ${payload.userId}`)

    // Use the server to publish to the topic. Any client subscribed will get it.
    // We use a custom format here, but you can use validateAndPublish if you prefer.
    const message = {
      type: 'USER_BALANCE_UPDATED',
      payload: payload,
    }
    server.publish(topic, JSON.stringify(message))

    console.log(`Published balance update for userId ${payload.userId} to topic ${topic}`)
  })

  console.log('✅ Global application event listeners setup complete.')
}

/**
 * Handler for when a user sends a chat message.
 */
export function handleLaravelCommand(
  ws: ServerWebSocket<UserEventWsData>,
  payload: any,
  server: Server
) {
  // const { action, userId } = payload
  const { user, token } = ws.data // Get user and token from the connection data

  if (!user || !server) {
    console.warn('[WS SEND_MESSAGE] Missing user data on WebSocket context.')
    return
  }

  const messageToSend = {
    type: 'NEW_MESSAGE',
    payload,
  }

  // 1. Publish the message to all other users in the same room on the Bun server
  console.log(`[Bun] Broadcasting message from ${user.username} to room ${payload}`)
  // server.publish(roomId, JSON.stringify(messageToSend))

  // 2. Forward the message to Laravel for processing/storage
  console.log(`[Bun -> Laravel] Forwarding message from ${user.username} to Laravel backend.`)
  sendToLaravel(ws, {
    ws,
    event: 'client-message', // Use a clear event name for Laravel
    data: {
      ...messageToSend.payload,
      // IMPORTANT: Pass the user's token so Laravel can authenticate the action
      authToken: token,
      ws,
    },
  })
}
