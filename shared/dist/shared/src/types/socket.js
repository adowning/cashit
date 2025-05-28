"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.GenericWsResponse = exports.GenericWsResponsePayload = exports.UnsubscribeFromGeneralTournaments = exports.SubscribeToGeneralTournaments = exports.UnsubscribeFromTournamentTopic = exports.UnsubscribeFromTournamentTopicPayload = exports.SubscribeToTournamentTopic = exports.SubscribeToTournamentTopicPayload = exports.TournamentNotificationEvent = exports.TournamentParticipantJoinedEvent = exports.TournamentEndedEvent = exports.TournamentStartedEvent = exports.TournamentLeaderboardUpdateEvent = exports.ErrorMessage = exports.ErrorCode = exports.MessageSchema = exports.DatabaseUpdate = exports.SubscribeResponse = exports.Subscribe = exports.Pong = exports.Ping = exports.NewMessage = exports.RoomList = exports.SendMessage = exports.UserLeft = exports.UserJoined = exports.JoinRoom = exports.MessageMetadataSchema = void 0;
exports.messageSchema = messageSchema;
const zod_1 = require("zod");
/* SPDX-FileCopyrightText: 2025-present Kriasoft */
/* SPDX-License-Identifier: MIT */
// import type { messageSchema } from './router'
/**
 * Base schema for message metadata.
 * Provides common fields that are available on all messages.
 * Can be extended for specific message types.
 */
exports.MessageMetadataSchema = zod_1.z.object({
    clientId: zod_1.z.string().optional(),
    timestamp: zod_1.z.number().int().positive().optional(),
    corelationId: zod_1.z.string().optional(),
});
exports.JoinRoom = messageSchema('JOIN_ROOM', {
    roomId: zod_1.z.string(),
});
exports.UserJoined = messageSchema('USER_JOINED', {
    roomId: zod_1.z.string(),
    userId: zod_1.z.string().optional(),
});
exports.UserLeft = messageSchema('USER_LEFT', {
    roomId: zod_1.z.string(),
    userId: zod_1.z.string(),
});
exports.SendMessage = messageSchema('SEND_MESSAGE', {
    roomId: zod_1.z.string(),
    text: zod_1.z.string(),
});
exports.RoomList = messageSchema('ROOM_LIST', {
    roomId: zod_1.z.string(),
});
exports.NewMessage = messageSchema('NEW_MESSAGE', {
    roomId: zod_1.z.string(),
    userId: zod_1.z.string(),
    text: zod_1.z.string(),
    timestamp: zod_1.z.number().optional(),
});
exports.Ping = messageSchema('PING', {
// userId: z.string(),
// content: z.string(),
// timestamp: z.number().optional(),
});
exports.Pong = messageSchema('PONG', {
// userId: z.string(),
// content: z.string(),
// timestamp: z.number().optional(),
});
exports.Subscribe = messageSchema('SUBSCRIBE', {
    userId: zod_1.z.string(),
    tableName: zod_1.z.string(),
    // timestamp: z.number().optional(),
});
exports.SubscribeResponse = messageSchema('PONG', {
    userId: zod_1.z.string(),
    status: zod_1.z.boolean(),
    // timestamp: z.number().optional(),
});
// Example schema for database updates pushed to clients
// export const DatabaseUpdate = messageSchema(
//   "DATABASE_UPDATE",
//   z.object({
//     table: z.string(),
//     operation: z.enum(["INSERT", "UPDATE", "DELETE"]),
//     recordId: z.union([z.string(), z.number(), z.null()]).optional(), // Allow string/number/null IDs
//     data: z.record(z.any()).nullable(), // The row data (can be null on DELETE)
//     // changedColumns: z.array(z.string()).optional(), // Optional: if needed by client
//   })
// );
exports.DatabaseUpdate = zod_1.z.object({
    table: zod_1.z.string(),
    operation: zod_1.z.enum(['INSERT', 'UPDATE', 'DELETE']),
    recordId: zod_1.z.union([zod_1.z.string(), zod_1.z.number(), zod_1.z.null()]).optional(), // Allow string/number/null IDs
    data: zod_1.z.record(zod_1.z.any()).nullable(), // The row data (can be null on DELETE))
});
/**
 * Base message schema that all specific message types extend.
 * Defines the minimum structure required for routing.
 */
exports.MessageSchema = zod_1.z.object({
    type: zod_1.z.string(),
    meta: exports.MessageMetadataSchema,
});
/**
 * Standard error codes for WebSocket communication.
 * Used in ErrorMessage payloads for consistent error handling.
 */
