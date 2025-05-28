export interface UserEventPayload {
    userId: string;
    timestamp?: string | Date;
}
export interface UserXpGainedEventPayload extends UserEventPayload {
    pointsGained: number;
    source: string;
    sourceId?: string;
    newTotalXp: number;
    currentLevel: number;
    xpInLevel: number;
    xpForNextLevel: number;
    xpEventId: string;
}
export interface UserLeveledUpEventPayload extends UserEventPayload {
    previousLevel: number;
    newLevel: number;
    newLevelTitle: string;
    totalXp: number;
}
export interface TransactionStatusChangedEventPayload extends UserEventPayload {
    transactionId: string;
    newStatus: string;
    previousStatus?: string;
    amount?: number;
    currencyId?: string;
    transactionType?: string;
}
export interface DepositSuccessfulEventPayload extends UserEventPayload {
    transactionId: string;
    amount: number;
    currencyId: string;
    paymentProvider?: string;
}
export interface WithdrawalRequestedEventPayload extends UserEventPayload {
    transactionId: string;
    amount: number;
    currencyId: string;
}
export interface WebSocketMessageToUserEventPayload {
    userId: string;
    eventType: string;
    data: any;
}
export interface UserXpGainedPayload extends UserEventPayload {
    pointsGained: number;
    source: string;
    sourceId?: string;
    newTotalXp: number;
    currentLevel: number;
    xpInLevel: number;
    xpForNextLevel: number;
    xpEventId: string;
}
export interface UserLeveledUpPayload extends UserEventPayload {
    previousLevel: number;
    newLevel: number;
    newLevelTitle: string;
    totalXp: number;
    rewardsGranted?: Array<{
        rewardId: string;
        description: string;
        type: string;
    }>;
}
export interface UserCreatedPayload extends UserEventPayload {
    email: string;
    name?: string | null;
}
export interface UserProfileUpdatedPayload extends UserEventPayload {
    updatedFields: string[];
}
export interface TransactionStatusChangedPayload extends UserEventPayload {
    transactionId: string;
    newStatus: string;
    previousStatus?: string;
    amount?: number;
    currencyId?: string;
    transactionType?: string;
}
export interface DepositSuccessfulPayload extends UserEventPayload {
    transactionId: string;
    amount: number;
    currencyId: string;
    paymentProvider?: string;
}
export interface WithdrawalProcessedPayload extends UserEventPayload {
    transactionId: string;
    amount: number;
    currencyId: string;
    paymentProvider?: string;
}
export interface UserRewardClaimedPayload extends UserEventPayload {
    userRewardId: string;
    rewardType: string;
    description: string;
    amount?: number | null;
    currencyId?: string | null;
}
export interface WebSocketMessageToUserPayload {
    userId: string;
    eventType: string;
    data: any;
}
export interface WebSocketBroadcastPayload {
    eventType: string;
    data: any;
    room?: string;
    excludeUserIds?: string[];
}
