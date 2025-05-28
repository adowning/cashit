import { UserProfile } from '../index';
import type { TournamentParticipant } from './prisma';
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
export type TournamentParticipantType = TournamentParticipant & {
    user: UserProfile;
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