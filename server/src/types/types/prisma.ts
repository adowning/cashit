// This file was auto-generated by prisma-generator-typescript-interfaces

export type PrismaGameCategory =
  | "FISH"
  | "POKER"
  | "SLOTS"
  | "TABLE_GAMES"
  | "LIVE_CASINO"
  | "SPORTSBOOK"
  | "VIRTUAL_SPORTS"
  | "LOTTERY"
  | "CRASH"
  | "OTHER";

export type PrismaGameProviderName =
  | "PRAGMATICPLAY"
  | "EVOPLAY"
  | "NETENT"
  | "PLAYNGO"
  | "RELAXGAMING"
  | "HACKSAW"
  | "BGAMING"
  | "SPRIBE"
  | "INTERNAL"
  | "REDTIGER"
  | "NETGAME"
  | "BIGFISHGAMES"
  | "CQNINE"
  | "NOLIMIT"
  | "KICKASS";

export type PrismaProviderAuthType =
  | "API_KEY"
  | "OAUTH2"
  | "JWT_SIGN"
  | "CUSTOM"
  | "NONE";

export type PrismaJackpotType = "MINOR" | "MAJOR" | "GRAND";

export type PrismaPaymentMethod = "INSTORE_CASH" | "INSTORE_CARD" | "CASH_APP";

export type PrismaRole =
  | "USER"
  | "ADMIN"
  | "VIP"
  | "MODERATOR"
  | "SYSTEM"
  | "OWNER"
  | "MEMBER"
  | "OPERATOR"
  | "SUPPORT_AGENT";

export type PrismaKeyMode =
  | "read"
  | "write"
  | "upload"
  | "manage_users"
  | "manage_settings"
  | "launch_game";

export type PrismaInvitationStatus =
  | "PENDING"
  | "ACCEPTED"
  | "DECLINED"
  | "INACTIVE";

export type PrismaTournamentStatus =
  | "PENDING"
  | "ACTIVE"
  | "COMPLETED"
  | "CANCELLED";

export type PrismaTransactionType =
  | "DEPOSIT"
  | "WITHDRAWAL"
  | "BET"
  | "WIN"
  | "TRANSFER_SENT"
  | "TRANSFER_RECEIVED"
  | "SYSTEM_ADJUSTMENT_CREDIT"
  | "SYSTEM_ADJUSTMENT_DEBIT"
  | "TOURNAMENT_BUYIN"
  | "TOURNAMENT_PRIZE"
  | "AFFILIATE_COMMISSION"
  | "REFUND"
  | "FEE"
  | "BONUS_AWARD"
  | "BET_PLACE"
  | "BET_WIN"
  | "BET_LOSE"
  | "BET_REFUND"
  | "BONUS_WAGER"
  | "BONUS_CONVERT"
  | "BONUS_EXPIRED"
  | "XP_AWARD"
  | "ADJUSTMENT_ADD"
  | "ADJUSTMENT_SUB"
  | "INTERNAL_TRANSFER"
  | "PRODUCT_PURCHASE"
  | "REBATE_PAYOUT"
  | "JACKPOT_WIN"
  | "JACKPOT_CONTRIBUTION";

export type PrismaTransactionStatus =
  | "PENDING"
  | "PROCESSING"
  | "COMPLETED"
  | "FAILED"
  | "CANCELLED"
  | "REFUNDED"
  | "EXPIRED"
  | "REJECTED"
  | "REQUIRES_ACTION"
  | "ON_HOLD";

export type PrismaRewardStatus =
  | "AVAILABLE"
  | "CLAIMED"
  | "EXPIRED"
  | "PENDING"
  | "VOIDED";

export type PrismaUser = {
  id: string;
  name: string;
  username: string;
  displayUsername: string;
  email: string;
  emailVerified: boolean;
  image: string | null;
  createdAt: Date;
  updatedAt: Date;
  accounts?: PrismaAccount[];
  sessions?: PrismaSession[];
};

export type PrismaSession = {
  id: string;
  expiresAt: Date;
  token: string;
  createdAt: Date;
  updatedAt: Date;
  ipAddress: string | null;
  userAgent: string | null;
  userId: string;
  user?: PrismaUser;
};

