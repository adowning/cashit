import type { UserProfile } from '..';
/**
 * Credentials for password-based login and registration.
 * The 'password' field should contain the plain text password sent from the client.
 */
export interface AuthCredentials {
    username: string;
    password: string;
}
/**
 * Payload for user registration.
 * Ensure field names match server's Zod schema for registration.
 */
export interface RegisterPayload extends AuthCredentials {
    username: string;
}
/**
 * Response DTO after successful authentication (login or register).
 */
export interface AuthResponseDto {
    accessToken: string;
    error: string | null;
    refreshToken?: string;
    code: number;
    user: UserProfile;
}
/**
 * DTO for refreshing an access token.
 */
export interface RefreshTokenDto {
    refreshToken: string;
}
/**
 * DTO for signing in with a Google ID Token.
 */
export interface GoogleSignInDto {
    idToken: string;
}
/**
 * Simple state for UI flags.
 */
export interface AuthenticatedState {
    loggedIn: boolean;
}
/**
 * Defines the structure of WebSocket messages related to authentication events.
 * These events would typically push updated user or session information.
 */
export type AuthWebSocketEventType = 'AUTH_STATE_CHANGE' | 'USER_UPDATED' | 'PROFILE_UPDATED';
/**
 * A generic structure for WebSocket messages related to authentication.
 * The payload type should be more specific based on the AuthWebSocketEventType.
 */
export interface AuthWebSocketMessage {
    type: AuthWebSocketEventType;
    payload: any;
}
export interface SignUpPayload {
    email: string;
    password: string;
    username: string;
}
export interface ApiErrorData {
    message: string;
    code?: number | string;
    errors?: Array<{
        field: string;
        message: string;
    }>;
}
export interface ClientRegisterPayload {
    email: string;
    password_hash: string;
    username: string;
}
export interface GoogleSignInResponse {
    authenticated: boolean;
    accessToken: string;
    refreshToken: string;
    code: number;
    user: UserProfile;
}
export interface MappedActiveProfile {
    id: string;
    balance: number;
    xpEarned: number;
    isActive: boolean;
    lastPlayed: Date | null;
    createdAt: Date;
    updatedAt: Date | null;
    phpId: number | null;
    userId: string;
    currency: string;
    shopId: string;
    userProfileUseridtouser: any | null;
}
export interface PatchedVipInfo {
    [x: string]: any;
    gamesession: any[];
    operator: any | null;
    transactions: any[];
    user: any | null;
}
//# sourceMappingURL=auth.interface.d.ts.map