// Suggested content for: ai_folder/packages/types/src/interface/game.ts
// This file should be reviewed to ensure RTGSpinResponseDto, RtgSpinResult,
// ProviderSpinResponseData, and ProviderSettingsResponseData are consistent
// and that Provider types can be safely cast or mapped to RtgSpinResult/RtgSettingsResult.

import type { PrismaGame, PrismaGameSession, PrismaGameSpin, PrismaWallet } from './prisma'

// Original imports from your file
// import type { PrismaGameSession, , PrismaWallet as PrismaWallet, Transaction as Transaction, PrismaGameSpin as PrismaGameSpin } from 'shared';
// import type { CurrencyInfo } from './currency';
// import type { UserProfile } from '../index'; // Use UserProfile from the main types entry
// import type { JsonArray } from '@/client/runtime/library'; // This might need to be .JsonArray

// Ensure RTGUser, RtgSettingsBalance, ResultPrismaGame etc. are what ProviderSettingsResponseData maps to.
// Ensure RTGUser, RtgSpinBalance, RtgPrismaGame etc. are what ProviderSpinResponseData maps to.

// Example: RTGSpinResponseDto and RtgSpinResult
// (Assuming RtgSpinResult is the actual data payload when success is true)

// Provider's raw response shape for user settings/init call (e.g., from RTG)
// This is what `proxyRequestToRgs` will return for settings.
// Based on your `ProviderSettingsResponseData` type in the original game.service.ts context.

// Define the expected data structures for the response
export interface LuckyBetInfo {
  id: string // spin id
  username: string | null
  avatar: string | null
  gameName: string | null
  winAmount: number // in cents
  wagerAmount: number // in cents
  multiplier: number | null
  timestamp: Date
  userId?: string // Added for internal processing
}

// This interface should match the structure of PrismaGameBigWinItem expected by the frontend store
export interface OutputGameBigWinItem {
  id: string // Unique ID for this item (e.g., spin.id for lucky bet, user.id for high roller)
  userId: string
  username: string | null
  avatar: string | null // Frontend might expect this key instead of 'avatar'

  gameId: string | null
  gameName: string | null

  // Lucky Bet specific (optional)
  winAmount: number
  wagerAmount: number
  multiplier?: number | null
  timestamp: Date
  // High Roller specific (optional)
  total_wagered_cents?: number

  // Adding a few more common optional fields to account for "6 more" from error.
  // These are illustrative; adjust based on actual PrismaGameBigWinItem definition.
  rank?: number // Optional: if you implement ranking
  currency_code?: string // e.g., USD, EUR
  // country_flag_url?: string | null; // Optional: URL for user's country flag
  description?: string | null // e.g., "Huge win on..." or "Top wagerer this week"
  // property_extra1?: any;
  // property_extra2?: any;
  // property_extra3?: any;
  // property_extra4?: any;
  // property_extra5?: any;
  // property_extra6?: any;
}

export interface GameBigWinResponseData {
  high_rollers: OutputGameBigWinItem[]
  lucky_bets: OutputGameBigWinItem[]
}
export interface HighRollerInfo {
  userId: string
  username: string | null
  avatar: string | null
  totalWagered: number // in cents, over a period
  lastActivity: Date // Timestamp of their last relevant activity
}

export interface GameBigWinData {
  high_rollers: HighRollerInfo[]
  lucky_bets: LuckyBetInfo[]
}

export interface ProviderSettingsResponseData {
  user: {
    balance: { cash: string; freeBets?: string; bonus?: string; [key: string]: any }
    canGamble: boolean
    userId: number | string // Provider's user ID
    sessionId: string // Provider's session ID
    sessionNetPosition?: string
    token: string // Provider's session token
    country?: string
    currency?: { code: string; symbol: string }
    stakes?: any
    limits?: any
    serverTime: string // ISO Date string
    [key: string]: any // Allow other provider-specific fields
  }
  game?: {
    version?: string
    gameType?: string
    [key: string]: any
  }
  launcher?: {
    version?: string
    [key: string]: any
  }
  jackpots?: any
  // ... any other top-level properties from the provider's settings response
}

// The DTO your /rtg/settings endpoint will return to the client
export interface RTGSettingsResponseDto {
  success: boolean
  result?: ProviderSettingsResponseData // If successful, this is the data from the provider
  error?: {
    code: string
    message: string
    details?: any
  }
}