export type PrismaAccount = {
  id: string;
  accountId: string;
  providerId: string;
  userId: string;
  accessToken: string | null;
  refreshToken: string | null;
  idToken: string | null;
  accessTokenExpiresAt: Date | null;
  refreshTokenExpiresAt: Date | null;
  scope: string | null;
  password: string | null;
  createdAt: Date;
  updatedAt: Date;
  user?: PrismaUser;
};

export type PrismaVerification = {
  id: string;
  identifier: string;
  value: string;
  expiresAt: Date;
  createdAt: Date | null;
  updatedAt: Date | null;
};

export type PrismaGame = {
  id: string;
  name: string;
  title: string;
  goldsvetData: JsonValue | null;
  description: string | null;
  supportedProviders: PrismaGameProviderName[];
  category: PrismaGameCategory;
  tags: string[];
  isActive: boolean;
  thumbnailUrl: string | null;
  bannerUrl: string | null;
  meta: JsonValue | null;
  createdAt: Date;
  updatedAt: Date;
  featured: boolean;
  providerName: string | null;
  totalWagered: number;
  gameProviderId: string | null;
  operatorId: string | null;
  tournamentDirectives: JsonValue | null;
  status: boolean;
  checked: boolean;
  tournamentGames?: PrismaTournamentGames[];
  gameLaunchLinks?: PrismaGameLaunchLink[];
  gameSessions?: PrismaGameSession[];
  gameProvider?: PrismaGameProvider | null;
  operator?: PrismaOperator | null;
};

export type PrismaGameSession = {
  id: string;
  isActive: boolean;
  sessionData: JsonValue | null;
  authSessionId: string | null;
  currencyId: string | null;
  startedAt: Date;
  endTime: Date | null;
  startTime: Date | null;
  ipAddress: string | null;
  startingBalance: number | null;
  startingTotalXp: number | null;
  userAgent: string | null;
  createdAt: Date;
  updatedAt: Date;
  totalWagered: number;
  totalWon: number;
  userId: string;
  gameId: string;
  rtgToken: string | null;
  rtgFingerPrint: string | null;
  profileId: string | null;
  game?: PrismaGame;
  refferenceToUserProfile?: PrismaUserProfile;
  spins?: PrismaGameSpin[];
  UserProfile?: PrismaUserProfile[];
};

export type PrismaGameSpin = {
  id: string;
  spinData: JsonValue | null;
  createdAt: Date;
  grossWinAmount: number;
  currencyId: string | null;
  spinNumber: number;
  gameSessionId: string;
  wagerAmount: number;
  sessionId: string;
  timeStamp: Date;
  gameSession?: PrismaGameSession;
  jackpotContributions?: PrismaJackpotContribution[];
  jackpotWin?: PrismaJackpotWin | null;
};

export type PrismaGameProvider = {
  id: string;
  name: string;
  displayName: string | null;
  rgsBaseUrl: string;
  settingsPath: string | null;
  spinPath: string | null;
  resolveBetPath: string | null;
  providerRoundId: string | null;
  authType: PrismaProviderAuthType;
  apiKey: string | null;
  apiSecret: string | null;
  publicKey: string | null;
  privateKeyRef: string | null;
  configJson: JsonValue | null;
  isActive: boolean;
  notes: string | null;
  createdAt: Date;
  updatedAt: Date;
  games?: PrismaGame[];
};

export type PrismaGameLaunchLink = {
  id: string;
  tokenInternal: string;
  currency: string;
  playerOperatorId: string | null;
  mode: string;
  meta: JsonValue | null;
  requestIp: string | null;
  userAgent: string | null;
  sessionUrl: string | null;
  state: string;
  active: boolean;
  expiresAt: Date | null;
  extraMeta: JsonValue | null;
  tokenOriginal: string | null;
  createdAt: Date;
  updatedAt: Date;
  userId: string;
  gameId: string;
  operatorId: string;
  userProfileId: string | null;
  game?: PrismaGame;
  operator?: PrismaOperator;
  UserProfile?: PrismaUserProfile | null;
};

