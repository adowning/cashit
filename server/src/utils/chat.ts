import type { ServerWebSocket } from 'bun'
import type { MessageHandlerContext, JoinRoom, SendMessage } from '@/types'

interface AppWebSocketData {
  clientId: string;
  // Add other WebSocket data properties here if needed
}

export interface ChatRoom {
  id: string
  name: string
  users: Set<string>
}

export class ChatManager {
  private rooms: Map<string, ChatRoom> = new Map()

  joinRoom(ws: ServerWebSocket<AppWebSocketData>, roomId: string): boolean {
    const room = this.rooms.get(roomId) || {
      id: roomId,
      name: `Room ${roomId}`,
      users: new Set<string>(),
    }

    const clientId = ws.data?.clientId;
    if (!clientId) {
      console.warn('WebSocket missing clientId');
      return false;
    }

    if (!room.users.has(clientId)) {
      room.users.add(clientId);
      this.rooms.set(roomId, room);
      return true;
    }
    return false;
  }

  leaveRoom(ws: ServerWebSocket<AppWebSocketData>, roomId: string): boolean {
    const room = this.rooms.get(roomId);
    if (!room) return false;

    const clientId = ws.data?.clientId;
    if (!clientId || !room.users.has(clientId)) return false;

    room.users.delete(clientId);
    if (room.users.size === 0) {
      this.rooms.delete(roomId);
    }
    return true;
  }

  broadcastMessage(roomId: string, message: unknown): void {
    const room = this.rooms.get(roomId);
    if (!room) return;

    // Clone the users set to avoid modification during iteration
    const users = new Set(room.users);
    
    users.forEach(userId => {
      // Here you would typically implement the actual message broadcasting logic
      // For example, sending the message to each user's WebSocket connection
      console.log(`Broadcasting to user ${userId}:`, message);
      // wsServer.sendToUser(userId, message);
    });
  }
}

export function handleJoinRoom(context: MessageHandlerContext<typeof JoinRoom>): void {
  const { ws, payload } = context;
  const chatManager = new ChatManager();
  const success = chatManager.joinRoom(ws as ServerWebSocket<AppWebSocketData>, payload.roomId);
  
  if (success) {
    // Send success response
    ws.send(JSON.stringify({ 
      type: 'JOIN_ROOM_SUCCESS', 
      roomId: payload.roomId 
    }));
  } else {
    ws.send(JSON.stringify({
      type: 'JOIN_ROOM_ERROR',
      message: 'Failed to join room',
      roomId: payload.roomId
    }));
  }
}

export function handleSendMessage(context: MessageHandlerContext<typeof SendMessage>): void {
  const { ws, payload } = context;
  const chatManager = new ChatManager();
  
  // Validate message content
  if (!payload.text || typeof payload.text !== 'string') {
    ws.send(JSON.stringify({
      type: 'MESSAGE_ERROR',
      message: 'Invalid message format: text is required and must be a string',
      roomId: payload.roomId
    }));
    return;
  }
  
  // Create a properly formatted message object
  const message = {
    type: 'text',
    content: payload.text,
    timestamp: Date.now(),
    roomId: payload.roomId
  };
  
  // Broadcast the message to the room
  chatManager.broadcastMessage(payload.roomId, message);
  
  // Acknowledge message was sent
  ws.send(JSON.stringify({
    type: 'MESSAGE_SENT',
    roomId: payload.roomId,
    messageId: Date.now().toString()
  }));
}
