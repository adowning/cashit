export interface GetUserBalanceSocket {
    bal: string | number;
    cur: string;
    mt: number;
}
import type { HeadersInit, Server, ServerWebSocket } from 'bun';
import { z, ZodObject, ZodLiteral, type ZodRawShape, type ZodTypeAny } from 'zod';
import type { TournamentEndedPayload, TournamentParticipantJoinedPayload, TournamentStartedPayload } from './tournament';
/**
 * Base schema for message metadata.
 * Provides common fields that are available on all messages.
 * Can be extended for specific message types.
 */
export declare const MessageMetadataSchema: z.ZodObject<{
    clientId: z.ZodOptional<z.ZodString>;
    timestamp: z.ZodOptional<z.ZodNumber>;
    corelationId: z.ZodOptional<z.ZodString>;
}, "strip", z.ZodTypeAny, {
    clientId?: string | undefined;
    timestamp?: number | undefined;
    corelationId?: string | undefined;
}, {
    clientId?: string | undefined;
    timestamp?: number | undefined;
    corelationId?: string | undefined;
}>;
export declare const JoinRoom: PayloadMessageSchema<"JOIN_ROOM", z.ZodObject<{
    roomId: z.ZodString;
}, z.UnknownKeysParam, z.ZodTypeAny, {
    roomId: string;
}, {
    roomId: string;
}>>;
export declare const UserJoined: PayloadMessageSchema<"USER_JOINED", z.ZodObject<{
    roomId: z.ZodString;
    userId: z.ZodOptional<z.ZodString>;
}, z.UnknownKeysParam, z.ZodTypeAny, {
    roomId: string;
    userId?: string | undefined;
}, {
    roomId: string;
    userId?: string | undefined;
}>>;
export declare const UserLeft: PayloadMessageSchema<"USER_LEFT", z.ZodObject<{
    roomId: z.ZodString;
    userId: z.ZodString;
}, z.UnknownKeysParam, z.ZodTypeAny, {
    userId: string;
    roomId: string;
}, {
    userId: string;
    roomId: string;
}>>;
export declare const SendMessage: PayloadMessageSchema<"SEND_MESSAGE", z.ZodObject<{
    roomId: z.ZodString;
    text: z.ZodString;
}, z.UnknownKeysParam, z.ZodTypeAny, {
    text: string;
    roomId: string;
}, {
    text: string;
    roomId: string;
}>>;
export declare const RoomList: PayloadMessageSchema<"ROOM_LIST", z.ZodObject<{
    roomId: z.ZodString;
}, z.UnknownKeysParam, z.ZodTypeAny, {
    roomId: string;
}, {
    roomId: string;
}>>;
export declare const NewMessage: PayloadMessageSchema<"NEW_MESSAGE", z.ZodObject<{
    roomId: z.ZodString;
    userId: z.ZodString;
    text: z.ZodString;
    timestamp: z.ZodOptional<z.ZodNumber>;
}, z.UnknownKeysParam, z.ZodTypeAny, {
    userId: string;
    text: string;
    roomId: string;
    timestamp?: number | undefined;
}, {
    userId: string;
    text: string;
    roomId: string;
    timestamp?: number | undefined;
}>>;
export declare const Ping: PayloadMessageSchema<"PING", z.ZodObject<{}, z.UnknownKeysParam, z.ZodTypeAny, {}, {}>>;
export declare const Pong: PayloadMessageSchema<"PONG", z.ZodObject<{}, z.UnknownKeysParam, z.ZodTypeAny, {}, {}>>;
export declare const Subscribe: PayloadMessageSchema<"SUBSCRIBE", z.ZodObject<{
    userId: z.ZodString;
    tableName: z.ZodString;
}, z.UnknownKeysParam, z.ZodTypeAny, {
    userId: string;
    tableName: string;
}, {
    userId: string;
    tableName: string;
}>>;
export declare const SubscribeResponse: PayloadMessageSchema<"PONG", z.ZodObject<{
    userId: z.ZodString;
    status: z.ZodBoolean;
}, z.UnknownKeysParam, z.ZodTypeAny, {
    userId: string;
    status: boolean;
}, {
    userId: string;
    status: boolean;
}>>;
export declare const DatabaseUpdate: z.ZodObject<{
    table: z.ZodString;
    operation: z.ZodEnum<["INSERT", "UPDATE", "DELETE"]>;
    recordId: z.ZodOptional<z.ZodUnion<[z.ZodString, z.ZodNumber, z.ZodNull]>>;
    data: z.ZodNullable<z.ZodRecord<z.ZodString, z.ZodAny>>;
}, "strip", z.ZodTypeAny, {
    table: string;
    operation: "INSERT" | "UPDATE" | "DELETE";
    data: Record<string, any> | null;
    recordId?: string | number | null | undefined;
}, {
    table: string;
    operation: "INSERT" | "UPDATE" | "DELETE";
    data: Record<string, any> | null;
    recordId?: string | number | null | undefined;
}>;
/**
 * Base message schema that all specific message types extend.
 * Defines the minimum structure required for routing.
 */
