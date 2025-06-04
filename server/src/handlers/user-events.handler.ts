import { Server } from 'bun'
import { AppEvents, typedAppEventEmitter } from '@/lib/events'

import { validateAndPublish } from '@/lib/utils'
import {
  OpenHandlerContext,
  UserBalanceUpdate,
  UserBalanceUpdateEvent,
  UserBalanceUpdatePayload,
  UserProfile,
  WsData,
} from 'shared'

// Helper to construct a WebSocket message structure if not using validateAndPublish strictly
function formatWebSocketMessage<T>(type: string, payload: T) {
  return JSON.stringify({
    type,
    meta: {
      timestamp: new Date().toISOString(),
      // clientId is usually set by the ws instance, not needed for server.publish to a topic
    },
    payload,
  })
}
export interface UserEventWsData extends WsData {
  // isKaGamingProxy?: boolean
  clientId: string
  // kagamingSessionKey?: string
  // kagamingRemoteWs?: WebSocket
  // kagamingMessageCounter?: number
  // kagamingRememberedData?: { extPlayerKey?: string }
  user: UserProfile
  token: string
  // Add gameCodeString, clientString, language if passed during upgrade
  // kagamingGameCodeString?: string
  // kagamingClientString?: string
  // kagamingLanguage?: string
  // kagamingToken?: string // For real money play
}
export function userEventsOpenHandler(context: OpenHandlerContext<UserEventWsData>) {
  console.log('Setting up tournament WebSocket event listeners...')
  const { ws, send } = context

  typedAppEventEmitter.on(AppEvents.USER_BALANCE_UPDATED, (payload: UserBalanceUpdatePayload) => {
    const topic = `user:${payload.userId}:balanceUpdated`
    console.log(topic)
    // The validateAndPublish function from ws.utils.ts seems to be a good fit here
    // You might need to adapt it or use server.publish directly if the schema doesn't match
    // For example, if DatabaseUpdate is too specific:
    // server.publish(topic, JSON.stringify({ type: "TOURNAMENT_LEADERBOARD_UPDATE", data: payload }));

    // Using validateAndPublish pattern (requires matching schema in '@/sockets/schema.ts')
    // You'd define a 'TournamentLeaderboardUpdateEvent' schema similar to 'DatabaseUpdate'
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
