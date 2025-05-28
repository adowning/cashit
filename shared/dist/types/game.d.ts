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
    playMode?: 'real' | 'demo';
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
    playMode?: 'real' | 'demo';
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