exports.ErrorCode = zod_1.z.enum([
    'INVALID_MESSAGE_FORMAT', // Message isn't valid JSON or lacks required structure
    'VALIDATION_FAILED', // Message failed schema validation
    'UNSUPPORTED_MESSAGE_TYPE', // No handler registered for this message type
    'AUTHENTICATION_FAILED', // Client isn't authenticated or has invalid credentials
    'AUTHORIZATION_FAILED', // Client lacks permission for the requested action
    'RESOURCE_NOT_FOUND', // Requested resource (user, room, etc.) doesn't exist
    'RATE_LIMIT_EXCEEDED', // Client is sending messages too frequently
    'INTERNAL_SERVER_ERROR', // Unexpected server error occurred
]);
/**
 * Standard error message schema for consistent error responses.
 */
exports.ErrorMessage = messageSchema('ERROR', {
    code: exports.ErrorCode,
    message: zod_1.z.string().optional(),
    context: zod_1.z.record(zod_1.z.any()).optional(),
});
// -----------------------------------------------------------------------
// Implementation
// -----------------------------------------------------------------------
/**
 * Creates a type-safe WebSocket message schema.
 *
 * The schema includes:
 * - A literal type field for routing messages
 * - Metadata for tracking client info and message context
 * - Optional payload for the message data
 *
 * Types are fully inferred for use with WebSocketRouter handlers.
 */
function messageSchema(messageType, payload, meta) {
    // Always use .extend() to avoid union types in meta
    const baseMetaSchema = exports.MessageMetadataSchema.extend(meta ? meta.shape : {});
    const baseSchema = zod_1.z.object({
        type: zod_1.z.literal(messageType),
        meta: baseMetaSchema,
    });
    // If no payload schema provided, return without payload
    if (payload === undefined) {
        return baseSchema;
    }
    const payloadSchema = payload instanceof zod_1.z.ZodType ? payload : zod_1.z.object(payload);
    // Add payload to schema
    const finalSchema = baseSchema.extend({
        payload: payloadSchema,
    });
    return finalSchema;
}
exports.TournamentLeaderboardUpdateEvent = zod_1.z.object({
    table: zod_1.z.string(),
    operation: zod_1.z.enum(['INSERT', 'UPDATE', 'DELETE']),
    recordId: zod_1.z.union([zod_1.z.string(), zod_1.z.number(), zod_1.z.null()]).optional(), // Allow string/number/null IDs
    data: zod_1.z.record(zod_1.z.any()).nullable(), // The row data (can be null on DELETE))
});
// New WebSocket Message Schemas for Tournaments
exports.TournamentStartedEvent = messageSchema('TOURNAMENT_STARTED_WS', // WebSocket message type, distinct from AppEvents enum value
zod_1.z.custom() // Use the payload type directly
);
exports.TournamentEndedEvent = messageSchema('TOURNAMENT_ENDED_WS', zod_1.z.custom());
exports.TournamentParticipantJoinedEvent = messageSchema('TOURNAMENT_PARTICIPANT_JOINED_WS', zod_1.z.custom());
// You might also want a generic tournament notification schema
exports.TournamentNotificationEvent = messageSchema('TOURNAMENT_NOTIFICATION_WS', zod_1.z.object({
    tournamentId: zod_1.z.string(),
    title: zod_1.z.string(),
    message: zod_1.z.string(),
    details: zod_1.z.record(zod_1.z.unknown()).optional(), // For any extra data
}));
// New Schemas for Client-to-Server Tournament Topic Subscription Messages
exports.SubscribeToTournamentTopicPayload = zod_1.z.object({
    tournamentId: zod_1.z.string().cuid(), // Specific tournament ID
    topicType: zod_1.z.enum(['updates', 'leaderboard']), // Type of updates to subscribe to for that tournament
});
exports.SubscribeToTournamentTopic = messageSchema('SUBSCRIBE_TOURNAMENT_TOPIC', // Message type from client
exports.SubscribeToTournamentTopicPayload);
exports.UnsubscribeFromTournamentTopicPayload = zod_1.z.object({
    tournamentId: zod_1.z.string().cuid(),
    topicType: zod_1.z.enum(['updates', 'leaderboard']),
});
exports.UnsubscribeFromTournamentTopic = messageSchema('UNSUBSCRIBE_FROM_TOURNAMENT_TOPIC', // Message type from client
exports.UnsubscribeFromTournamentTopicPayload);
// Schema for subscribing to general tournament announcements (optional)
exports.SubscribeToGeneralTournaments = messageSchema('SUBSCRIBE_TO_GENERAL_TOURNAMENTS');
exports.UnsubscribeFromGeneralTournaments = messageSchema('UNSUBSCRIBE_FROM_GENERAL_TOURNAMENTS');
// It's also good to have a generic success/error response schema for client requests
exports.GenericWsResponsePayload = zod_1.z.object({
    success: zod_1.z.boolean(),
    message: zod_1.z.string().optional(),
    details: zod_1.z.record(zod_1.z.unknown()).optional(),
});
exports.GenericWsResponse = messageSchema('GENERIC_WS_RESPONSE', exports.GenericWsResponsePayload);
