"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// export type GetPrismaGameFavoriteListResponse = {
//   code: number
//   data: Array<number | string>
//   message: string
// }
// export type GetPrismaGameBigWinResponse = {
//   code: number
//   data: PrismaGameBigWinData
//   message: string
// }
// export type Category = {
//   name: string
//   games: PrismaGame[]
// }
// export type GetPrismaGameCategoriesResponse = {
//   code: number
//   data: Array<any>
//   messsage: string
// }
// export type GetPrismaGameSearchResponse = {
//   code: number
//   data: PrismaGameSearchResponse
//   message: string
// }
// export type GetPrismaGameEnterResponse = {
//   code: number
//   data: PrismaGameEnterResponse
//   gameSession: PrismaGameSession
//   message: string
// }
// export type GetPrismaGameHistoryResponse = {
//   code: number
//   data: PrismaGameHistoryResponse
//   message: string
// }
// /**
//  * Represents a PrismaGame Provider.
//  * Based on the  'PrismaGameProvider' model.
//  */
// export interface PrismaGameProvider {
//   id: string
//   name: string
//   slug: string
//   description?: string | null
//   logo_url?: string | null
//   is_enabled: boolean
//   created_at: Date
//   updated_at: Date
// }
// /**
//  * Represents a PrismaGame. Based on the  'PrismaGame' model.
//  */
// export interface PrismaGameType {
//   id: string
//   name: string
//   slug: string
//   provider_id: string
//   category_id?: string | null
//   description?: string | null
//   thumbnail_url?: string | null
//   banner_url?: string | null
//   external_game_id?: string | null // ID from the game provider
//   tags?: string[]
//   rtp?: number | null // Return to Player percentage
//   volatility?: string | null // e.g., 'low', 'medium', 'high'
//   is_active: boolean
//   is_featured?: boolean
//   launch_options?: Record<string, any> | null // JSON for specific launch params
//   created_at: Date
//   updated_at: Date
//   provider?: PrismaGameProvider // Optional relation
//   // category?: PrismaGameCategoryType; // Optional relation
// }
// /**
//  * Represents a PrismaGame Round or history entry.
//  * Based on the  'PrismaGameRound' model.
//  */
// export interface PrismaGameSpin {
//   id: string
//   user_id: string
//   game_id: string
//   currency_id: string
//   bet_amount: number // Consider using a Decimal library
//   win_amount: number // Consider using a Decimal library
//   profit: number // Consider using a Decimal library (win_amount - bet_amount)
//   external_round_id?: string | null // ID from the game provider, if available
//   status: string // e.g., 'PENDING', 'COMPLETED', 'FAILED'
//   bet_details?: Record<string, any> | null // JSON for complex bet info
//   win_details?: Record<string, any> | null // JSON for complex win info
//   created_at: Date
//   updated_at: Date
//   user?: UserProfile // Optional relation
//   game?: PrismaGameType // Optional relation
//   currency?: CurrencyInfo // Optional relation
// }
// /**
//  * Represents a PrismaGame Round or history entry.
//  * Based on the  'PrismaGameRound' model.
//  */
// export interface RawPrismaGameSpinBody {
//   user_id: string
//   game_id: string
//   currency_id: string
//   rawVendorData: JsonArray
//   created_at: Date
// }
// // Suggested location: packages/types/src/interface/game.ts
// export interface LaunchPrismaGameResponseDto {
//   /**
//    * The URL to launch the game session.
//    * This could be an iframe source or a URL for redirection.
//    */
//   launch_url: string
//   /**
//    * A unique session identifier for this game launch, if provided by the game aggregator or server.
//    * Can be used for tracking or further communication related to this session.
//    */
//   game_session_id?: string
//   /**
//    * Any specific strategy for launching the game (e.g., 'IFRAME', 'REDIRECT', 'POPUP').
//    * Optional, defaults to client figuring it out or a standard method.
//    */
//   launch_strategy?: 'IFRAME' | 'REDIRECT' | 'POPUP'
//   /**
//    * Additional parameters or tokens required by the game provider, serialized as a string
//    * or as a nested object.
//    * Optional.
//    */
//   provider_parameters?: Record<string, any> | string
// }
// export interface RTGSpinRequestDto {
//   gameId: string
//   custom: {
//     siteId: string
//     extras: string
//   }
//   bonusId: any
//   extras: any
//   siteId: string
//   userType: string
//   lang: number
//   fingerprint: number
//   channel: number
//   affiliate: number
//   userData: {
//     userId: number
//     affiliate: string
//     lang: string
//     channel: string
//     userType: string
//   }
//   token: string
//   stake: number
//   sessionId: string
//   playMode: string
// }
// export interface RTGSpinResponseDto {
//   success: boolean
//   result: RtgSpinResult
//   error?: any
// }
// export interface RtgSpinResult {
//   transactions: Transactions
//   user: RTGUser
//   game: RtgPrismaGame
//   jackpots: null
//   bonusChance: null
// }
// export interface RtgPrismaGame {
//   win: Win
//   winsMultipliers: Win
//   stake: string
//   multiplier: number
//   winLines: any[]
//   spinMode: string
//   fatTiles: FatTile[]
//   instantWin: InstantWin
//   actions: Action[]
//   scatters: any[]
//   reelsBuffer: Array<Array<number[]>>
//   features: any[]
//   hasState: boolean
// }
// export interface Action {
//   type: string
//   data: Data
// }
// export interface Data {
//   multiplier?: number
//   index?: number
//   fatTiles?: FatTile[]
// }
// export interface FatTile {
//   tileId: number
//   reel: number
//   index: number
//   width: number
//   height: number
//   multiplier: number
//   amount: string
// }
// export interface InstantWin {
//   multiplier: string
//   amount: string
//   options: string[]
// }
// export interface Win {
//   instantWin: string
//   lines: string
//   total: string
// }
// export interface Transactions {
//   roundId: number
// }
// export interface RTGUser {
//   balance: RtgSpinBalance | RtgSettingsBalance
//   canGamble: boolean
//   userId: number
//   sessionId: string
//   sessionNetPosition: string
//   token: string
//   bonuses: any[]
//   tournaments: any[]
//   vouchers: any[]
//   messages: any[]
//   limits: Limits
//   serverTime: Date
// }
// export interface RtgSpinBalance {
//   cash: RtgBonus
//   freeBets: RtgBonus
//   bonus: RtgBonus
//   sessionCash: RtgBonus
//   sessionFreeBets: RtgBonus
// }
// export interface RtgBonus {
//   atStart: string
//   afterBet: string
//   atEnd: string
// }
// export interface Limits {
//   betThresholdTime: number
// }
// import type {
//   PrismaWallet as PrismaWallet,
//   Transaction as Transaction,
//   PrismaGameSession as PrismaGameSession,
//   PrismaGameSpin as PrismaGameSpin,
//   ,
// } from 'shared' // Assuming  types are re-exported
// // --- ProviderSettingsResponseData ---
// // This is the expected structure of the data AFTER your proxy calls the
// // game provider's /settings or /initUser endpoint.
// // Your existing `game.ts` has RTG-specific types like RTGUser, RtgSettingsBalance, etc.
// // that fulfill this. For RTG, this would be something like:
// export interface RtgSettingsBalance {
//   // As per your game.ts
//   cash: string // Provider's balance for the user, often a string representation
//   freeBets: string
//   bonus: string
//   // ... other balance types if any
// }
// export interface RTGUserForSettings {
//   // Based on RTGUser in your game.ts
//   balance: RtgSettingsBalance
//   canGamble: boolean
//   userId: number | string // Provider's user ID
//   sessionId: string // Provider's session ID for this game session
//   sessionNetPosition?: string
//   token: string // Provider's session token (might be same as sessionId or different)
//   bonuses?: any[]
//   tournaments?: any[]
//   vouchers?: any[]
//   messages?: any[]
//   limits?: any // Define if structure is known
//   serverTime: string // ISO Date string
//   // ... any other fields RTG returns on settings/init
// }
// // This is the actual data structure returned by a provider's settings call.
// // For RTG, it's wrapped in the `RTGSettingsResponseDto` which has a `result` field.
// // So, `ProviderSettingsResponseData` would be the type of that `result` field.
// export type ProviderSettingsResponseData = RTGUserForSettings & {
//   // Include other top-level properties returned by the provider for settings
//   // Example from your game.ts ProviderSettingsResponseData
//   game?: {
//     version?: string
//     gameType?: string
//     // ... other game-specific settings from provider
//   }
//   launcher?: {
//     version?: string
//   }
//   // Any other fields specific to the provider's settings response
// }
// // --- ProviderSpinResponseData ---
// // This is the expected structure of the data AFTER your proxy calls the
// // game provider's /spin or /play endpoint.
// // Your existing `game.ts` has RTG-specific types.
// export interface RtgSpinWinDetails {
//   // As per Win in your game.ts
//   instantWin: string
//   lines: string
//   total: string // Total win amount as a string from provider
// }
// export interface RtgSpinPrismaGameDetails {
//   // As per RtgPrismaGame in your game.ts
//   win: RtgSpinWinDetails
//   winsMultipliers?: RtgSpinWinDetails // Optional
//   stake: string // Stake amount for this spin as a string
//   multiplier?: number
//   winLines?: any[]
//   spinMode?: string
//   reelsBuffer?: Array<Array<number[]>> // Or appropriate type
//   // ... other game-specific outcomes from RTG spin
//   actions?: any[] // Define if structure known
//   features?: any[]
//   hasState?: boolean
// }
// export interface RtgSpinTransactionDetails {
//   // As per Transactions in your game.ts
//   roundId: number | string // Provider's round ID
//   // ... other transaction details from provider
// }
// export interface RtgSpinUserBalance {
//   // As per RtgSpinBalance in your game.ts
//   cash: {
//     // Structure for cash balance after spin
//     atStart: string
//     afterBet: string
//     atEnd: string // Provider's balance after this spin
//   }
//   // ... other balance types (freeBets, bonus) if applicable
// }
// export interface RTGUserForSpin {
//   // Based on RTGUser in your game.ts
//   balance: RtgSpinUserBalance // Different balance structure for spin
//   userId: number | string
//   sessionId: string
//   sessionNetPosition?: string
//   token: string
//   serverTime: string // ISO Date string
//   // ... other user-related fields from provider's spin response
// }
// // This is the actual data structure returned by a provider's spin call.
// // For RTG, it's wrapped in the `RtgSpinResult` which has a `result` field.
// // So, `ProviderSpinResponseData` would be the type of that `result` field.
// export type ProviderSpinResponseData = {
//   transactions: RtgSpinTransactionDetails
//   user: RTGUserForSpin
//   game: RtgSpinPrismaGameDetails
//   jackpots?: any | null // Define if structure known
//   bonusChance?: any | null // Define if structure known
//   // Any other fields specific to the provider's spin response
// }
// // --- PrismaGamePlatformSpinResultDetails ---
// // This is a new interface to standardize the data structure that
// // `handlePlatformPrismaGameRound` returns after processing a spin and updating your platform.
// // It's used internally within your backend.
// export interface PrismaGamePlatformSpinResultDetails {
//   betTransaction: .TransactionGetPayload<{
//     // Select specific fields if you don't need the whole object
//     include: {
//       originatedUser: {
//         select: {
//           id: true
//           username: true
//         }
//       }
//     }
//   }>
//   winTransaction?: .TransactionGetPayload<{
//     include: {
//       originatedUser: {
//         select: {
//           id: true
//           username: true
//         }
//       }
//     }
//   }> | null
//   finalPlatformPrismaWallet: PrismaWallet // The user's wallet state on your platform AFTER the spin
//   updatedPrismaGameSession: PrismaGameSession
//   gameSpinRecord: PrismaGameSpin
//   xpAwardedThisSpin: number
//   tournamentPointsAwardedThisSpin: number
//   // You might also include:
//   // platformUserId: string;
//   // platformPrismaGameId: string;
//   // currencyId: string;
//   // wagerAmountPlatformCents: number;
//   // winAmountPlatformCents: number;
// }
