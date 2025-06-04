// apps/server/src/services/realtime.service.ts
import type { Server } from 'bun'
import { z } from 'zod'
import { PendingEvent, PgRealtimeClientOptions, validateAndPublish } from '@/lib/utils'
import PgRealtimeClient from './update.service'
import { DatabaseUpdate, UserBalanceUpdateMessageSchema } from 'shared'
import type { UserBalanceUpdatePayloadType } from 'shared'
import { createClient } from '@supabase/supabase-js'
const supabaseUrl = 'https://acqrudqzutnwrvmvlshc.supabase.co'
const supabaseAnonKey =
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFjcXJ1ZHF6dXRud3J2bXZsc2hjIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0ODY0MjUxNSwiZXhwIjoyMDY0MjE4NTE1fQ.JoJPjCo-SGCktLNsowKakpJHQhRHqQIUz2-R4baGhfU'
export const supabase = createClient(supabaseUrl, supabaseAnonKey)
export class RealtimeService {
  private pgClient: PgRealtimeClient
  // Server instance is needed for publish, use definite assignment `!`
  private server!: Server
  private isServerSet: boolean = false // Track if server has been set

  // MODIFIED CONSTRUCTOR: Only takes options now
  constructor(options: PgRealtimeClientOptions) {
    console.log('[RealtimeService] Initializing PgRealtimeClient...')
    this.pgClient = new PgRealtimeClient(options)
    this._registerPgClientErrorHandlers() // Register error handlers early
  }

  /**
   * Injects the Bun Server instance after it has been created.
   */
  public setServer(server: Server): void {
    if (!server) {
      throw new Error('[RealtimeService] Invalid Server instance provided.')
    }
    if (this.isServerSet) {
      console.warn('[RealtimeService] Server instance is already set.')
      return
    }
    this.server = server
    this.isServerSet = true
    console.log('[RealtimeService] Server instance has been set.')
  }

  private _registerPgClientErrorHandlers(): void {
    // Register error handlers for the underlying client
    if (this.pgClient?.subscriber?.events) {
      this.pgClient.subscriber.events.on('error', (err: any) => {
        console.error('[RealtimeService] pg-listen subscriber error:', err)
      })
    } else {
      console.warn(
        '[RealtimeService] Cannot register subscriber error handler - subscriber not ready.'
      )
    }
    if (this.pgClient?.pool) {
      this.pgClient.pool.on('error', (err: any) => {
        console.error('[RealtimeService] pg pool error:', err)
      })
    } else {
      console.warn('[RealtimeService] Cannot register pool error handler - pool not ready.')
    }
  }

  /**
   * Connects to the database and starts listening for notifications.
   * Should be called AFTER setServer has been called.
   */
  public async startListening(): Promise<void> {
    // Ensure server instance is set before proceeding
    if (!this.isServerSet) {
      console.error('[RealtimeService] Cannot start listening: Server instance not set.')
      throw new Error(
        'RealtimeService requires the server instance to be set before starting listeners.'
      )
    }
    try {
      console.log('[RealtimeService] Connecting and setting up DB listeners...')
      this._setupTableListeners() // Define listeners
      await this.pgClient.listen() // Connect and listen to channel
      // const allChanges = supabase
      //   .channel('spec_data_change')
      //   .on(
      //     'postgres_changes',
      //     {
      //       event: '*',
      //       schema: 'public',
      //     },
      //     (payload) => console.log(payload)
      //   )
      //   .subscribe()
      const channelId = 'spec_data_change'

      // Create a filter only for new messages
      const databaseFilter = {
        schema: 'public',
        table: 'user_profiles',
        // filter: `room_id=eq.${channelId}`,
        event: 'UPDATE',
      }

      const channel = supabase
        .channel(channelId)
        //@ts-ignore
        .on('postgres_changes', databaseFilter, (payload: any) => receivedDatabaseEvent(payload))
        .subscribe()

      const receivedDatabaseEvent = (event: any) => {
        console.log(event)
        const userTopic = `user_${event.new.id}_updates`

        const messageType = 'USER_BALANCE_UPDATE'
        validateAndPublish(this.server, userTopic, DatabaseUpdate, messageType, event.new, {
          timestamp: Date.now(),
        })
        console.log(`Sent USER_BALANCE_UPDATE to user ${event.new.id}`)
      }
      console.log(`[RealtimeService] Listening for DB changes on channel: ${this.pgClient.channel}`)
    } catch (error) {
      console.error('[RealtimeService] Failed to start listening:', error)
      throw error
    }
  }

