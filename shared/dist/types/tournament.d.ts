import { Game, PrismaUserProfile, UserProfile } from '../index';
import type { PrismaTournamentParticipant } from './prisma';
export interface TeamBasedTournament {
    id: number;
    history_id: number;
    historyId: number;
    title: string;
    slug: string;
    image: string;
    isActive: boolean;
    currentTime: Date;
    start: string;
    end: string;
    betMin: number;
    betsMin: number;
    duration: string;
    isOpen: boolean;
    startDate: Date;
    startTime: string;
    outplayAttempts: number;
    mode: string;
    winners: UserProfile[];
    isAutoSubscription: boolean;
    betsOn: string;
    betLimit: number;
    minBetLimit: number;
    maxBetLimitShort: string;
    info: string;
    isMajor: boolean;
    prizeLimit: number;
    prizeFund: string;
    prize: string;
    raceType: string;
    prizes: {
        [key: string]: {
            coins: number;
        };
    }[];
    prizeTotal: [coins: number, entries: number];
    additionalPrizes: any[];
    gamesIds: number[];
    games: Game[];
    gameSlug: string;
    totalGamesCount: number;
    isTeamBased: boolean;
    teams: Team[];
    images: Images;
    isVipTournament: boolean;
    isTournamentGame: boolean;
    isSubscribed: boolean;
}
export interface Images {
    imageBanner: string;
    imagePrizeCard: string;
    imageBannerMobile: string;
    bannerDesktop: string;
    bannerMobile: string;
    retinaBannerDesktop: string;
    retinaBannerMobile: string;
}
export interface Team {
    id: number;
    title: string;
    totalPoints: number;
    isPlayerTeam: boolean;
}
export interface TournamentGameInfo {
    gameId: string;
    name: string;
    pointMultiplier: number;
    thumbnailUrl?: string;
}
export interface TournamentRewardInfo {
    id: string;
    rank: number;
    description: string;
    isClaimed: boolean;
    winnerId?: string | null;
    winnerUsername?: string | null;
}
export type TournamentParticipantType = PrismaTournamentParticipant & {
    user: PrismaUserProfile;
};
export interface TournamentCore {
    prizeFund: any;
    id: string;
    name: string;
    description?: string | null;
    startTime: string;
    endTime?: string | null;
    targetScore?: number | null;
    status: TournamentStatus;
    participantCount?: number;
}
export interface TournamentDetailed extends TournamentCore {
    eligibleGames: TournamentGameInfo[];
    rewards: TournamentRewardInfo[];
    participants?: TournamentParticipantInfo[];
    createdBy?: {
        id: string;
        username: string;
    };
    createdAt: string;
    updatedAt: string;
}
export interface TournamentParticipantInfo {
    userId: string;
    username: string;
    avatarUrl?: string | null;
    score: number;
    rank?: number | null;
    joinedAt: string;
}
export interface ListTournamentsRequestQuery {
    status?: TournamentStatus;
    gameId?: string;
    activeNow?: boolean;
}
export type ListTournamentsResponse = TournamentCore[];
export type GetTournamentDetailsResponse = TournamentDetailed;
export interface GetTournamentLeaderboardRequestQuery {
    limit?: number;
    offset?: number;
}
export type GetTournamentLeaderboardResponse = TournamentParticipantInfo[];
export type JoinTournamentResponse = TournamentParticipantInfo;
export interface CreateTournamentAdminRequest {
    name: string;
    description?: string;
    startTime: string;
    endTime?: string;
    targetScore?: number;
    eligibleGames?: Array<{
        gameId: string;
        pointMultiplier?: number;
    }>;
    rewards?: Array<{
        rank: number;
        description: string;
    }>;
}
export type CreateTournamentAdminResponse = TournamentDetailed;
export interface UpdateTournamentAdminRequest {
    name?: string;
    description?: string;
    startTime?: string;
    endTime?: string;
    targetScore?: number;
    status?: TournamentStatus;
    eligibleGames?: Array<{
        gameId: string;
        pointMultiplier?: number;
    }>;
    rewards?: Array<{
        rank: number;
        description: string;
    }>;
}
export type UpdateTournamentAdminResponse = TournamentDetailed;
export interface TournamentCreatedPayload {
    tournamentId: string;
    name: string;
    startTime: string;
}
export interface TournamentStartedPayload {
    tournamentId: string;
    name: string;
    endTime?: string | null;
}
export interface TournamentEndedPayload {
    tournamentId: string;
    name: string;
}
export interface TournamentParticipantJoinedPayload {
    tournamentId: string;
    userId: string;
    username: string;
}
export interface TournamentLeaderboardUpdatedPayload {
    tournamentId: string;
    leaderboard: Array<Pick<TournamentParticipantInfo, 'userId' | 'username' | 'score' | 'rank' | 'avatarUrl'>>;
}
export interface TournamentScoreUpdatedPayload {
    tournamentId: string;
    userId: string;
    newScore: number;
    newRank?: number;
    changeInScore: number;
}
export declare enum TournamentStatus {
    PENDING = "PENDING",
    ACTIVE = "ACTIVE",
    COMPLETED = "COMPLETED",
    CANCELLED = "CANCELLED"
}
//# sourceMappingURL=tournament.d.ts.map