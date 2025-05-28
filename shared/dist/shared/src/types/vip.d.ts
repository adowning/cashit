export interface LevelBenefit {
    id: string;
    name: string;
    description: string;
}
export interface LevelConfig {
    level: number;
    name: string;
    xpRequired: number;
    cumulativeXpToReach: number;
    cashbackPercentage: number;
    prioritySupport: boolean;
    initialSpecialBonuses?: number;
    dailyBonusMultiplier?: number;
    weeklyBonusAmount?: number;
    monthlyBonusPackage?: string;
    benefits: LevelBenefit[];
}
export interface UserVipDetails {
    level: number;
    currentLevelXp: number;
    totalXp: number;
    xpToNextLevel: number;
    nextLevelXpRequired: number;
    cashbackPercentage: number;
    prioritySupport: boolean;
    specialBonusesAvailable: number;
    lastDailyBonusClaim?: Date | null;
    lastWeeklyBonusClaim?: Date | null;
    lastMonthlyBonusClaim?: Date | null;
}
export interface LevelBenefitInfo {
    id: string;
    name: string;
    description: string;
}
export interface SharedLevelConfig {
    level: number;
    name: string;
    xpRequiredToComplete: number;
    cumulativeXpToEnter: number;
    cashbackPercentage: number;
    prioritySupport: boolean;
    benefits: LevelBenefitInfo[];
    levelUpRewardDescription?: string;
    dailyRewardDescription?: string;
    weeklyRewardDescription?: string;
    monthlyRewardDescription?: string;
}
export interface SignInRewardConfig {
    day: number;
    description: string;
    amount?: number;
    currencyId?: string;
    xp?: number;
}
export interface VipSignInStatusInfo {
    currentStreak: number;
    todayClaimed: boolean;
    rewards: SignInRewardConfig[];
    nextRewardForToday?: SignInRewardConfig;
}
export interface VipTaskInfo {
    id: string;
    taskType: string;
    description: string;
    xpReward?: number | null;
    targetValue?: number | null;
    currentProgress: number;
    isCompleted: boolean;
    isClaimed: boolean;
}
export interface RebateHistoryEntry {
    id: string;
    date: Date;
    originalTransactionId: string;
    rebateAmount: number;
    currencyId: string;
    status: string;
    paidOutAt?: Date | null;
}
export interface LevelUpRewardInfo {
    level: number;
    description: string;
    amount?: number | null;
    currencyId?: string | null;
    status: string;
    claimedAt?: Date | null;
}
export interface PaginatedResponse<T> {
    items: T[];
    total: number;
    page?: number;
    limit?: number;
    totalPages?: number;
    hasNextPage?: boolean;
    hasPrevPage?: boolean;
}
