import { UserProfile } from '@/index';
import type { PrismaGame, PrismaGameSession, PrismaGameSpin, PrismaWallet } from './prisma';
export interface LuckyBetInfo {
    id: string;
    username: string | null;
    avatar: string | null;
    gameName: string | null;
    winAmount: number;
    wagerAmount: number;
    multiplier: number | null;
    timestamp: Date;
    userId?: string;
}
export interface OutputGameBigWinItem {
    id: string;
    userId: string;
    username: string | null;
    avatar: string | null;
    gameId: string | null;
    gameName: string | null;
    winAmount: number;
    wagerAmount: number;
    multiplier?: number | null;
    timestamp: Date;
    total_wagered_cents?: number;
    rank?: number;
    currency_code?: string;
    description?: string | null;
}
export interface GameBigWinResponseData {
    high_rollers: OutputGameBigWinItem[];
    lucky_bets: OutputGameBigWinItem[];
}
export interface HighRollerInfo {
    userId: string;
    username: string | null;
    avatar: string | null;
    totalWagered: number;
    lastActivity: Date;
}
export interface GameBigWinData {
    high_rollers: HighRollerInfo[];
    lucky_bets: LuckyBetInfo[];
}
export interface ProviderSettingsResponseData {
    user: {
        balance: {
            cash: string;
            freeBets?: string;
            bonus?: string;
            [key: string]: any;
        };
        canGamble: boolean;
        userId: number | string;
        sessionId: string;
        sessionNetPosition?: string;
        token: string;
        country?: string;
        currency?: {
            code: string;
            symbol: string;
        };
        stakes?: any;
        limits?: any;
        serverTime: string;
        [key: string]: any;
    };
    game?: {
        version?: string;
        gameType?: string;
        [key: string]: any;
    };
    launcher?: {
        version?: string;
        [key: string]: any;
    };
    jackpots?: any;
}
export interface RTGSettingsResponseDto {
    success: boolean;
    result?: ProviderSettingsResponseData;
    error?: {
        code: string;
        message: string;
        details?: any;
    };
}
export interface ProviderSpinResponseData {
    transactions: {
        roundId: number | string;
        [key: string]: any;
    };
    user: {
        balance: {
            cash: {
                atStart?: string;
                afterBet?: string;
                atEnd: string;
            };
            freeBets?: {
                atStart?: string;
                afterBet?: string;
                atEnd: string;
            };
            bonus?: {
                atStart?: string;
                afterBet?: string;
                atEnd: string;
            };
            [key: string]: any;
        };
        userId: number | string;
        sessionId: string;
        sessionNetPosition?: string;
        token: string;
        serverTime: string;
        canGamble?: boolean;
        [key: string]: any;
    };
    game: {
        win: {
            instantWin?: string;
            lines?: string;
            total: string;
            [key: string]: any;
        };
        stake: string;
        multiplier?: number;
        winLines?: any[];
        reelsBuffer?: Array<Array<number[]>>;
        [key: string]: any;
    };
    jackpots?: any | null;
    bonusChance?: any | null;
}
export interface RTGSpinResponseDto {
    success: boolean;
    result?: RtgSpinResult;
    error?: {
        code: string;
        message: string;
        details?: any;
    };
}
export interface RTGSettingsRequestDto {
    gameId: string;
    token: string;
    userId: string;
    currency: string;
    language: string;
    mode: 'real' | 'demo';
    custom?: {
        siteId?: string;
        extras?: string;
        [key: string]: any;
    };
    userData?: {
        userId?: string | number;
        hash?: string;
        affiliate?: string;
        lang?: string;
        channel?: string;
        userType?: string;
        fingerprint?: string;
        [key: string]: any;
    };
}
export interface RTGSpinRequestDto {
    token: string;
    userId: string;
    gameId: string;
    stake: number | string;
    currency: string;
    sessionId: string;
    playMode?: 'real' | 'demo' | 'test';
    actions?: any[];
    custom?: {
        siteId?: string;
        extras?: string;
        [key: string]: any;
    };
    bonusId?: any;
    extras?: any;
    siteId?: string;
    userType?: string;
    lang?: string | number;
    fingerprint?: string | number;
    channel?: string | number;
    affiliate?: string | number;
    userData?: {
        userId?: string | number;
        affiliate?: string;
        lang?: string;
        channel?: string;
        userType?: string;
        [key: string]: any;
    };
    roundId?: string | number;
    transactionId?: string | number;
}
export interface GamePlatformSpinResultDetails {
    betTransaction: {
        include: {
            originatorUser: {
                select: {
                    id: true;
                    username: true;
                };
            };
        };
    };
    winTransaction?: {
        include: {
            originatorUser: {
                select: {
                    id: true;
                    username: true;
                };
            };
        };
    } | null;
    finalPlatformWallet: PrismaWallet;
    updatedGameSession: PrismaGameSession;
    gameSpinRecord: PrismaGameSpin;
    xpAwardedThisSpin: number;
    tournamentPointsAwardedThisSpin: number;
}
export type GameCategoryName = 'TABLE' | 'FISH' | 'POKER' | 'SLOTS' | 'OTHER';
export interface GameListResponse {
    code: number;
    list: Game[];
    total: number;
}
export interface Game {
    id: string;
    name: string;
    title: string;
    providerName?: string;
    providerGameId?: string;
    category?: GameCategoryName;
    isActive?: boolean;
    thumbnailUrl?: string;
    popularity?: number;
}
export interface LaunchGameResponseDto {
    launch_url: string;
    game_session_id?: string;
    launch_strategy?: 'IFRAME' | 'REDIRECT' | 'POPUP';
    provider_parameters?: Record<string, any> | string;
}
export interface ProviderSettingsResponseData {
    user: {
        balance: {
            cash: string;
            freeBets?: string;
            bonus?: string;
            [key: string]: any;
        };
        canGamble: boolean;
        userId: number | string;
        sessionId: string;
        sessionNetPosition?: string;
        token: string;
        country?: string;
        currency?: {
            code: string;
            symbol: string;
        };
        stakes?: any;
        limits?: any;
        serverTime: string;
        [key: string]: any;
    };
    game?: {
        version?: string;
        gameType?: string;
        [key: string]: any;
    };
    launcher?: {
        version?: string;
        [key: string]: any;
    };
    jackpots?: any;
}
export interface RTGSettingsResponseDto {
    success: boolean;
    result?: ProviderSettingsResponseData;
    error?: {
        code: string;
        message: string;
        details?: any;
    };
}
export interface ProviderSpinResponseData {
    transactions: {
        roundId: number | string;
        [key: string]: any;
    };
    user: {
        balance: {
            cash: {
                atStart?: string;
                afterBet?: string;
                atEnd: string;
            };
            freeBets?: {
                atStart?: string;
                afterBet?: string;
                atEnd: string;
            };
            bonus?: {
                atStart?: string;
                afterBet?: string;
                atEnd: string;
            };
            [key: string]: any;
        };
        userId: number | string;
        sessionId: string;
        sessionNetPosition?: string;
        token: string;
        serverTime: string;
        canGamble?: boolean;
        [key: string]: any;
    };
    game: {
        win: {
            instantWin?: string;
            lines?: string;
            total: string;
            [key: string]: any;
        };
        stake: string;
        multiplier?: number;
        winLines?: any[];
        reelsBuffer?: Array<Array<number[]>>;
        [key: string]: any;
    };
    jackpots?: any | null;
    bonusChance?: any | null;
}
export type RtgSpinResult = ProviderSpinResponseData;
export interface RTGSpinResponseDto {
    success: boolean;
    result?: RtgSpinResult;
    error?: {
        code: string;
        message: string;
        details?: any;
    };
}
export interface LaunchGameResponseDto {
    launch_url: string;
    game_session_id?: string;
    launch_strategy?: 'IFRAME' | 'REDIRECT' | 'POPUP';
    provider_parameters?: Record<string, any> | string;
}
export interface RTGSettingsRequestDto {
    gameId: string;
    token: string;
    userId: string;
    currency: string;
    language: string;
    mode: 'real' | 'demo';
    custom?: {
        siteId?: string;
        extras?: string;
        [key: string]: any;
    };
    userData?: {
        userId?: string | number;
        hash?: string;
        affiliate?: string;
        lang?: string;
        channel?: string;
        userType?: string;
        fingerprint?: string;
        [key: string]: any;
    };
}
export interface RTGSpinRequestDto {
    token: string;
    userId: string;
    gameId: string;
    stake: number | string;
    currency: string;
    sessionId: string;
    playMode?: 'real' | 'demo' | 'test';
    actions?: any[];
    custom?: {
        siteId?: string;
        extras?: string;
        [key: string]: any;
    };
    bonusId?: any;
    extras?: any;
    siteId?: string;
    userType?: string;
    lang?: string | number;
    fingerprint?: string | number;
    channel?: string | number;
    affiliate?: string | number;
    userData?: {
        userId?: string | number;
        affiliate?: string;
        lang?: string;
        channel?: string;
        userType?: string;
        [key: string]: any;
    };
    roundId?: string | number;
    transactionId?: string | number;
}
export interface PrismaGamePlatformSpinResultDetails {
    betTransaction: {
        include: {
            originatorUser: {
                select: {
                    id: true;
                    username: true;
                };
            };
        };
    };
    winTransaction?: {
        include: {
            originatorUser: {
                select: {
                    id: true;
                    username: true;
                };
            };
        };
    } | null;
    finalPlatformPrismaWallet: PrismaWallet;
    updatedPrismaGameSession: PrismaGameSession;
    gameSpinRecord: PrismaGameSpin;
    xpAwardedThisSpin: number;
    tournamentPointsAwardedThisSpin: number;
}
export type { PrismaGameSession };
export type PrismaGameCategoryName = 'TABLE' | 'FISH' | 'POKER' | 'SLOTS' | 'OTHER';
export interface PrismaGameListResponse {
    code: number;
    list: PrismaGame[];
    total: number;
}
export interface LaunchPrismaGameResponseDto {
    launch_url: string;
    game_session_id?: string;
    launch_strategy?: 'IFRAME' | 'REDIRECT' | 'POPUP';
    provider_parameters?: Record<string, any> | string;
}
export interface ProviderSettingsResponseData {
    user: {
        balance: {
            cash: string;
            freeBets?: string;
            bonus?: string;
            [key: string]: any;
        };
        canGamble: boolean;
        userId: number | string;
        sessionId: string;
        sessionNetPosition?: string;
        token: string;
        country?: string;
        currency?: {
            code: string;
            symbol: string;
        };
        stakes?: any;
        limits?: any;
        serverTime: string;
        [key: string]: any;
    };
    game?: {
        version?: string;
        gameType?: string;
        [key: string]: any;
    };
    launcher?: {
        version?: string;
        [key: string]: any;
    };
    jackpots?: any;
}
export interface RTGSettingsResponseDto {
    success: boolean;
    result?: ProviderSettingsResponseData;
    error?: {
        code: string;
        message: string;
        details?: any;
    };
}
export interface ProviderSpinResponseData {
    transactions: {
        roundId: number | string;
        [key: string]: any;
    };
    user: {
        balance: {
            cash: {
                atStart?: string;
                afterBet?: string;
                atEnd: string;
            };
            freeBets?: {
                atStart?: string;
                afterBet?: string;
                atEnd: string;
            };
            bonus?: {
                atStart?: string;
                afterBet?: string;
                atEnd: string;
            };
            [key: string]: any;
        };
        userId: number | string;
        sessionId: string;
        sessionNetPosition?: string;
        token: string;
        serverTime: string;
        canGamble?: boolean;
        [key: string]: any;
    };
    game: {
        win: {
            instantWin?: string;
            lines?: string;
            total: string;
            [key: string]: any;
        };
        stake: string;
        multiplier?: number;
        winLines?: any[];
        reelsBuffer?: Array<Array<number[]>>;
        [key: string]: any;
    };
    jackpots?: any | null;
    bonusChance?: any | null;
}
export interface RTGSpinResponseDto {
    success: boolean;
    result?: RtgSpinResult;
    error?: {
        code: string;
        message: string;
        details?: any;
    };
}
export interface RTGSettingsRequestDto {
    gameId: string;
    token: string;
    userId: string;
    currency: string;
    language: string;
    mode: 'real' | 'demo';
    custom?: {
        siteId?: string;
        extras?: string;
        [key: string]: any;
    };
    userData?: {
        userId?: string | number;
        hash?: string;
        affiliate?: string;
        lang?: string;
        channel?: string;
        userType?: string;
        fingerprint?: string;
        [key: string]: any;
    };
}
export interface RTGSpinRequestDto {
    token: string;
    userId: string;
    gameId: string;
    stake: number | string;
    currency: string;
    sessionId: string;
    playMode?: 'real' | 'demo' | 'test';
    actions?: any[];
    custom?: {
        siteId?: string;
        extras?: string;
        [key: string]: any;
    };
    bonusId?: any;
    extras?: any;
    siteId?: string;
    userType?: string;
    lang?: string | number;
    fingerprint?: string | number;
    channel?: string | number;
    affiliate?: string | number;
    userData?: {
        userId?: string | number;
        affiliate?: string;
        lang?: string;
        channel?: string;
        userType?: string;
        [key: string]: any;
    };
    roundId?: string | number;
    transactionId?: string | number;
}
export interface GamePlatformSpinResultDetails {
    betTransaction: {
        include: {
            originatorUser: {
                select: {
                    id: true;
                    username: true;
                };
            };
        };
    };
    winTransaction?: {
        include: {
            originatorUser: {
                select: {
                    id: true;
                    username: true;
                };
            };
        };
    } | null;
    finalPlatformWallet: PrismaWallet;
    updatedGameSession: PrismaGameSession;
    gameSpinRecord: PrismaGameSpin;
    xpAwardedThisSpin: number;
    tournamentPointsAwardedThisSpin: number;
}
export interface GameListResponse {
    code: number;
    list: Game[];
    total: number;
}
export interface LaunchGameResponseDto {
    launch_url: string;
    game_session_id?: string;
    launch_strategy?: 'IFRAME' | 'REDIRECT' | 'POPUP';
    provider_parameters?: Record<string, any> | string;
}
export interface Autoplay {
    type: string;
    options: Options;
}
export interface Options {
    spins: RtgSpins;
    stopOnFeature: StopOnFeature;
    stopOnLossLimits: StopOnLossLimits;
    stopOnWin: StopOnWin;
    hasRestart: boolean;
}
export interface RtgSpins {
    values: string[];
    default: number;
}
export interface StopOnFeature {
    enabled: boolean;
}
export interface StopOnLossLimits {
    mandatory: boolean;
    enabled: boolean;
    values: string[];
    default: number;
}
export interface StopOnWin {
    enabled: boolean;
    values: string[];
}
export interface RtgSettingsBalance {
    cash: string;
    freeBets: string;
    sessionCash: string;
    sessionFreeBets: string;
    bonus: string;
}
export interface Currency {
    code: string;
    symbol: string;
}
export interface Limits {
    maxGambleStake: string;
    maxTotalStake: TotalStake;
    minTotalStake: TotalStake;
    spinDuration: null;
}
export interface TotalStake {
    total: string;
}
export interface Stakes {
    defaultIndex: number;
    lastIndex: number;
    types: string[];
}
export interface GameListResponse {
    code: number;
    list: Array<Game>;
    total: number;
}
export interface Search {
    id: string;
    name: string;
    image: string;
    developer: string;
    is_demo: boolean;
}
export interface GameItem {
    id: number;
    name: string;
    image: string;
    developer: string;
    producer: string;
    is_demo: boolean;
}
export interface GameEnterBody {
    id: string | Array<string>;
    demo: boolean;
}
export interface GameUserBody {
    game_categories_slug: string;
    id: string;
    demo: boolean;
    page: number;
    limit: number;
}
export interface GameEnterResponse {
    method: string;
    parames: string;
    developer: string;
    reserve: string;
    weburl: string;
}
export interface GameHistoryItem {
    name: string;
    created_at: number;
    amount: string | number;
    multiplier: string | number;
    bet_id: string | number;
    status: string | number;
    profit: number;
}
export interface GameBigWinItem {
    game_id: string;
    game_name: string;
    game_icon: string;
    user_name: string;
    user_vip_group: number;
    user_vip_level: number;
    bet_amount: string;
    multiplier: string;
    win_amount: string;
    time: number;
}
export interface GameBigWinData {
    high_rollers: Array<HighRollerInfo>;
    lucky_bets: Array<LuckyBetInfo>;
}
export interface GameHistoryResponse {
    total_pages: number;
    record: Array<GameHistoryItem>;
}
export interface GameSearchResponse {
    items: Array<Game>;
    total: number;
}
export type GetGameFavoriteListResponse = {
    code: number;
    data: Array<number | string>;
    message: string;
};
export type GetGameBigWinResponse = {
    code: number;
    data: GameBigWinData;
    message: string;
};
export type Category = {
    name: string;
    games: Game[];
};
export type GetGameCategoriesResponse = {
    code: number;
    data: Array<any>;
    messsage: string;
};
export type GetGameSearchResponse = {
    code: number;
    data: GameSearchResponse;
    message: string;
};
export type GetGameEnterResponse = {
    code: number;
    data: GameEnterResponse;
    gameSession: PrismaGameSession;
    message: string;
};
export type GetGameHistoryResponse = {
    code: number;
    data: GameHistoryResponse;
    message: string;
};
/**
 * Represents a Game Provider.
 * Based on the Prisma 'GameProvider' model.
 */
