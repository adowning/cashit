import type { Game, GameSession, GameSpin, Wallet } from './prisma';
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
    finalPlatformWallet: Wallet;
    updatedGameSession: GameSession;
    gameSpinRecord: GameSpin;
    xpAwardedThisSpin: number;
    tournamentPointsAwardedThisSpin: number;
}
export type { GameSession };
export type GameCategoryName = 'TABLE' | 'FISH' | 'POKER' | 'SLOTS' | 'OTHER';
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
