// server/src/config/leveling.config.ts

export interface LevelConfig {
  level: number
  name: string
  xpRequired: number // XP needed to complete THIS level
  cumulativeXpToReach: number // Total XP needed to ENTER this level
  cashbackPercentage: number
  prioritySupport: boolean
  dailyBonusMultiplier: number
  weeklyBonusAmount?: number
  monthlyBonusPackage?: string
  initialSpecialBonuses?: number
  benefits: string[]
}

// VIP Level Configuration
const LEVEL_CONFIGS: LevelConfig[] = [
  {
    level: 0,
    name: "Newcomer",
    xpRequired: 100,
    cumulativeXpToReach: 0,
    cashbackPercentage: 0,
    prioritySupport: false,
    dailyBonusMultiplier: 1.0,
    benefits: ["Basic account features"]
  },
  {
    level: 1,
    name: "Bronze I",
    xpRequired: 200,
    cumulativeXpToReach: 100,
    cashbackPercentage: 1,
    prioritySupport: false,
    dailyBonusMultiplier: 1.1,
    weeklyBonusAmount: 500,
    benefits: ["1% cashback", "Weekly bonus", "10% XP boost"]
  },
  {
    level: 2,
    name: "Bronze II",
    xpRequired: 300,
    cumulativeXpToReach: 300,
    cashbackPercentage: 2,
    prioritySupport: false,
    dailyBonusMultiplier: 1.2,
    weeklyBonusAmount: 750,
    benefits: ["2% cashback", "Increased weekly bonus", "20% XP boost"]
  },
  {
    level: 3,
    name: "Silver I",
    xpRequired: 500,
    cumulativeXpToReach: 600,
    cashbackPercentage: 3,
    prioritySupport: false,
    dailyBonusMultiplier: 1.3,
    weeklyBonusAmount: 1000,
    initialSpecialBonuses: 2500,
    benefits: ["3% cashback", "Level up bonus", "Priority game access", "30% XP boost"]
  },
  {
    level: 4,
    name: "Silver II",
    xpRequired: 750,
    cumulativeXpToReach: 1100,
    cashbackPercentage: 4,
    prioritySupport: false,
    dailyBonusMultiplier: 1.4,
    weeklyBonusAmount: 1500,
    benefits: ["4% cashback", "Enhanced weekly bonus", "40% XP boost"]
  },
  {
    level: 5,
    name: "Gold I",
    xpRequired: 1000,
    cumulativeXpToReach: 1850,
    cashbackPercentage: 5,
    prioritySupport: true,
    dailyBonusMultiplier: 1.5,
    weeklyBonusAmount: 2000,
    monthlyBonusPackage: "gold_starter",
    initialSpecialBonuses: 5000,
    benefits: ["5% cashback", "Priority support", "Monthly bonus package", "50% XP boost"]
  },
  {
    level: 6,
    name: "Gold II",
    xpRequired: 1500,
    cumulativeXpToReach: 2850,
    cashbackPercentage: 6,
    prioritySupport: true,
    dailyBonusMultiplier: 1.6,
    weeklyBonusAmount: 2500,
    monthlyBonusPackage: "gold_advanced",
    benefits: ["6% cashback", "Enhanced monthly package", "60% XP boost"]
  },
  {
    level: 7,
    name: "Platinum I",
    xpRequired: 2000,
    cumulativeXpToReach: 4350,
    cashbackPercentage: 7,
    prioritySupport: true,
    dailyBonusMultiplier: 1.7,
    weeklyBonusAmount: 3000,
    monthlyBonusPackage: "platinum_starter",
    initialSpecialBonuses: 10000,
    benefits: ["7% cashback", "Platinum perks", "Exclusive tournaments", "70% XP boost"]
  },
  {
    level: 8,
    name: "Platinum II",
    xpRequired: 2500,
    cumulativeXpToReach: 6350,
    cashbackPercentage: 8,
    prioritySupport: true,
    dailyBonusMultiplier: 1.8,
    weeklyBonusAmount: 4000,
    monthlyBonusPackage: "platinum_advanced",
    benefits: ["8% cashback", "Enhanced platinum perks", "80% XP boost"]
  },
  {
    level: 9,
    name: "Diamond I",
    xpRequired: 3000,
    cumulativeXpToReach: 8850,
    cashbackPercentage: 10,
    prioritySupport: true,
    dailyBonusMultiplier: 2.0,
    weeklyBonusAmount: 5000,
    monthlyBonusPackage: "diamond_starter",
    initialSpecialBonuses: 20000,
    benefits: ["10% cashback", "Diamond status", "Personal account manager", "100% XP boost"]
  },
  {
    level: 10,
    name: "Diamond Elite",
    xpRequired: 5000,
    cumulativeXpToReach: 11850,
    cashbackPercentage: 12,
    prioritySupport: true,
    dailyBonusMultiplier: 2.5,
    weeklyBonusAmount: 7500,
    monthlyBonusPackage: "diamond_elite",
    initialSpecialBonuses: 50000,
    benefits: ["12% cashback", "Elite status", "Exclusive events", "Custom rewards", "150% XP boost"]
  }
]