  // ... (rest of the methods: _setupTableListeners, _handleRawDbEvent, publishDbUpdate, stopListening)
  // Ensure publishDbUpdate uses `this.server` and checks `this.isServerSet`

  private _setupTableListeners(): void {
    // ... listeners using this.pgClient.table(...).on(...) ...
    console.log('two listers up and running')
    this.pgClient.table('transactions', { schema: 'public' }).on('*', (event: any) => {
      console.log('ding')
      if (Array.isArray(event)) {
        event.forEach((e) => this._handleRawDbEvent(e as PendingEvent))
      } else {
        this._handleRawDbEvent(event as PendingEvent)
      }
    })
    this.pgClient.table('user_profiles', { schema: 'public' }).on('*', (event: any) => {
      console.log('ding')
      if (Array.isArray(event)) {
        event.forEach((e) => this._handleRawDbEvent(e as PendingEvent))
      } else {
        this._handleRawDbEvent(event as PendingEvent)
      }
    })
  }

  private _handleRawDbEvent(event: PendingEvent): void {
    // ... logic to extract userId and create updatePayload ...
    let userId: string | undefined
    console.log('_handleRawDbEvent')
    // Extract userId based on event.table
    switch (event.table) {
      case 'transactions':
        userId = event.primaryKeyData?.id ?? event.data?.id
        break
      case 'user_profiles':
        userId = event.data?.userId ?? event.primaryKeyData?.userId
        break
      default:
        console.warn(`[RealtimeService] No userId extraction logic for table: ${event.table}`)
        return
    }

    if (!userId) {
      console.warn(`[RealtimeService] Could not determine userId for event:`, event)
      return
    }
    const columnNamesChanged = event?.columnNamesChanged?.filter(function (item) {
      return item !== 'updatedAt'
    })
    if (
      columnNamesChanged !== undefined &&
      columnNamesChanged.length < 2 &&
      columnNamesChanged?.includes('balance')
    ) {
      this.updateUserBalanceAndNotify(userId, event.data?.balance ?? 0)
    } else {
      const updatePayload = {
        table: event.table,
        operation: event.operation,
        recordId: event.primaryKeyData?.id ?? event.data?.id ?? 'unknown',
        data: event.data,
        columnNamesChanged,
      }
      // let message: any;

      // const message = updatePayload;

      this.publishDbUpdate(userId, updatePayload)
    }
  }
  async updateUserBalanceAndNotify(userId: string, newBalance: number, currency: string = 'FUN') {
    // ... (your logic to update balance in the database) ...

    const payload: UserBalanceUpdatePayloadType = {
      userId,
      newBalance,
      // currency,
    }

    // Construct the full message object according to the schema
    const message = {
      type: UserBalanceUpdateMessageSchema.shape.type.value, // 'USER_BALANCE_UPDATE'
      payload,
      meta: { timestamp: Date.now() }, // Add other meta fields as needed
    }

    // Publish to the user-specific topic
    // The server instance should be accessible here.
    // server.publish(`user_${userId}_updates`, JSON.stringify(message));
    const userTopic = `user_${userId}_updates`

    const messageType = 'USER_BALANCE_UPDATE'
    validateAndPublish(this.server, userTopic, DatabaseUpdate, messageType, payload, {
      timestamp: Date.now(),
    })
    console.log(`Sent USER_BALANCE_UPDATE to user ${userId}`)
  }
  private publishDbUpdate(
    userId: string,
    payload: any //z.infer<typeof DatabaseUpdate.shape>
  ): void {
    if (!this.isServerSet) {
      console.error(
        `[RealtimeService] Cannot publish update for user ${userId}: Server instance not set.`
      )
      return
    }

    const userTopic = `user_${userId}_updates`
    try {
      const messageType = 'DATABASE_UPDATE'
      validateAndPublish(this.server, userTopic, DatabaseUpdate, messageType, payload, {
        timestamp: Date.now(),
      })
      //  (validatedMessage) => {
      //   this.server.publish(userTopic, JSON.stringify(validatedMessage));
      // });
    } catch (error) {
      console.error(`[RealtimeService] Error publishing to topic "${userTopic}":`, error)
    }
  }

  public async stopListening(): Promise<void> {
    console.log('[RealtimeService] Stopping database listeners...')
    try {
      // pg-listen v9 doesn't require explicit subscriber closing like older versions might have.
      // Closing the pool should handle underlying connections. Check pg-listen docs if issues arise.
      if (this.pgClient?.pool) {
        await this.pgClient.pool.end() // Close the database connection pool
      }
      console.log('[RealtimeService] Listeners stopped.')
    } catch (error) {
      console.error('[RealtimeService] Error stopping listeners:', error)
    }
  }
}
