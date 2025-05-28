export interface GetCurrencyBalanceList {
    amount: string;
    availabe_balance: string;
    real: string;
    bonus: string;
    currency: string;
}
export interface GetCurrencyBalanceListResponse {
    code: number;
    data: Array<GetCurrencyBalanceList>;
    message: string;
} /**
 * Represents a Currency. Based on the Prisma 'Currency' model.
 */
export type CurrencyType = 'FIAT' | 'CRYPTO' | 'VIRTUAL';
export interface CurrencyInfo {
    id: string;
    name: string;
    symbol: string;
    type: CurrencyType;
    precision: number;
    iconUrl?: string;
    isActive: boolean;
}
export interface UserWallet {
    currencyId: string;
    name: string;
    symbol: string;
    balance: number;
    bonusBalance: number;
    lockedBalance: number;
    type: CurrencyType;
    precision: number;
    iconUrl?: string;
}