export declare const MessageSchema: z.ZodObject<{
    type: z.ZodString;
    meta: z.ZodObject<{
        clientId: z.ZodOptional<z.ZodString>;
        timestamp: z.ZodOptional<z.ZodNumber>;
        corelationId: z.ZodOptional<z.ZodString>;
    }, "strip", z.ZodTypeAny, {
        clientId?: string | undefined;
        timestamp?: number | undefined;
        corelationId?: string | undefined;
    }, {
        clientId?: string | undefined;
        timestamp?: number | undefined;
        corelationId?: string | undefined;
    }>;
}, "strip", z.ZodTypeAny, {
    type: string;
    meta: {
        clientId?: string | undefined;
        timestamp?: number | undefined;
        corelationId?: string | undefined;
    };
}, {
    type: string;
    meta: {
        clientId?: string | undefined;
        timestamp?: number | undefined;
        corelationId?: string | undefined;
    };
}>;
/**
 * Standard error codes for WebSocket communication.
 * Used in ErrorMessage payloads for consistent error handling.
 */
export declare const ErrorCode: z.ZodEnum<["INVALID_MESSAGE_FORMAT", "VALIDATION_FAILED", "UNSUPPORTED_MESSAGE_TYPE", "AUTHENTICATION_FAILED", "AUTHORIZATION_FAILED", "RESOURCE_NOT_FOUND", "RATE_LIMIT_EXCEEDED", "INTERNAL_SERVER_ERROR"]>;
export type ErrorCode = z.infer<typeof ErrorCode>;
/**
 * Standard error message schema for consistent error responses.
 */
export declare const ErrorMessage: PayloadMessageSchema<"ERROR", z.ZodObject<{
    code: z.ZodEnum<["INVALID_MESSAGE_FORMAT", "VALIDATION_FAILED", "UNSUPPORTED_MESSAGE_TYPE", "AUTHENTICATION_FAILED", "AUTHORIZATION_FAILED", "RESOURCE_NOT_FOUND", "RATE_LIMIT_EXCEEDED", "INTERNAL_SERVER_ERROR"]>;
    message: z.ZodOptional<z.ZodString>;
    context: z.ZodOptional<z.ZodRecord<z.ZodString, z.ZodAny>>;
}, z.UnknownKeysParam, z.ZodTypeAny, {
    code: "INVALID_MESSAGE_FORMAT" | "VALIDATION_FAILED" | "UNSUPPORTED_MESSAGE_TYPE" | "AUTHENTICATION_FAILED" | "AUTHORIZATION_FAILED" | "RESOURCE_NOT_FOUND" | "RATE_LIMIT_EXCEEDED" | "INTERNAL_SERVER_ERROR";
    message?: string | undefined;
    context?: Record<string, any> | undefined;
}, {
    code: "INVALID_MESSAGE_FORMAT" | "VALIDATION_FAILED" | "UNSUPPORTED_MESSAGE_TYPE" | "AUTHENTICATION_FAILED" | "AUTHORIZATION_FAILED" | "RESOURCE_NOT_FOUND" | "RATE_LIMIT_EXCEEDED" | "INTERNAL_SERVER_ERROR";
    message?: string | undefined;
    context?: Record<string, any> | undefined;
}>>;
/**
 * Schema type for messages without a payload
 */
export type BaseMessageSchema<T extends string> = ZodObject<{
    type: ZodLiteral<T>;
    meta: typeof MessageMetadataSchema;
}>;
/**
 * Schema type for messages with a payload
 */
export type PayloadMessageSchema<T extends string, P extends ZodTypeAny> = ZodObject<{
    type: ZodLiteral<T>;
    meta: typeof MessageMetadataSchema;
    payload: P;
}>;
/**
 * Schema type for messages with custom metadata
 */
export type MessageSchemaWithCustomMeta<T extends string, M extends ZodRawShape> = ZodObject<{
    type: ZodLiteral<T>;
    meta: ZodObject<typeof MessageMetadataSchema.shape & M>;
}>;
/**
 * Schema type for messages with both payload and custom metadata
 */
export type PayloadMessageSchemaWithCustomMeta<T extends string, P extends ZodTypeAny, M extends ZodRawShape> = ZodObject<{
    type: ZodLiteral<T>;
    meta: ZodObject<typeof MessageMetadataSchema.shape & M>;
    payload: P;
}>;
/**
 * Creates a basic message schema with just type and standard metadata
 */