export interface GameProvider {
    id: string;
    name: string;
    slug: string;
    description?: string | null;
    logo_url?: string | null;
    is_enabled: boolean;
    created_at: Date;
    updated_at: Date;
}
/**
 * Represents a Game. Based on the Prisma 'Game' model.
 */
export interface GameType {
    id: string;
    name: string;
    slug: string;
    provider_id: string;
    category_id?: string | null;
    description?: string | null;
    thumbnail_url?: string | null;
    banner_url?: string | null;
    external_game_id?: string | null;
    tags?: string[];
    rtp?: number | null;
    volatility?: string | null;
    is_active: boolean;
    is_featured?: boolean;
    launch_options?: Record<string, any> | null;
    created_at: Date;
    updated_at: Date;
    provider?: GameProvider;
}
/**
 * Represents a Game Round or history entry.
 * Based on the Prisma 'GameRound' model.
 */
export interface GameSpin {
    id: string;
    user_id: string;
    game_id: string;
    currency_id: string;
    bet_amount: number;
    win_amount: number;
    profit: number;
    external_round_id?: string | null;
    status: string;
    bet_details?: Record<string, any> | null;
    win_details?: Record<string, any> | null;
    created_at: Date;
    updated_at: Date;
    user?: UserProfile;
    game?: GameType;
}
/**
 * Represents a Game Round or history entry.
 * Based on the Prisma 'GameRound' model.
 */