export type PrismaJackpot = {
  id: string;
  type: PrismaJackpotType;
  currentAmountCoins: number;
  seedAmountCoins: number;
  minimumBetCoins: number;
  contributionRateBasisPoints: number;
  probabilityPerMillion: number;
  minimumTimeBetweenWinsMinutes: number;
  lastWonAt: Date | null;
  lastWonBy: string | null;
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
  contributions?: PrismaJackpotContribution[];
  wins?: PrismaJackpotWin[];
  lastWinner?: PrismaUserProfile | null;
};

export type PrismaJackpotContribution = {
  id: string;
  jackpotId: string;
  gameSpinId: string;
  contributionAmountCoins: number;
  createdAt: Date;
  gameSpin?: PrismaGameSpin;
  jackpot?: PrismaJackpot;
};

export type PrismaJackpotWin = {
  id: string;
  jackpotId: string;
  winnerId: string;
  winAmountCoins: number;
  gameSpinId: string;
  transactionId: string | null;
  createdAt: Date;
  gameSpin?: PrismaGameSpin;
  jackpot?: PrismaJackpot;
  transaction?: PrismaTransaction | null;
  winner?: PrismaUserProfile;
};

export type PrismaOperator = {
  id: string;
  name: string;
  operatorSecret: string;
  operatorAccess: string;
  callbackUrl: string;
  active: boolean;
  permissions: PrismaKeyMode[];
  ips: string[];
  description: string | null;
  lastUsedAt: Date | null;
  createdAt: Date;
  updatedAt: Date;
  ownerId: string | null;
  acceptedPayments: PrismaPaymentMethod[];
  gameLaunchLinks?: PrismaGameLaunchLink[];
  games?: PrismaGame[];
  invitations?: PrismaOperatorInvitation[];
  products?: PrismaProduct[];
  transactions?: PrismaTransaction[];
  wallets?: PrismaWallet[];
};

export type PrismaOperatorInvitation = {
  id: string;
  operatorId: string;
  username: string;
  role: PrismaRole;
  token: string;
  expiresAt: Date;
  acceptedAt: Date | null;
  invitedById: string;
  userProfileId: string | null;
  operator?: PrismaOperator;
  invitedUser?: PrismaUserProfile;
};

export type PrismaProduct = {
  id: string;
  title: string;
  description: string;
  url: string;
  iconUrl: string | null;
  productType: string;
  bonusCode: string | null;
  bonusTotalInCredits: number;
  isActive: boolean | null;
  priceInCents: number;
  amountToReceiveInCredits: number;
  bestValue: number;
  discountInCents: number;
  bonusSpins: number;
  isPromo: boolean | null;
  totalDiscountInCents: number;
  shopId: string | null;
  createdAt: Date;
  updatedAt: Date | null;
  transactionId: string | null;
  operator?: PrismaOperator | null;
  Transaction?: PrismaTransaction | null;
  transactions?: PrismaTransaction[];
};

export type PrismaTournament = {
  id: string;
  name: string;
  description: string | null;
  startTime: Date;
  endTime: Date | null;
  targetScore: number | null;
  status: PrismaTournamentStatus;
  createdAt: Date;
  updatedAt: Date;
  createdByid: string | null;
  userId: string | null;
  user?: PrismaUserProfile | null;
  participants?: PrismaTournamentParticipant[];
  rewards?: PrismaTournamentReward[];
  tournamentGames?: PrismaTournamentGames[];
};

export type PrismaTournamentParticipant = {
  id: string;
  tournamentId: string;
  userId: string;
  score: number;
  rank: number | null;
  joinedAt: Date;
  gamePlays?: PrismaTournamentGamePlay[];
  tournament?: PrismaTournament;
  user?: PrismaUserProfile;
};

export type PrismaTournamentGamePlay = {
  id: string;
  tournamentParticipantId: string;
  gameId: string;
  pointsEarned: number;
  playedAt: Date;
  gameSessionId: string | null;
  tournamentParticipant?: PrismaTournamentParticipant;
};

export type PrismaTournamentReward = {
  id: string;
  tournamentId: string;
  rank: number;
  description: string;
  isClaimed: boolean;
  winnerId: string | null;
  tournament?: PrismaTournament;
  winner?: PrismaUserProfile | null;
};

