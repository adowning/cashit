export declare const AUTH_EVENT_IDENTIFIERS: {
    readonly STATE_CHANGE: "auth:state_change";
    readonly USER_UPDATED: "auth:user_updated";
    readonly PROFILE_UPDATED: "auth:profile_updated";
};
export interface DecodedAuthWebSocketMessage<T = any> {
    identifier: (typeof AUTH_EVENT_IDENTIFIERS)[keyof typeof AUTH_EVENT_IDENTIFIERS];
    payload: T;
}
export interface WSMessage {
    identifier: string;
    message: any[] | any | null;
    callbackId: string | null;
}
//# sourceMappingURL=auth.socket-interface.d.ts.map