export interface ChatRequestData {
    type: string;
    avatar: string;
    grade: string;
    gradeColor: string;
    gradeBackground: string;
    sender: string;
    receiver: string;
    message: string;
    starLevel: Array<string>;
}
export type MessageType = 'text' | 'image' | 'file';
export interface ChatSession {
    user: any;
    unreadCount: number;
    lastMessage?: {
        content: string;
        createdAt: string;
        type: string;
    };
}
export interface ChatSummary {
    unreadCount: number;
    lastMessage?: {
        type: string;
        content: string;
        createdAt: string;
        isRecalled: boolean;
        id: number;
        fromUserId: number;
        toUserId: number;
        isRead: boolean;
        fileUrl?: string;
        fileName?: string;
    };
}
export interface ChatSummaryMap {
    [userId: number]: ChatSummary;
}
export interface ChatMessagePayload {
    type?: string;
    content: string;
    roomId?: string;
    userId?: string;
    username?: string;
    timestamp?: string;
}
