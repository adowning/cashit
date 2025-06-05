import type { PrismaTransactionStatus, PrismaTransactionType } from './prisma';
export interface TransactionHistoryItem {
    id: string;
    created_at: number;
    status: string;
    type: number;
    note: string;
    amount: number;
    balance: number;
}
export interface TransactionHistoryResponse {
    total_pages: number;
    record: Array<TransactionHistoryItem>;
}
export type GetTransactionHistoryResponse = {
    code: number;
    data: TransactionHistoryResponse;
    message: string;
};
export interface TransactionHistoryEntry {
    id: string;
    date: string | Date;
    type: PrismaTransactionType;
    status: PrismaTransactionStatus;
    amount: number;
    currencyId: string;
    description?: string | null;
    provider?: string | null;
    providerTxId?: string | null;
}
export interface InitializeDepositDto {
    amount: number;
    currencyId: string;
    paymentMethodId: string;
    productId?: string;
}
export interface DepositProduct {
    id: string;
    title: string;
    description?: string | null;
    priceInCents: number;
    iconUrl?: string | null;
    bonusSpins?: number;
    amountToReceiveInCredits?: number;
}
export interface DepositPaymentMethod {
    id: string;
    name: string;
    iconUrl?: string | null;
    minAmount: number;
    maxAmount: number;
    currencyId: string;
}
export interface DepositConfigurationResponse {
    methods: DepositPaymentMethod[];
    limits: {
        dailyLimit?: number;
        weeklyLimit?: number;
    };
}
export interface InitializeDepositResponse {
    transactionId: string;
    paymentReference?: string;
    paymentUrl?: string;
    providerData?: any;
    message?: string;
}
export interface CashAppWebhookPayload {
    transactionId: string;
    amount: number;
    senderName?: string;
    timestamp: string;
    rawEmailSubject?: string;
    cashtag?: string;
    note?: string;
}
export interface WithdrawalConfig {
    methods: Array<{
        id: string;
        name: string;
        currencyId: string;
        minAmount: number;
        maxAmount: number;
        feeFixed?: number;
        feePercent?: number;
        processingTime?: string;
        requiredFields?: Array<{
            name: string;
            label: string;
            type: string;
            validationRegex?: string;
        }>;
    }>;
    dailyWithdrawalLimit?: number;
    weeklyWithdrawalLimit?: number;
}
export interface WithdrawalRequestDto {
    amount: number;
    currencyId: string;
    paymentMethodId: string;
    recipientDetails: Record<string, any>;
}
export interface WithdrawalResponse {
    transactionId: string;
    status: PrismaTransactionStatus;
    message: string;
}
//# sourceMappingURL=transaction.d.ts.map