export interface RawGameSpinBody {
    user_id: string;
    game_id: string;
    currency_id: string;
    rawVendorData: any;
    created_at: Date;
}
export interface LaunchGameResponseDto {
    /**
     * The URL to launch the game session.
     * This could be an iframe source or a URL for redirection.
     */
    launch_url: string;
    /**
     * A unique session identifier for this game launch, if provided by the game aggregator or server.
     * Can be used for tracking or further communication related to this session.
     */
    game_session_id?: string;
    /**
     * Any specific strategy for launching the game (e.g., 'IFRAME', 'REDIRECT', 'POPUP').
     * Optional, defaults to client figuring it out or a standard method.
     */
    launch_strategy?: 'IFRAME' | 'REDIRECT' | 'POPUP';
    /**
     * Additional parameters or tokens required by the game provider, serialized as a string
     * or as a nested object.
     * Optional.
     */
    provider_parameters?: Record<string, any> | string;
}
export interface RtgGame {
    win: Win;
    winsMultipliers: Win;
    stake: string;
    multiplier: number;
    winLines: any[];
    spinMode: string;
    fatTiles: FatTile[];
    instantWin: InstantWin;
    actions: Action[];
    scatters: any[];
    reelsBuffer: Array<Array<number[]>>;
    features: any[];
    hasState: boolean;
}
export interface Action {
    type: string;
    data: Data;
}
export interface Data {
    multiplier?: number;
    index?: number;
    fatTiles?: FatTile[];
}
export interface FatTile {
    tileId: number;
    reel: number;
    index: number;
    width: number;
    height: number;
    multiplier: number;
    amount: string;
}
export interface InstantWin {
    multiplier: string;
    amount: string;
    options: string[];
}
export interface Win {
    instantWin: string;
    lines: string;
    total: string;
}
export interface Transactions {
    roundId: number;
}
export interface GamePlatformSpinResultDetails {
    betTransaction: {
        include: {
            originatorUser: {
                select: {
                    id: true;
                    username: true;
                };
            };
        };
    };
    winTransaction?: {
        include: {
            originatorUser: {
                select: {
                    id: true;
                    username: true;
                };
            };
        };
    } | null;
    finalPlatformWallet: PrismaWallet;
    updatedGameSession: PrismaGameSession;
    gameSpinRecord: PrismaGameSpin;
    xpAwardedThisSpin: number;
    tournamentPointsAwardedThisSpin: number;
    winAmountPlatformCents: number;
}
export interface Search {
    id: string;
    name: string;
    image: string;
    developer: string;
    is_demo: boolean;
}
export interface PrismaGameEnterBody {
    id: string | Array<string>;
    demo: boolean;
}
export interface PrismaGameUserBody {
    game_categories_slug: string;
    page: number;
    limit: number;
}
export interface PrismaGameHistoryItem {
    name: string;
    created_at: number;
    amount: string | number;
    multiplier: string | number;
    bet_id: string | number;
    status: string | number;
    profit: number;
}
export interface PrismaGameBigWinItem {
    game_id: string;
    game_name: string;
    game_icon: string;
    user_name: string;
    user_vip_group: number;
    user_vip_level: number;
    bet_amount: string;
    multiplier: string;
    win_amount: string;
    time: number;
}
export interface PrismaGameBigWinData {
    high_rollers: Array<PrismaGameBigWinItem>;
    lucky_bets: Array<PrismaGameBigWinItem>;
}
export interface PrismaGameHistoryResponse {
    total_pages: number;
    record: Array<PrismaGameHistoryItem>;
}
export interface PrismaGameSearchResponse {
    items: Array<Search>;
    total: number;
}
//# sourceMappingURL=game.d.ts.map