export type PrismaTournamentGames = {
  A: string;
  B: string;
  games?: PrismaGame;
  tournament?: PrismaTournament;
};

export type PrismaTransaction = {
  id: string;
  processedAt: Date | null;
  walletId: string | null;
  type: PrismaTransactionType;
  status: PrismaTransactionStatus;
  amount: number;
  netAmount: number | null;
  feeAmount: number | null;
  productId: string | null;
  paymentMethod: PrismaPaymentMethod | null;
  balanceBefore: number | null;
  balanceAfter: number | null;
  bonusBalanceBefore: number | null;
  bonusBalanceAfter: number | null;
  bonusAmount: number | null;
  wageringRequirement: number | null;
  wageringProgress: number | null;
  description: string | null;
  provider: string | null;
  providerTxId: string | null;
  relatedGameId: string | null;
  relatedRoundId: string | null;
  metadata: JsonValue | null;
  createdAt: Date;
  updatedAt: Date;
  userProfileId: string | null;
  operatorId: string | null;
  jackpotWins?: PrismaJackpotWin[];
  products?: PrismaProduct[];
  rebateGenerated?: PrismaRebateTransaction | null;
  operator?: PrismaOperator | null;
  product?: PrismaProduct | null;
  userProfile?: PrismaUserProfile | null;
  wallet?: PrismaWallet | null;
};

export type PrismaRebateTransaction = {
  id: string;
  userId: string;
  transactionId: string;
  rebateAmount: number;
  currencyId: string;
  vipLevel: number;
  rebatePercentage: number;
  status: PrismaRewardStatus;
  paidOutAt: Date | null;
  createdAt: Date;
  updatedAt: Date;
  originalTransaction?: PrismaTransaction;
  user?: PrismaUserProfile;
};

export type PrismaWallet = {
  id: string;
  balance: number;
  isActive: boolean;
  address: string | null;
  createdAt: Date;
  updatedAt: Date;
  userId: string;
  operatorId: string;
  paymentMethod: PrismaPaymentMethod;
  bonusBalance: number;
  lockedBalance: number;
  transactions?: PrismaTransaction[];
  operator?: PrismaOperator;
  user?: PrismaUserProfile;
  cashtag: string | null;
};

export type PrismaUserProfile = {
  id: string;
  createdAt: Date;
  updatedAt: Date;
  username: string;
  avatar: string | null;
  cashtag: string | null;
  balance: number;
  totalXpFromOperator: number;
  activeCurrencyType: string;
  lastDailySpin: Date;
  userId: string;
  isActive: boolean;
  otherUserid: string | null;
  role: PrismaRole | null;
  operatorId: string | null;
  currentGameSessionid: string | null;
  vipInfoId: string;
  tournament?: PrismaTournament[];
  tournamentParticipant?: PrismaTournamentParticipant[];
  tournamentReward?: PrismaTournamentReward[];
  gameLaunchLink?: PrismaGameLaunchLink[];
  pastGameSessions?: PrismaGameSession[];
  jackpotWins?: PrismaJackpotWin[];
  lastJackpotWon?: PrismaJackpot[];
  operatorInvitations?: PrismaOperatorInvitation[];
  rebateTransactions?: PrismaRebateTransaction[];
  transactions?: PrismaTransaction[];
  currentGameSession?: PrismaGameSession | null;
  vipInfo?: PrismaVipInfo;
  wallets?: PrismaWallet[];
};

export type PrismaVipInfo = {
  id: string;
  createdAt: Date;
  updatedAt: Date;
  username: string;
  avatar: string | null;
  userId: string;
  level: number;
  currentLevelXp: number;
  totalXp: number;
  dailyBonusClaimedAt: Date | null;
  weeklyBonusClaimedAt: Date | null;
  monthlyBonusClaimedAt: Date | null;
  cashbackPercentage: number;
  userProfile?: PrismaUserProfile | null;
};

type JsonValue =
  | string
  | number
  | boolean
  | { [key in string]?: JsonValue }
  | Array<JsonValue>
  | null;