export declare function messageSchema<T extends string>(messageType: T): BaseMessageSchema<T>;
/**
 * Creates a message schema with a payload defined as an object
 */
export declare function messageSchema<T extends string, P extends Record<string, ZodTypeAny>>(messageType: T, payload: P): PayloadMessageSchema<T, ZodObject<P>>;
/**
 * Creates a message schema with a payload defined as a ZodType
 */
export declare function messageSchema<T extends string, P extends ZodTypeAny>(messageType: T, payload: P): PayloadMessageSchema<T, P>;
/**
 * Creates a message schema with custom metadata
 */
export declare function messageSchema<T extends string, M extends ZodRawShape>(messageType: T, payload: undefined, meta: ZodObject<M>): MessageSchemaWithCustomMeta<T, M>;
/**
 * Creates a message schema with an object payload and custom metadata
 */
export declare function messageSchema<T extends string, P extends Record<string, ZodTypeAny>, M extends ZodRawShape>(messageType: T, payload: P, meta: ZodObject<M>): PayloadMessageSchemaWithCustomMeta<T, ZodObject<P>, M>;
/**
 * Creates a message schema with a ZodType payload and custom metadata
 */
export declare function messageSchema<T extends string, P extends ZodTypeAny, M extends ZodRawShape>(messageType: T, payload: P, meta: ZodObject<M>): PayloadMessageSchemaWithCustomMeta<T, P, M>;
export declare const TournamentLeaderboardUpdateEvent: z.ZodObject<{
    table: z.ZodString;
    operation: z.ZodEnum<["INSERT", "UPDATE", "DELETE"]>;
    recordId: z.ZodOptional<z.ZodUnion<[z.ZodString, z.ZodNumber, z.ZodNull]>>;
    data: z.ZodNullable<z.ZodRecord<z.ZodString, z.ZodAny>>;
}, "strip", z.ZodTypeAny, {
    table: string;
    operation: "INSERT" | "UPDATE" | "DELETE";
    data: Record<string, any> | null;
    recordId?: string | number | null | undefined;
}, {
    table: string;
    operation: "INSERT" | "UPDATE" | "DELETE";
    data: Record<string, any> | null;
    recordId?: string | number | null | undefined;
}>;
export declare const TournamentStartedEvent: PayloadMessageSchema<"TOURNAMENT_STARTED_WS", z.ZodType<TournamentStartedPayload, z.ZodTypeDef, TournamentStartedPayload>>;
export declare const TournamentEndedEvent: PayloadMessageSchema<"TOURNAMENT_ENDED_WS", z.ZodType<TournamentEndedPayload, z.ZodTypeDef, TournamentEndedPayload>>;
export declare const TournamentParticipantJoinedEvent: PayloadMessageSchema<"TOURNAMENT_PARTICIPANT_JOINED_WS", z.ZodType<TournamentParticipantJoinedPayload, z.ZodTypeDef, TournamentParticipantJoinedPayload>>;
export declare const TournamentNotificationEvent: PayloadMessageSchema<"TOURNAMENT_NOTIFICATION_WS", z.ZodObject<{
    tournamentId: z.ZodString;
    title: z.ZodString;
    message: z.ZodString;
    details: z.ZodOptional<z.ZodRecord<z.ZodString, z.ZodUnknown>>;
}, "strip", z.ZodTypeAny, {
    message: string;
    tournamentId: string;
    title: string;
    details?: Record<string, unknown> | undefined;
}, {
    message: string;
    tournamentId: string;
    title: string;
    details?: Record<string, unknown> | undefined;
}>>;
export declare const SubscribeToTournamentTopicPayload: z.ZodObject<{
    tournamentId: z.ZodString;
    topicType: z.ZodEnum<["updates", "leaderboard"]>;
}, "strip", z.ZodTypeAny, {
    tournamentId: string;
    topicType: "updates" | "leaderboard";
}, {
    tournamentId: string;
    topicType: "updates" | "leaderboard";
}>;
export declare const SubscribeToTournamentTopic: PayloadMessageSchema<"SUBSCRIBE_TOURNAMENT_TOPIC", z.ZodObject<{
    tournamentId: z.ZodString;
    topicType: z.ZodEnum<["updates", "leaderboard"]>;
}, "strip", z.ZodTypeAny, {
    tournamentId: string;
    topicType: "updates" | "leaderboard";
}, {
    tournamentId: string;
    topicType: "updates" | "leaderboard";
}>>;
export declare const UnsubscribeFromTournamentTopicPayload: z.ZodObject<{
    tournamentId: z.ZodString;
    topicType: z.ZodEnum<["updates", "leaderboard"]>;
}, "strip", z.ZodTypeAny, {
    tournamentId: string;
    topicType: "updates" | "leaderboard";
}, {
    tournamentId: string;
    topicType: "updates" | "leaderboard";
}>;
export declare const UnsubscribeFromTournamentTopic: PayloadMessageSchema<"UNSUBSCRIBE_FROM_TOURNAMENT_TOPIC", z.ZodObject<{
    tournamentId: z.ZodString;
    topicType: z.ZodEnum<["updates", "leaderboard"]>;
}, "strip", z.ZodTypeAny, {
    tournamentId: string;
    topicType: "updates" | "leaderboard";
}, {
    tournamentId: string;
    topicType: "updates" | "leaderboard";
}>>;
export declare const SubscribeToGeneralTournaments: BaseMessageSchema<"SUBSCRIBE_TO_GENERAL_TOURNAMENTS">;
export declare const UnsubscribeFromGeneralTournaments: BaseMessageSchema<"UNSUBSCRIBE_FROM_GENERAL_TOURNAMENTS">;
export declare const GenericWsResponsePayload: z.ZodObject<{
    success: z.ZodBoolean;
    message: z.ZodOptional<z.ZodString>;
    details: z.ZodOptional<z.ZodRecord<z.ZodString, z.ZodUnknown>>;
}, "strip", z.ZodTypeAny, {
    success: boolean;
    message?: string | undefined;
    details?: Record<string, unknown> | undefined;
}, {
    success: boolean;
    message?: string | undefined;
    details?: Record<string, unknown> | undefined;
}>;
export declare const GenericWsResponse: PayloadMessageSchema<"GENERIC_WS_RESPONSE", z.ZodObject<{
    success: z.ZodBoolean;
    message: z.ZodOptional<z.ZodString>;
    details: z.ZodOptional<z.ZodRecord<z.ZodString, z.ZodUnknown>>;
}, "strip", z.ZodTypeAny, {
    success: boolean;
    message?: string | undefined;
    details?: Record<string, unknown> | undefined;
}, {
    success: boolean;
    message?: string | undefined;
    details?: Record<string, unknown> | undefined;
}>>;
export type MessageHandlerContext<Schema extends MessageSchemaType, Data extends AppWsData = AppWsData> = {
    ws: ServerWebSocket<Data>;
    meta: z.infer<Schema['shape']['meta']>;
    send: SendFunction;
    server: Server;
} & (Schema['shape'] extends {
    payload: infer P;
} ? P extends ZodTypeAny ? {
    payload: z.infer<P>;
} : {} : {});
export interface WsData {
    clientId: string;
    userId?: string;
    key?: string;
    currentRoomId?: string;
    [key: string]: unknown;
}
export type AppWsData = WsData & {
    isNoLimitProxy?: boolean;
    nolimitSessionKey?: string;
    nolimitRemoteWs?: WebSocket;
    nolimitMessageCounter?: number;
    nolimitRememberedData?: {
        extPlayerKey?: string;
    };
    nolimitGameCodeString?: string;
    nolimitClientString?: string;
    nolimitLanguage?: string;
    nolimitToken?: string;
};
export type MessageSchemaType = ZodObject<{
    type: ZodLiteral<string>;
    meta: typeof MessageMetadataSchema;
    payload?: ZodTypeAny;
}>;
export type SendFunction = <Schema extends MessageSchemaType>(schema: Schema, payload: Schema['shape'] extends {
    payload: infer P;
} ? P extends ZodTypeAny ? z.infer<P> : unknown : unknown, meta?: Partial<Omit<z.infer<Schema['shape']['meta']>, 'clientId' | 'timestamp'>>) => void;
export type MessageHandler<Schema extends MessageSchemaType, Data extends AppWsData = AppWsData> = (context: MessageHandlerContext<Schema, Data>) => void | Promise<void>;
export interface OpenHandlerContext<Data extends AppWsData = AppWsData> {
    ws: ServerWebSocket<Data>;
    send: SendFunction;
}
export type OpenHandler<Data extends AppWsData = AppWsData> = (context: OpenHandlerContext<Data>) => void | Promise<void>;
export interface CloseHandlerContext<Data extends AppWsData = AppWsData> {
    ws: ServerWebSocket<Data>;
    code: number;
    reason?: string;
    send: SendFunction;
}
export type CloseHandler<Data extends AppWsData = AppWsData> = (context: CloseHandlerContext<Data>) => void | Promise<void>;
export interface MessageHandlerEntry<Data extends AppWsData = AppWsData> {
    schema: MessageSchemaType;
    handler: MessageHandler<MessageSchemaType, Data>;
}
export interface WebSocketRouterOptions {
    server?: Server;
}
export interface UpgradeRequestOptions<T extends Omit<AppWsData, 'clientId'>> {
    server: Server;
    request: Request;
    data?: T;
    headers?: HeadersInit;
}
