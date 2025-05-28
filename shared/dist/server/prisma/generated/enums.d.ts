/**
* This file exports all enum related types from the schema.
*
* 🟢 You can import this file directly.
*/
export declare const GameCategory: {
    readonly FISH: "FISH";
    readonly POKER: "POKER";
    readonly SLOTS: "SLOTS";
    readonly TABLE_GAMES: "TABLE_GAMES";
    readonly LIVE_CASINO: "LIVE_CASINO";
    readonly SPORTSBOOK: "SPORTSBOOK";
    readonly VIRTUAL_SPORTS: "VIRTUAL_SPORTS";
    readonly LOTTERY: "LOTTERY";
    readonly CRASH: "CRASH";
    readonly OTHER: "OTHER";
};
export type GameCategory = (typeof GameCategory)[keyof typeof GameCategory];
export declare const GameProviderName: {
    readonly PRAGMATICPLAY: "PRAGMATICPLAY";
    readonly EVOPLAY: "EVOPLAY";
    readonly NETENT: "NETENT";
    readonly PLAYNGO: "PLAYNGO";
    readonly RELAXGAMING: "RELAXGAMING";
    readonly HACKSAW: "HACKSAW";
    readonly BGAMING: "BGAMING";
    readonly SPRIBE: "SPRIBE";
    readonly INTERNAL: "INTERNAL";
    readonly REDTIGER: "REDTIGER";
    readonly NETGAME: "NETGAME";
    readonly BIGFISHGAMES: "BIGFISHGAMES";
    readonly CQNINE: "CQNINE";
    readonly NOLIMIT: "NOLIMIT";
    readonly KICKASS: "KICKASS";
};
export type GameProviderName = (typeof GameProviderName)[keyof typeof GameProviderName];
export declare const ProviderAuthType: {
    readonly API_KEY: "API_KEY";
    readonly OAUTH2: "OAUTH2";
    readonly JWT_SIGN: "JWT_SIGN";
    readonly CUSTOM: "CUSTOM";
    readonly NONE: "NONE";
};
export type ProviderAuthType = (typeof ProviderAuthType)[keyof typeof ProviderAuthType];
export declare const PaymentMethod: {
    readonly INSTORE_CASH: "INSTORE_CASH";
    readonly INSTORE_CARD: "INSTORE_CARD";
    readonly CASH_APP: "CASH_APP";
};
export type PaymentMethod = (typeof PaymentMethod)[keyof typeof PaymentMethod];
export declare const Role: {
    readonly USER: "USER";
    readonly ADMIN: "ADMIN";
    readonly VIP: "VIP";
    readonly MODERATOR: "MODERATOR";
    readonly SYSTEM: "SYSTEM";
    readonly OWNER: "OWNER";
    readonly MEMBER: "MEMBER";
    readonly OPERATOR: "OPERATOR";
    readonly SUPPORT_AGENT: "SUPPORT_AGENT";
};
export type Role = (typeof Role)[keyof typeof Role];
export declare const KeyMode: {
    readonly read: "read";
    readonly write: "write";
    readonly upload: "upload";
    readonly manage_users: "manage_users";
    readonly manage_settings: "manage_settings";
    readonly launch_game: "launch_game";
};
export type KeyMode = (typeof KeyMode)[keyof typeof KeyMode];
export declare const InvitationStatus: {
    readonly PENDING: "PENDING";
    readonly ACCEPTED: "ACCEPTED";
    readonly DECLINED: "DECLINED";
    readonly INACTIVE: "INACTIVE";
};
export type InvitationStatus = (typeof InvitationStatus)[keyof typeof InvitationStatus];
export declare const TournamentStatus: {
    readonly PENDING: "PENDING";
    readonly ACTIVE: "ACTIVE";
    readonly COMPLETED: "COMPLETED";
    readonly CANCELLED: "CANCELLED";
};
export type TournamentStatus = (typeof TournamentStatus)[keyof typeof TournamentStatus];
export declare const TransactionType: {
    readonly DEPOSIT: "DEPOSIT";
    readonly WITHDRAWAL: "WITHDRAWAL";
    readonly BET: "BET";
    readonly WIN: "WIN";
    readonly TRANSFER_SENT: "TRANSFER_SENT";
    readonly TRANSFER_RECEIVED: "TRANSFER_RECEIVED";
    readonly SYSTEM_ADJUSTMENT_CREDIT: "SYSTEM_ADJUSTMENT_CREDIT";
    readonly SYSTEM_ADJUSTMENT_DEBIT: "SYSTEM_ADJUSTMENT_DEBIT";
    readonly TOURNAMENT_BUYIN: "TOURNAMENT_BUYIN";
    readonly TOURNAMENT_PRIZE: "TOURNAMENT_PRIZE";
    readonly AFFILIATE_COMMISSION: "AFFILIATE_COMMISSION";
    readonly REFUND: "REFUND";
    readonly FEE: "FEE";
    readonly BONUS_AWARD: "BONUS_AWARD";
    readonly BET_PLACE: "BET_PLACE";
    readonly BET_WIN: "BET_WIN";
    readonly BET_LOSE: "BET_LOSE";
    readonly BET_REFUND: "BET_REFUND";
    readonly BONUS_WAGER: "BONUS_WAGER";
    readonly BONUS_CONVERT: "BONUS_CONVERT";
    readonly BONUS_EXPIRED: "BONUS_EXPIRED";
    readonly XP_AWARD: "XP_AWARD";
    readonly ADJUSTMENT_ADD: "ADJUSTMENT_ADD";
    readonly ADJUSTMENT_SUB: "ADJUSTMENT_SUB";
    readonly INTERNAL_TRANSFER: "INTERNAL_TRANSFER";
    readonly PRODUCT_PURCHASE: "PRODUCT_PURCHASE";
    readonly REBATE_PAYOUT: "REBATE_PAYOUT";
};
export type TransactionType = (typeof TransactionType)[keyof typeof TransactionType];
export declare const TransactionStatus: {
    readonly PENDING: "PENDING";
    readonly PROCESSING: "PROCESSING";
    readonly COMPLETED: "COMPLETED";
    readonly FAILED: "FAILED";
    readonly CANCELLED: "CANCELLED";
    readonly REFUNDED: "REFUNDED";
    readonly EXPIRED: "EXPIRED";
    readonly REJECTED: "REJECTED";
    readonly REQUIRES_ACTION: "REQUIRES_ACTION";
    readonly ON_HOLD: "ON_HOLD";
};
export type TransactionStatus = (typeof TransactionStatus)[keyof typeof TransactionStatus];
export declare const RewardStatus: {
    readonly AVAILABLE: "AVAILABLE";
    readonly CLAIMED: "CLAIMED";
    readonly EXPIRED: "EXPIRED";
    readonly PENDING: "PENDING";
    readonly VOIDED: "VOIDED";
};
export type RewardStatus = (typeof RewardStatus)[keyof typeof RewardStatus];