/**
 * Get level configuration for a specific level
 */
export function getVipLevelConfiguration(level: number): LevelConfig | null {
  return LEVEL_CONFIGS.find(config => config.level === level) || null
}

/**
 * Get all level configurations
 */
export function getAllVipLevelConfigurations(): LevelConfig[] {
  return [...LEVEL_CONFIGS]
}

/**
 * Get the next level configuration
 */
export function getNextLevelConfiguration(currentLevel: number): LevelConfig | null {
  return getVipLevelConfiguration(currentLevel + 1)
}

/**
 * Calculate total XP required to reach a specific level
 */
export function getTotalXpRequiredForLevel(targetLevel: number): number {
  const levelConfig = getVipLevelConfiguration(targetLevel)
  return levelConfig?.cumulativeXpToReach || 0
}

/**
 * Find what level a user should be based on their total XP
 */
export function getLevelFromTotalXp(totalXp: number): number {
  let level = 0
  
  for (const config of LEVEL_CONFIGS) {
    if (totalXp >= config.cumulativeXpToReach) {
      level = config.level
    } else {
      break
    }
  }
  
  return level
}

/**
 * Calculate XP progress within current level
 */
export function getXpProgressInLevel(totalXp: number, currentLevel: number): {
  currentLevelXp: number
  xpRequiredForLevel: number
  progressPercentage: number
} {
  const currentLevelConfig = getVipLevelConfiguration(currentLevel)
  const nextLevelConfig = getVipLevelConfiguration(currentLevel + 1)
  
  if (!currentLevelConfig) {
    return { currentLevelXp: 0, xpRequiredForLevel: 0, progressPercentage: 0 }
  }
  
  const xpIntoCurrentLevel = totalXp - currentLevelConfig.cumulativeXpToReach
  const xpRequiredForLevel = nextLevelConfig?.xpRequired || 0
  const progressPercentage = xpRequiredForLevel > 0 ? (xpIntoCurrentLevel / xpRequiredForLevel) * 100 : 100
  
  return {
    currentLevelXp: xpIntoCurrentLevel,
    xpRequiredForLevel,
    progressPercentage: Math.min(100, Math.max(0, progressPercentage))
  }
}

/**
 * Get level up rewards for reaching a specific level
 */
export function getLevelUpRewards(level: number): {
  cashBonus?: number
  specialBonuses?: number
  newBenefits: string[]
} {
  const levelConfig = getVipLevelConfiguration(level)
  
  if (!levelConfig) {
    return { newBenefits: [] }
  }
  
  return {
    specialBonuses: levelConfig.initialSpecialBonuses,
    newBenefits: levelConfig.benefits
  }
}

/**
 * Check if a level has priority support
 */
export function hasPrioritySupport(level: number): boolean {
  const config = getVipLevelConfiguration(level)
  return config?.prioritySupport || false
}

/**
 * Get cashback percentage for a level
 */
export function getCashbackPercentage(level: number): number {
  const config = getVipLevelConfiguration(level)
  return config?.cashbackPercentage || 0
}

/**
 * Get XP multiplier for a level
 */
export function getXpMultiplier(level: number): number {
  const config = getVipLevelConfiguration(level)
  return config?.dailyBonusMultiplier || 1.0
}
