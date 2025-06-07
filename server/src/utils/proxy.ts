import type { ServerWebSocket } from 'bun'

// Type for the WebSocket message event
type WebSocketMessageEvent = {
  data: string | Buffer | ArrayBuffer | Uint8Array
}

// WebSocket ready state constants
const WS_READY_STATE = {
  CONNECTING: 0,
  OPEN: 1,
  CLOSING: 2,
  CLOSED: 3
} as const

export interface ProxyConfig {
  gameId?: string
  gameCode?: string
  sessionKey?: string
  messageCounter?: number
  rememberedData?: any
}

export interface ProxyData {
  remoteWs: WebSocket | null
  sessionKey: string | null
  messageCounter: number
  rememberedData: any
}

export abstract class ProxyHandler {
  protected abstract getRemoteWs(): WebSocket | null
  protected abstract getSessionKey(): string | null
  protected abstract getData(): ProxyData

  public handleMessage(_ws: ServerWebSocket, message: string | Buffer): void {
    const { remoteWs, sessionKey } = this.getData()

    if (!remoteWs || !sessionKey) {
      console.warn(`[Proxy] Not initialized. Ignoring message.`)
      return
    }

    if (remoteWs.readyState === WS_READY_STATE.OPEN) {
      remoteWs.send(message)
    } else {
      console.warn(`[Proxy] Remote WS not open. Cannot forward message.`)
    }
  }

  public handleRemoteMessage(ws: ServerWebSocket, event: WebSocketMessageEvent): void {
    if (ws.readyState !== WS_READY_STATE.OPEN) return

    // Forward the raw message data
    ws.send(event.data as Bun.BufferSource)
  }

  protected decryptMessage(message: string, _sessionKey: string): string {
    // Implement decryption logic here
    return message
  }
  
  // Add a method to update the session key if needed
  public updateSessionKey(newKey: string | null): void {
    if (this instanceof ConcreteProxyHandler) {
      this.setSessionKey(newKey);
    }
  }

  protected encryptMessage(message: string, _sessionKey: string): string {
    // Implement encryption logic here
    return message
  }
}

export class ConcreteProxyHandler extends ProxyHandler {
  private _remoteWs: WebSocket | null = null;
  private _sessionKey: string | null = null;
  private _messageCounter: number = 0;
  private _rememberedData: any = {};

  constructor(config: ProxyConfig) {
    super();
    this._messageCounter = config.messageCounter || 0;
    this._rememberedData = config.rememberedData || {};
    this._sessionKey = config.sessionKey || null;
  }

  protected getRemoteWs(): WebSocket | null {
    return this._remoteWs;
  }

  protected getSessionKey(): string | null {
    return this._sessionKey;
  }

  protected getData(): ProxyData {
    return {
      remoteWs: this._remoteWs,
      sessionKey: this._sessionKey,
      messageCounter: this._messageCounter,
      rememberedData: this._rememberedData,
    };
  }

  // Additional methods to update internal state if needed
  public setRemoteWs(ws: WebSocket | null): void {
    this._remoteWs = ws;
  }

  public setSessionKey(key: string | null): void {
    this._sessionKey = key;
  }
}

export function createProxyHandler(config: ProxyConfig): ConcreteProxyHandler {
  return new ConcreteProxyHandler(config);
}
