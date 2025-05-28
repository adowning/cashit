"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AUTH_EVENT_IDENTIFIERS = void 0;
// Recommended to be in shared/dist, e.g., in a new auth.socket.interfaces.ts
exports.AUTH_EVENT_IDENTIFIERS = {
    STATE_CHANGE: 'auth:state_change', // Server sends this when auth state (login/logout) changes
    USER_UPDATED: 'auth:user_updated', // Server sends this when the ClientAuthUser details change
    PROFILE_UPDATED: 'auth:profile_updated', // Server sends this when ProfileData changes
    // Add any other auth-related identifiers your server might emit
}; // Use 'as const' for stricter typing on values
