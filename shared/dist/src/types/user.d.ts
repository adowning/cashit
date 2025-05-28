import { UserProfile } from '../index';
import type { Currency, Profile, UserReward } from './prisma';
export type Email = string;
export type Username = string;
/**
 * Represents the primary, comprehensive User object structure returned by the backend
 * upon authentication and used throughout the client (e.g., authStore.currentUser).
 * This is based on the Prisma 'User' model, potentially augmented with essential related data.
 */
/**
 * DTO for client to send updates for their user profile.
 * Contains only the fields a user is allowed to modify directly.
 */
export interface UpdateUserInput {
    username?: Username;
    avatar_url?: string;
    first_name?: string;
    last_name?: string;
    date_of_birth?: string;
}
/**
 * DTO for client to update their email address.
 * Requires current password for verification.
 */
export interface UpdateEmailDto {
    _email: Email;
    password: string;
}
/**
 * DTO for client to update their cashtag (or similar payment identifier).
 * Requires current password for verification.
 */
export interface UpdateCashtagDto {
    cashtag: string;
    password: string;
}
/**
 * DTO for client to change their password.
 */
export interface UpdatePasswordDto {
    current_password: string;
    password: string;
}
export interface ClientClaimVipRewardPayload {
    benefit_id: string;
}
/**
 * DTO for client to set their referrer.
 */
export interface SetReferrerDto {
    referrerCode: string;
}
/**
 * DTO for client to tip another user.
 */
export interface TipUserDto {
    recipientUsername: Username;
    amount: number;
    currency_id: string;
}
/**
 * Detailed user profile information, potentially from a dedicated profile endpoint.
 * This might differ from the primary UserProfile if it includes more specific or formatted data.
 * Review and align with your actual API response for fetching detailed user profiles.
 */
export interface DetailedUserProfile {
    uid: string;
    username: Username;
    avatar_url?: string | null;
    first_name?: string | null;
    last_name?: string | null;
    email: Email;
    is_email_confirmed: boolean;
    phone?: string | null;
    is_phone_confirmed: boolean;
    date_of_birth?: string | null;
    country?: string | null;
    state?: string | null;
    city?: string | null;
    address?: string | null;
    postal_code?: string | null;
    language?: string | null;
    locale?: string | null;
    is_initial_profile_complete: boolean;
    is_suspended: boolean;
    created_at: string;
}
export interface GetSessionResponse {
    access_token: string;
    code: number;
    status: number;
    user: UserProfile;
}
/**
 * Response structure when fetching detailed user information.
 */
export interface GetDetailedUserProfileResponse {
    user_profile: DetailedUserProfile;
}
/**
 * Represents a User's Balance for a specific currency.
 * Based on the Prisma 'Balance' model.
 */
export interface BalanceType {
    Currency?: Currency;
}
export interface UserBalanceDetails {
    currency_id: string;
    currency_name: string;
    currency_symbol: string;
    total_amount: string;
    available_balance: string;
    real_balance: string;
    bonus_balance: string;
}
/**
 * DTO representing the user's detailed VIP status and benefits.
 */
export interface UserVipStatus {
    level: number;
    currentLevelName: string;
    currentPoints: number;
    pointsToNextLevel?: number;
    nextLevel?: number;
    nextLevelName?: string;
    progressPercentage?: number;
    benefits: UserReward[];
}
export interface ProfileStatsUpdateData {
    balance: string;
    createdAt: string;
    currency_id: string;
    id: string;
    isActive: boolean;
    lastPlayed: string;
    updatedAt?: string | null;
    user_id: string;
    xpEarned: number;
}
export interface UserStatsUpdateData {
    balance_cash_change?: string;
    balance_bonus_change?: string;
    total_xp_change?: number;
}
export interface StatsUpdate {
    table: 'User' | 'Profile' | 'Balance' | string;
    row_id: string;
    operation: 'UPDATE' | 'INSERT' | 'DELETE';
    data: Partial<UserStatsUpdateData | ProfileStatsUpdateData | Profile | BalanceType>;
    event_id?: string;
}
//# sourceMappingURL=user.d.ts.map