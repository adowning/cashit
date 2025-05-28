/**
 * This file should be your main import to use Prisma. Through it you get access to all the models, enums, and input types.
 *
 * 🟢 You can import this file directly.
 */
import * as runtime from "@prisma/client/runtime/library";
import * as $Enums from "./enums.ts";
import * as $Class from "./internal/class.ts";
import * as Prisma from "./internal/prismaNamespace.ts";
export * as $Enums from './enums.ts';
/**
 * ## Prisma Client
 *
 * Type-safe database client for TypeScript
 * @example
 * ```
 * const prisma = new PrismaClient()
 * // Fetch zero or more Users
 * const users = await prisma.user.findMany()
 * ```
 *
 * Read more in our [docs](https://www.prisma.io/docs/reference/tools-and-interfaces/prisma-client).
 */
export declare const PrismaClient: $Class.PrismaClientConstructor;
export type PrismaClient<ClientOptions extends Prisma.PrismaClientOptions = Prisma.PrismaClientOptions, Log = $Class.LogOptions<ClientOptions>, ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = $Class.PrismaClient<ClientOptions, Log, ExtArgs>;
export { Prisma };
/**
 * Model User
 *
 */
export type User = Prisma.UserModel;
/**
 * Model Session
 *
 */
export type Session = Prisma.SessionModel;
/**
 * Model Account
 *
 */
export type Account = Prisma.AccountModel;
/**
 * Model Verification
 *
 */
export type Verification = Prisma.VerificationModel;
/**
 * Model Game
 *
 */
export type Game = Prisma.GameModel;
/**
 * Model GameSession
 *
 */
export type GameSession = Prisma.GameSessionModel;
/**
 * Model GameSpin
 *
 */
export type GameSpin = Prisma.GameSpinModel;
/**
 * Model GameProvider
 *
 */
export type GameProvider = Prisma.GameProviderModel;
/**
 * Model GameLaunchLink
 *
 */
export type GameLaunchLink = Prisma.GameLaunchLinkModel;
/**
 * Model Operator
 *
 */
export type Operator = Prisma.OperatorModel;
/**
 * Model OperatorInvitation
 *
 */
export type OperatorInvitation = Prisma.OperatorInvitationModel;
/**
 * Model Product
 *
 */
export type Product = Prisma.ProductModel;
/**
 * Model Todo
 *
 */
export type Todo = Prisma.TodoModel;
/**
 * Model Tournament
 *
 */
export type Tournament = Prisma.TournamentModel;
/**
 * Model TournamentGame
 *
 */
export type TournamentGame = Prisma.TournamentGameModel;
/**
 * Model TournamentParticipant
 *
 */
export type TournamentParticipant = Prisma.TournamentParticipantModel;
/**
 * Model TournamentGamePlay
 *
 */
export type TournamentGamePlay = Prisma.TournamentGamePlayModel;
/**
 * Model TournamentReward
 *
 */
export type TournamentReward = Prisma.TournamentRewardModel;
/**
 * Model Transaction
 *
 */
export type Transaction = Prisma.TransactionModel;
/**
 * Model RebateTransaction
 *
 */
export type RebateTransaction = Prisma.RebateTransactionModel;
/**
 * Model Wallet
 *
 */
export type Wallet = Prisma.WalletModel;
/**
 * Model UserProfile
 *
 */
export type UserProfile = Prisma.UserProfileModel;
export type GameCategory = $Enums.GameCategory;
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
export type GameProviderName = $Enums.GameProviderName;
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
export type ProviderAuthType = $Enums.ProviderAuthType;
export declare const ProviderAuthType: {
    readonly API_KEY: "API_KEY";
    readonly OAUTH2: "OAUTH2";
    readonly JWT_SIGN: "JWT_SIGN";
    readonly CUSTOM: "CUSTOM";
    readonly NONE: "NONE";
};
export type PaymentMethod = $Enums.PaymentMethod;
export declare const PaymentMethod: {
    readonly INSTORE_CASH: "INSTORE_CASH";
    readonly INSTORE_CARD: "INSTORE_CARD";
    readonly CASH_APP: "CASH_APP";
};
export type Role = $Enums.Role;
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
export type KeyMode = $Enums.KeyMode;
export declare const KeyMode: {
    readonly read: "read";
    readonly write: "write";
    readonly upload: "upload";
    readonly manage_users: "manage_users";
    readonly manage_settings: "manage_settings";
    readonly launch_game: "launch_game";
};
export type InvitationStatus = $Enums.InvitationStatus;
export declare const InvitationStatus: {
    readonly PENDING: "PENDING";
    readonly ACCEPTED: "ACCEPTED";
    readonly DECLINED: "DECLINED";
    readonly INACTIVE: "INACTIVE";
};
export type TournamentStatus = $Enums.TournamentStatus;
export declare const TournamentStatus: {
    readonly PENDING: "PENDING";
    readonly ACTIVE: "ACTIVE";
    readonly COMPLETED: "COMPLETED";
    readonly CANCELLED: "CANCELLED";
};
export type TransactionType = $Enums.TransactionType;
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
export type TransactionStatus = $Enums.TransactionStatus;
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
export type RewardStatus = $Enums.RewardStatus;
export declare const RewardStatus: {
    readonly AVAILABLE: "AVAILABLE";
    readonly CLAIMED: "CLAIMED";
    readonly EXPIRED: "EXPIRED";
    readonly PENDING: "PENDING";
    readonly VOIDED: "VOIDED";
};