// Provider's raw response shape for a spin/play call (e.g., from RTG)
// This is what `proxyRequestToRgs` will return for a spin.
// Based on your `ProviderSpinResponseData` type in the original game.service.ts context.
export interface ProviderSpinResponseData {
  transactions: {
    roundId: number | string // Provider's round ID
    [key: string]: any
  }
  user: {
    balance: {
      // Balance structure after spin
      cash: { atStart?: string; afterBet?: string; atEnd: string } // atEnd is primary
      freeBets?: { atStart?: string; afterBet?: string; atEnd: string }
      bonus?: { atStart?: string; afterBet?: string; atEnd: string }
      [key: string]: any
    }
    userId: number | string
    sessionId: string
    sessionNetPosition?: string
    token: string
    serverTime: string // ISO Date string
    canGamble?: boolean
    [key: string]: any
  }
  game: {
    win: {
      instantWin?: string
      lines?: string
      total: string // Total win amount as string from provider
      [key: string]: any
    }
    stake: string // Stake amount for this spin
    multiplier?: number
    winLines?: any[]
    reelsBuffer?: Array<Array<number[]>>
    [key: string]: any // Other game-specific outcomes
  }
  jackpots?: any | null
  bonusChance?: any | null
  // Any other fields specific to the provider's spin response
}

// This is the "result" part of RTGSpinResponseDto,
// it should be structurally compatible with ProviderSpinResponseData.
// If they are identical, you can alias: export type RtgSpinResult = ProviderSpinResponseData;
// If not, define RtgSpinResult explicitly and map ProviderSpinResponseData to it.
// export type RtgSpinResult = ProviderSpinResponseData // Assuming direct compatibility for now. Adjust if needed.

// The DTO your /rtg/spin endpoint will return to the client
export interface RTGSpinResponseDto {
  success: boolean
  result?: RtgSpinResult // If successful, this is the (potentially mapped) data
  error?: {
    code: string
    message: string
    details?: any
  }
}

// Request DTOs remain largely the same, ensure they match provider's requirements
export interface RTGSettingsRequestDto {
  gameId: string
  token: string // Platform session token or provider specific?
  userId: string // Platform user ID, possibly prefixed
  currency: string
  language: string
  mode: 'real' | 'demo'
  // Include all other fields RTG /settings endpoint expects
  // Based on original game.ts:
  custom?: { siteId?: string; extras?: string; [key: string]: any }
  userData?: {
    userId?: string | number
    hash?: string
    affiliate?: string
    lang?: string
    channel?: string
    userType?: string
    fingerprint?: string
    [key: string]: any
  }
  // [key: string]: any; // For flexibility if many varying fields
}

export interface RTGSpinRequestDto {
  token: string // Platform session token OR provider's game session token
  userId: string // Platform user ID, possibly prefixed for provider
  gameId: string // Provider's game ID
  stake: number | string // Stake amount
  currency: string
  sessionId: string // THIS IS CRUCIAL - Provider's session ID obtained from settings call
  playMode?: 'real' | 'demo'
  actions?: any[] // Specific game actions
  // Include all other fields RTG /spin endpoint expects
  // Based on original game.ts context and game.ts type file:
  custom?: { siteId?: string; extras?: string; [key: string]: any }
  bonusId?: any
  extras?: any
  siteId?: string
  userType?: string
  lang?: string | number
  fingerprint?: string | number
  channel?: string | number
  affiliate?: string | number
  userData?: {
    userId?: string | number
    affiliate?: string
    lang?: string
    channel?: string
    userType?: string
    [key: string]: any
  }
  roundId?: string | number // Optional if client tracks/sends it
  transactionId?: string | number // Optional platform-side tx id if sent to provider
  // [key: string]: any;
}

// --- GamePlatformSpinResultDetails (Internal Backend Type) ---
// This defines the structure returned by your internal handlePlatformGameRound function.
// It uses Prisma's GetPayload types for precision.
export interface GamePlatformSpinResultDetails {
  betTransaction: {
    include: {
      originatorUser: {
        // Renamed from originatedUser for consistency if schema uses 'originatorUser'
        select: {
          id: true
          username: true
        }
      }
    }
  }
  winTransaction?: {
    include: {
      originatorUser: {
        // Renamed for consistency
        select: {
          id: true
          username: true
        }
      }
    }
  } | null
  finalPlatformWallet: PrismaWallet
  updatedGameSession: PrismaGameSession
  gameSpinRecord: PrismaGameSpin
  xpAwardedThisSpin: number
  tournamentPointsAwardedThisSpin: number
}

