import { Server } from 'bun'
import { AppEvents, typedAppEventEmitter } from '@/lib/events'

import { validateAndPublish } from '@/lib/utils'
import { UserBalanceUpdateEvent, UserBalanceUpdatePayload } from 'shared'

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

export function setupUserEventsWebSocketListeners(server: Server) {
  console.log('Setting up tournament WebSocket event listeners...')

  typedAppEventEmitter.on(AppEvents.USER_BALANCE_UPDATED, (payload: UserBalanceUpdatePayload) => {
    const topic = `user:${payload.userId}:balanceUpdated`
    // The validateAndPublish function from ws.utils.ts seems to be a good fit here
    // You might need to adapt it or use server.publish directly if the schema doesn't match
    // For example, if DatabaseUpdate is too specific:
    // server.publish(topic, JSON.stringify({ type: "TOURNAMENT_LEADERBOARD_UPDATE", data: payload }));

    // Using validateAndPublish pattern (requires matching schema in '@/sockets/schema.ts')
    // You'd define a 'TournamentLeaderboardUpdateEvent' schema similar to 'DatabaseUpdate'
    validateAndPublish(
      server,
      topic, // Target specific tournament listeners
      UserBalanceUpdateEvent, // You'd use your specific Zod schema for this event
      'USER_BALANCE_UPDATED', // The 'type' field for the WS message
      payload, // The actual data
      {} // Optional meta
    )
    console.log(`Published user update for userId ${payload.userId} to topic ${topic}`)
  })

  console.log('Tournament WebSocket event listeners setup complete.')
}