// Other existing types from your packages/types/src/interface/game.ts
// ... (GameCategoryName, Game, RTGUser, ResultGame, Launcher, etc. - review for consistency with above)
// It's important that if RTGUser used in RtgSpinResult is different from RTGUser used in RTGSettingsResponseDto's result,
// they are named distinctly, e.g., RtgSettingsUser, RtgSpinUser.
// The ProviderSpinResponseData and ProviderSettingsResponseData above try to generalize this.

// export { GameSession } // Re-export if used directly by client-facing types

export type GameCategoryName = 'TABLE' | 'FISH' | 'POKER' | 'SLOTS' | 'OTHER' //

// ... (Keep other types like GameListResponse, Search, GameItem, etc., ensuring they align)
// For GameListResponse and GetGameSearchResponse, ensure they use the updated PaginatedResponse structure if applicable.

export interface GameListResponse {
  // Example if you keep this specific structure
  code: number
  list: Game[] // Define Game type if not already
  total: number
}

export interface Game {
  // Basic Game definition, expand as needed
  id: string
  name: string
  title: string
  providerName?: string // Was 'developer'
  providerGameId?: string // External ID from provider
  category?: GameCategoryName // from enum GameCategory in schema
  isActive?: boolean
  thumbnailUrl?: string
  popularity?: number
  // ... other fields from your Prisma Game model that client needs
}
// Ensure all DTOs used in game.service.ts (like LaunchGameResponseDto) are defined here too.
export interface LaunchGameResponseDto {
  launch_url: string
  game_session_id?: string
  launch_strategy?: 'IFRAME' | 'REDIRECT' | 'POPUP'
  provider_parameters?: Record<string, any> | string
}

export interface ProviderSettingsResponseData {
  user: {
    balance: { cash: string; freeBets?: string; bonus?: string; [key: string]: any }
    canGamble: boolean
    userId: number | string // Provider's user ID
    sessionId: string // Provider's session ID
    sessionNetPosition?: string
    token: string // Provider's session token
    country?: string
    currency?: { code: string; symbol: string }
    stakes?: any
    limits?: any
    serverTime: string // ISO Date string
    [key: string]: any // Allow other provider-specific fields
  }
  game?: {
    version?: string
    gameType?: string
    [key: string]: any
  }
  launcher?: {
    version?: string
    [key: string]: any
  }
  jackpots?: any
  // ... any other top-level properties from the provider's settings response
}

// The DTO your /rtg/settings endpoint will return to the client
export interface RTGSettingsResponseDto {
  success: boolean
  result?: ProviderSettingsResponseData // If successful, this is the data from the provider
  error?: {
    code: string
    message: string
    details?: any
  }
}

// Provider's raw response shape for a spin/play call (e.g., from RTG)
// This is what `proxyRequestToRgs` will return for a spin.
// Based on your `ProviderSpinResponseData` type in the original game.service.ts context.
export interface ProviderSpinResponseData {
  transactions: {
    roundId: number | string // Provider's round ID
    [key: string]: any
  }
  user: {
    balance: {
      // Balance structure after spin
      cash: { atStart?: string; afterBet?: string; atEnd: string } // atEnd is primary
      freeBets?: { atStart?: string; afterBet?: string; atEnd: string }
      bonus?: { atStart?: string; afterBet?: string; atEnd: string }
      [key: string]: any
    }
    userId: number | string
    sessionId: string
    sessionNetPosition?: string
    token: string
    serverTime: string // ISO Date string
    canGamble?: boolean
    [key: string]: any
  }
  game: {
    win: {
      instantWin?: string
      lines?: string
      total: string // Total win amount as string from provider
      [key: string]: any
    }
    stake: string // Stake amount for this spin
    multiplier?: number
    winLines?: any[]
    reelsBuffer?: Array<Array<number[]>>
    [key: string]: any // Other game-specific outcomes
  }
  jackpots?: any | null
  bonusChance?: any | null
  // Any other fields specific to the provider's spin response
}

// This is the "result" part of RTGSpinResponseDto,
// it should be structurally compatible with ProviderSpinResponseData.
// If they are identical, you can alias: export type RtgSpinResult = ProviderSpinResponseData;
// If not, define RtgSpinResult explicitly and map ProviderSpinResponseData to it.
export type RtgSpinResult = ProviderSpinResponseData // Assuming direct compatibility for now. Adjust if needed.

// The DTO your /rtg/spin endpoint will return to the client
export interface RTGSpinResponseDto {
  success: boolean
  result?: RtgSpinResult // If successful, this is the (potentially mapped) data
  error?: {
    code: string
    message: string
    details?: any
  }
}
export interface LaunchGameResponseDto {
  launch_url: string
  game_session_id?: string
  launch_strategy?: 'IFRAME' | 'REDIRECT' | 'POPUP'
  provider_parameters?: Record<string, any> | string
}

// Request DTOs remain largely the same, ensure they match provider's requirements
export interface RTGSettingsRequestDto {
  gameId: string
  token: string // Platform session token or provider specific?
  userId: string // Platform user ID, possibly prefixed
  currency: string
  language: string
  mode: 'real' | 'demo'
  // Include all other fields RTG /settings endpoint expects
  // Based on original game.ts:
  custom?: { siteId?: string; extras?: string; [key: string]: any }
  userData?: {
    userId?: string | number
    hash?: string
    affiliate?: string
    lang?: string
    channel?: string
    userType?: string
    fingerprint?: string
    [key: string]: any
  }
  // [key: string]: any; // For flexibility if many varying fields
}

export interface RTGSpinRequestDto {
  token: string // Platform session token OR provider's game session token
  userId: string // Platform user ID, possibly prefixed for provider
  gameId: string // Provider's game ID
  stake: number | string // Stake amount
  currency: string
  sessionId: string // THIS IS CRUCIAL - Provider's session ID obtained from settings call
  playMode?: 'real' | 'demo'
  actions?: any[] // Specific game actions
  // Include all other fields RTG /spin endpoint expects
  // Based on original game.ts context and game.ts type file:
  custom?: { siteId?: string; extras?: string; [key: string]: any }
  bonusId?: any
  extras?: any
  siteId?: string
  userType?: string
  lang?: string | number
  fingerprint?: string | number
  channel?: string | number
  affiliate?: string | number
  userData?: {
    userId?: string | number
    affiliate?: string
    lang?: string
    channel?: string
    userType?: string
    [key: string]: any
  }
  roundId?: string | number // Optional if client tracks/sends it
  transactionId?: string | number // Optional platform-side tx id if sent to provider
  // [key: string]: any;
}

// --- PrismaGamePlatformSpinResultDetails (Internal Backend Type) ---
// This defines the structure returned by your internal handlePlatformPrismaGameRound function.
// It uses 's GetPayload types for precision.
export interface PrismaGamePlatformSpinResultDetails {
  betTransaction: {
    include: {
      originatorUser: {
        // Renamed from originatedUser for consistency if schema uses 'originatorUser'
        select: {
          id: true
          username: true
        }
      }
    }
  }
  winTransaction?: {
    include: {
      originatorUser: {
        // Renamed for consistency
        select: {
          id: true
          username: true
        }
      }
    }
  } | null
  finalPlatformPrismaWallet: PrismaWallet
  updatedPrismaGameSession: PrismaGameSession
  gameSpinRecord: PrismaGameSpin
  xpAwardedThisSpin: number
  tournamentPointsAwardedThisSpin: number
}

// Other existing types from your packages/types/src/interface/game.ts
// ... (PrismaGameCategoryName, PrismaGame, RTGUser, ResultPrismaGame, Launcher, etc. - review for consistency with above)
// It's important that if RTGUser used in RtgSpinResult is different from RTGUser used in RTGSettingsResponseDto's result,
// they are named distinctly, e.g., RtgSettingsUser, RtgSpinUser.
// The ProviderSpinResponseData and ProviderSettingsResponseData above try to generalize this.

export type { PrismaGameSession } // Re-export if used directly by client-facing types

export type PrismaGameCategoryName = 'TABLE' | 'FISH' | 'POKER' | 'SLOTS' | 'OTHER' //

// ... (Keep other types like PrismaGameListResponse, Search, PrismaGameItem, etc., ensuring they align)
// For PrismaGameListResponse and GetPrismaGameSearchResponse, ensure they use the updated PaginatedResponse structure if applicable.

export interface PrismaGameListResponse {
  // Example if you keep this specific structure
  code: number
  list: PrismaGame[] // Define PrismaGame type if not already
  total: number
}

// export interface PrismaGame {
//   // Basic PrismaGame definition, expand as needed
//   id: string
//   name: string
//   title: string
//   providerName?: string // Was 'developer'
//   providerPrismaGameId?: string // External ID from provider
//   category?: PrismaGameCategoryName // from enum PrismaGameCategory in schema
//   isActive?: boolean
//   thumbnailUrl?: string
//   popularity?: number
//   // ... other fields from your  PrismaGame model that client needs
// }
// Ensure all DTOs used in game.service.ts (like LaunchPrismaGameResponseDto) are defined here too.
export interface LaunchPrismaGameResponseDto {
  launch_url: string
  game_session_id?: string
  launch_strategy?: 'IFRAME' | 'REDIRECT' | 'POPUP'
  provider_parameters?: Record<string, any> | string
}
// import type { PrismaGameSession } from 'shared'
// import type { CurrencyInfo } from './currency'
// import type { UserProfile } from './user'
// import type { JsonArray } from '@/client/runtime/library'

// export type PrismaGameCategoryName = 'TABLE' | 'FISH' | 'POKER' | 'SLOTS' | 'OTHER'

// export interface PrismaGame {
//   id: string
//   name: string
//   title: string
//   temperature: string | null
//   developer: string | null
//   vipLevel: number | null
//   isActive: boolean | null
//   device: number | null
//   featured: boolean | null
//   gamebank: string | null
//   bet: number | null
//   denomination: number | null
//   categoryTemp: number | null
//   originalId: number | null
//   bids: number | null
//   statIn: number | null
//   statOut: number | null
//   currentRtp: number | null
//   rtpStatIn: number | null
//   rtpStatOut: number | null
//   standardRtp: number | null
//   popularity: number | null
//   chanceFirepot1: number | null
//   chanceFirepot2: number | null
//   chanceFirepot3: number | null
//   fireCount1: number | null
//   fireCount2: number | null
//   fireCount3: number | null
//   linesPercentConfigSpin: string | null
//   linesPercentConfigSpinBonus: string | null
//   linesPercentConfigBonus: string | null
//   linesPercentConfigBonusBonus: string | null
//   rezerv: number | null
//   cask: number | null
//   advanced: string | null
//   scaleMode: string
//   slotViewState: string
//   view: number | null
//   categoryId: string | null
//   operatorId: string | null
//   providerId: string | null
//   createdAt: Date
//   updatedAt: Date
//   category: PrismaGameCategoryName
//   jackpotGroupId: string | null
//   active: boolean
//   password: string | null
//   // ope
//   // rator: Operator | null;
// }
// export interface RTGSettingsRequestDto {
//   token: string
//   gameId: string
//   userData: {
//     userId: string
//     hash: string
//     affiliate: string
//     lang: string
//     channel: string
//     userType: string
//     fingerprint: string
//   }
//   custom: {
//     siteId: string
//     extras: string
//   }
// }
// export interface RTGSettingsResponseDto {
//   success: boolean
//   result: RtgSettingsResult
// }

// export interface RtgSettingsResult {
//   user: RTGUser
//   game: ResultPrismaGame
//   launcher: Launcher
//   jackpots: null
// }

// export interface ResultPrismaGame {
//   cols: number
//   rows: number
//   offset: number
//   multiplierSequence: MultiplierSequence
//   extraWin: ExtraWin
//   lines: Array<number[]>
//   tiles: Tile[]
//   reelsBuffer: Array<Array<number[]>>
//   paysType: string
//   features: string[]
//   singlePayline: boolean
//   hasState: boolean
//   version: string
//   rtp: RTP
//   volatilityIndex: string
//   maxMultiplier: string
//   maxWinlineHitRate: string
//   maxMultiplierHitRate: string
//   maxMultiplierHitFrequency: string
//   maxMultiplierWinLines: string
//   maxMultiplierWinLinesHitRate: string
//   maxMultiplierWinLinesHitFrequency: string
//   hasGamblePrismaGame: boolean
//   gameType: string
//   stateful: boolean
//   hasChoices: boolean
//   stateExpireDays: null
//   hasBonuses: boolean
//   pendingRoundDays: number
//   skin: null
//   hasFeatureBuy: boolean
// }

// export interface ExtraWin {
//   bigWin: string
//   superWin: string
//   megaWin: string
// }

// export interface MultiplierSequence {
//   Progress: Progress[]
// }

// export interface Progress {
//   count: number
//   multiplier: number
//   spins: number
// }

// export interface RTP {
//   game: RtgPrismaGame
// }

// // export interface RtgPrismaGame {
// //   default: string

// export interface Tile {
//   id: number
//   type: Type
//   pays: string[]
// }

// export enum Type {
//   Normal = 'normal',
//   Scatter = 'scatter',
// }

// export interface Launcher {
//   version: string
// }

// export interface RTGUser {
//   balance: RtgSettingsBalance | RtgSpinBalance
//   notifications: any[]
//   messages: any[]
//   bonuses: any[]
//   tournaments: any[]
//   vouchers: any[]
//   userId: number
//   country: string
//   casino: string
//   vertical: string
//   currency: Currency
//   token: string
//   sessionId: string
//   sessionNetPosition: string
//   aamsParticipationId: null
//   aamsSessionId: null
//   depositedAmount: string
//   maxDeposit: string
//   canGamble: boolean
//   lastWin: string
//   prevRounds: any[]
//   limits: Limits
//   stakes: Stakes
//   autoplay: Autoplay
//   serverTime: Date
//   additional: null
// }

// export interface Autoplay {
//   type: string
//   options: Options
// }

// export interface Options {
//   spins: RtgSpins
//   stopOnFeature: StopOnFeature
//   stopOnLossLimits: StopOnLossLimits
//   stopOnWin: StopOnWin
//   hasRestart: boolean
// }

// export interface RtgSpins {
//   values: string[]
//   default: number
// }

// export interface StopOnFeature {
//   enabled: boolean
// }

// export interface StopOnLossLimits {
//   mandatory: boolean
//   enabled: boolean
//   values: string[]
//   default: number
// }

// export interface StopOnWin {
//   enabled: boolean
//   values: string[]
// }

// export interface RtgSettingsBalance {
//   cash: string
//   freeBets: string
//   sessionCash: string
//   sessionFreeBets: string
//   bonus: string
// }

// export interface Currency {
//   code: string
//   symbol: string
// }

// export interface Limits {
//   maxGambleStake: string
//   maxTotalStake: TotalStake
//   minTotalStake: TotalStake
//   spinDuration: null
// }

// export interface TotalStake {
//   total: string
// }

// export interface Stakes {
//   defaultIndex: number
//   lastIndex: number
//   types: string[]
// }

// export interface PrismaGameCategory {
//   image: string
//   pictures: string
//   game_count: string | number
//   name: string
//   slug: string
//   games: Array<Search>
//   page_no: number
// }
// export interface PrismaGameListResponse {
//   code: number
//   list: Array<PrismaGame>
//   total: number
// }
export interface Search {
  id: string
  name: string
  image: string
  developer: string
  is_demo: boolean
}

// export interface PrismaGameItem {
//   id: number
//   name: string
//   image: string
//   developer: string
//   producer: string
//   is_demo: boolean
// }

export interface PrismaGameEnterBody {
  id: string | Array<string>
  demo: boolean
}

export interface PrismaGameUserBody {
  game_categories_slug: string
  page: number
  limit: number
}

// export interface PrismaGameEnterResponse {
//   method: string
//   parames: string
//   developer: string
//   reserve: string
//   weburl: string
// }

export interface PrismaGameHistoryItem {
  name: string
  created_at: number
  amount: string | number
  multiplier: string | number
  bet_id: string | number
  status: string | number
  profit: number
}

export interface PrismaGameBigWinItem {
  game_id: string
  game_name: string
  game_icon: string
  user_name: string
  user_vip_group: number
  user_vip_level: number
  bet_amount: string
  multiplier: string
  win_amount: string
  time: number
}

export interface PrismaGameBigWinData {
  high_rollers: Array<PrismaGameBigWinItem>
  lucky_bets: Array<PrismaGameBigWinItem>
}

export interface PrismaGameHistoryResponse {
  total_pages: number
  record: Array<PrismaGameHistoryItem>
}

export interface PrismaGameSearchResponse {
  items: Array<Search>
  total: number
}

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
