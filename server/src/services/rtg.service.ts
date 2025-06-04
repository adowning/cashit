// server/src/services/game.service.ts
import { Context } from 'hono'
// Removed unused imports from shared
import {
  UserProfile,
  RTGSettingsResponseDto,
  RtgSpinResult,
  ProviderSpinResponseData,
  GamePlatformSpinResultDetails,
  RTGSpinRequestDto,
} from 'shared'
import prisma from '../../prisma/index' // Your extended Prisma client
const db = prisma // Alias for consistency
// import * as TransactionService from './transaction.service' // Not used in current implementation
import * as XpService from './xp.service'
import * as TournamentService from './tournament.service'
import { GameSpinService } from './game-spin.service'
import {
  GameProviderName,
  Prisma,
  Transaction,
  TransactionStatus,
  TransactionType,
  Wallet,
} from 'prisma/generated/client'
import { Session, User } from 'better-auth'
import { typedAppEventEmitter, AppEvents } from '@/lib/events'
import {
  getOrCreateWallet,
  createTransactionRecord,
  updateWalletBalance,
} from '@/services/transaction.service'

// --- Game Provider Configurations ---
interface GameProviderConfig {
  rgsBaseUrl: string
  apiKey?: string
  settingsPath: (providerGameId: string) => string
  spinPath: (providerGameId: string) => string
  providerUserIdPrefix?: string
  extraHeaders?: Record<string, string>
}

const PROVIDER_CONFIGS_FALLBACK: Record<string, GameProviderConfig> = {
  RTG: {
    rgsBaseUrl: process.env.RTG_RGS_BASE_URL || 'https://rgs.rtg.example.com/api',
    apiKey: process.env.RTG_API_KEY,
    settingsPath: (providerGameId: string) => `/client/${providerGameId}/settings`,
    spinPath: (providerGameId: string) => `/client/${providerGameId}/spin`,
    providerUserIdPrefix: 'rtg_',
  },
}

export async function getProviderConfig(providerNameStr: string): Promise<GameProviderConfig> {
  const providerEnumKey = providerNameStr.toUpperCase() as keyof typeof GameProviderName
  const provider = await prisma.gameProvider.findUnique({
    where: { name: GameProviderName[providerEnumKey] || providerNameStr },
  })

  if (provider && provider.rgsBaseUrl) {
    const configJson = provider.configJson as any
    return {
      rgsBaseUrl: provider.rgsBaseUrl,
      apiKey: provider.apiKey || undefined,
      settingsPath: (providerGameId: string) =>
        `${provider.settingsPath || ''}${providerGameId ? '/' + providerGameId : ''}`,
      spinPath: (providerGameId: string) =>
        `${provider.spinPath || ''}${providerGameId ? '/' + providerGameId : ''}`,
      providerUserIdPrefix:
        (configJson?.providerUserIdPrefix as string) || `${providerNameStr.toLowerCase()}_`,
      extraHeaders: (configJson?.extraHeaders as Record<string, string>) || undefined,
    }
  }
  const fallbackConfig = PROVIDER_CONFIGS_FALLBACK[providerNameStr.toUpperCase()]
  if (!fallbackConfig) {
    throw new Error(`Configuration for game provider "${providerNameStr}" not found.`)
  }
  return fallbackConfig
}

export function toCents(amountFloat: number | string): number {
  if (typeof amountFloat === 'string') amountFloat = parseFloat(amountFloat)
  if (isNaN(amountFloat)) throw new Error('Invalid amount for toCents conversion')
  return Math.round(amountFloat * 100)
}

export function fromCentsToFloat(amountInCents: number): number {
  return amountInCents / 100
}

export class RgsProxyError extends Error {
  constructor(
    message: string,
    public status?: number,
    public providerDetails?: any
  ) {
    super(message)
    this.name = 'RgsProxyError'
  }
}

export interface CreateTransactionArgs {
  userId: string // Originator of the transaction
  receiverId?: string | null // For P2P, commissions, etc.
  type: TransactionType
  status: TransactionStatus
  amountInCents: number
  currencyId: string
  description?: string
  provider?: string
  providerTxId?: string
  walletId?: string // Originator's wallet ID
  productId?: string | null // Link to a product if applicable
  metadata?: Prisma.InputJsonValue
  balanceBeforeInCents?: number
  balanceAfterInCents?: number
  bonusAmountInCents?: number
  bonusBalanceBeforeInCents?: number
  bonusBalanceAfterInCents?: number
}
export interface CreateTransactionArgs {
  userId: string
  receiverId?: string | null
  type: TransactionType
  status: TransactionStatus
  amountInCents: number
  currencyId: string
  description?: string
  provider?: string
  providerTxId?: string
  walletId?: string
  productId?: string | null
  metadata?: Prisma.InputJsonValue
  balanceBeforeInCents?: number
  balanceAfterInCents?: number
  bonusAmountInCents?: number
  bonusBalanceBeforeInCents?: number
  bonusBalanceAfterInCents?: number
  gameId?: string | null // ADDED: For linking to PlatformGame (maps to relatedGameId in schema)
  roundId?: string | null // ADDED: For game round ID (maps to relatedRoundId in schema)
  // relatedTransactionId?: string | null; // REMOVED: Schema doesn't have a direct self-relation like this. Use specific linking if needed via metadata or providerTxId patterns.
}

// async function updateWalletBalance(
//   walletId: string,
//   amountInCents: number, // Amount is the DELTA in cents
//   balanceType: 'balance' | 'bonusBalance' | 'lockedBalance' = 'balance',
//   tx: any
// ): Promise<Wallet> {
//   const wallet = await tx.wallet.findUniqueOrThrow({ where: { id: walletId } })
//   let newBalanceValue: number
//   const updateData: Prisma.WalletUpdateInput = {}

//   switch (balanceType) {
//     case 'balance':
//       newBalanceValue = wallet.balance + amountInCents
//       if (amountInCents < 0 && newBalanceValue < 0) {
//         throw new Error('Insufficient real balance.')
//       }
//       updateData.balance = newBalanceValue
//       break
//     case 'bonusBalance':
//       newBalanceValue = wallet.bonusBalance + amountInCents
//       if (amountInCents < 0 && newBalanceValue < 0) {
//         throw new Error('Insufficient bonus balance.')
//       }
//       updateData.bonusBalance = newBalanceValue
//       break
//     case 'lockedBalance':
//       newBalanceValue = wallet.lockedBalance + amountInCents
//       if (amountInCents < 0 && newBalanceValue < 0) {
//         throw new Error('Insufficient locked funds to release.')
//       }
//       updateData.lockedBalance = newBalanceValue
//       break
//     default:
//       throw new Error('Invalid balance type specified.')
//   }
//   return tx.wallet.update({ where: { id: walletId }, data: updateData })
// }

// async function createTransactionRecord(
//   args: CreateTransactionArgs,
//   tx?: any // Corrected name from Prisma.TransactionClient
// ): Promise<Transaction> {
//   const db = tx || prisma
//   const {
//     // ... other fields
//     gameId, // Destructure new field
//     roundId, // Destructure new field
//   } = args

//   const createInput: Prisma.TransactionCreateInput = {
//     // ... existing assignments ...
//     description: args.description, // Ensure this is explicitly passed
//     provider: args.provider,
//     providerTxId: args.providerTxId,
//     metadata: args.metadata || Prisma.JsonNull,
//     balanceBefore: args.balanceBeforeInCents,
//     balanceAfter: args.balanceAfterInCents,
//     bonusAmount: args.bonusAmountInCents,
//     bonusBalanceBefore: args.bonusBalanceBeforeInCents,
//     bonusBalanceAfter: args.bonusBalanceAfterInCents,
//     type: 'BET',
//     amount: 0,
//   }
//   // ... (originator, receiver, wallet, product connections) ...

//   if (args.userId) createInput.UserProfile = { connect: { id: args.userId } }
//   // if (args.currencyId) createInput.currency = { connect: { id: args.currencyId } }

//   if (gameId) {
//     // ADDED: Map to relatedGameId
//     createInput.relatedGameId = gameId
//   }
//   if (roundId) {
//     // ADDED: Map to relatedRoundId
//     createInput.relatedRoundId = roundId
//   }

//   // ... rest of the function ...
//   const transaction = await db.transaction.create({ data: createInput })

//   typedAppEventEmitter.emit(AppEvents.TRANSACTION_CREATED, {
//     userId: args.userId, // Use args.userId
//     transactionId: transaction.id,
//     transactionType: args.type, // Use args.type
//     newStatus: args.status, // Use args.status
//     amount: args.amountInCents,
//     currencyId: args.currencyId, // Use args.currencyId
//   })

//   return transaction
// }
// async function getOrCreateWallet(
//   userId: string,
//   currencyId: string,
//   operatorId: string,
//   tx?: any
// ): Promise<Wallet> {
//   const db = tx || prisma
//   console.log(userId, currencyId, operatorId)
//   let wallet = await db.wallet.findFirst({
//     where: { AND: [{ userId: userId }, { operatorId: operatorId }] },
//   })
//   if (!wallet || wallet == null) {
//     wallet = await db.wallet.create({
//       data: {
//         balance: 0, // Represents cents
//         bonusBalance: 0, // Represents cents
//         paymentMethod: 'CASH_APP',
//         lockedBalance: 0, // Represents cents
//         operator: {
//           connect: {
//             id: operatorId,
//           },
//         },
//         user: {
//           connect: {
//             id: userId,
//           },
//         },
//       },
//     })
//     console.log(wallet)
//   }
//   console.log(wallet)
//   return wallet
// }
export async function proxyRequestToRgs<_TRequest, TResponse>(
  // providerName: string,
  _rgsUrlPath: string,
  _method: 'GET' | 'POST' | 'PUT' = 'POST',
  _requestBody?: any,
  _platformUserToken?: string
): Promise<TResponse> {
  //   const config = await getProviderConfig(providerName)
  //   // URL would be: `${config.rgsBaseUrl}${rgsUrlPath}`
  const headers = new Headers({ 'Content-Type': 'application/json', Accept: 'application/json' })
  //   if (config.apiKey) headers.append('X-Api-Key', config.apiKey)
  //   if (_platformUserToken) headers.append('X-Platform-Session-Token', _platformUserToken)
  //   Object.entries(config.extraHeaders || {}).forEach(([key, value]) => headers.append(key, value))

  // console.log(
  //   `[${providerName} Proxy] Request: ${method} ${url}`,
  //   process.env.NODE_ENV === 'development' ? requestBody : '{body redacted}'
  // )
  const response = await fetch(
    `https://gserver-rtg.redtiger.com/rtg/platform/game/${_rgsUrlPath}`,
    {
      method: _method,
      headers,
      body: _requestBody ? JSON.stringify(_requestBody) : undefined,
    }
  )
  console.log(response)
  let responseText
  try {
    responseText = await response.json()
    console.log(responseText)

    if (!response.ok) {
      let errorJson: any = { message: responseText }
      try {
        errorJson = JSON.parse(responseText)
      } catch (e) {
        /* ignore */
      }
      throw new RgsProxyError(
        `RGS Error for RTG (${response.status}): ${errorJson.message || responseText}`,
        response.status,
        errorJson
      )
    }
    const responseData = responseText //JSON.parse(responseText)
    console.log(
      `[RTG Proxy] Response:`,
      process.env.NODE_ENV === 'development' ? responseData : '{response redacted}'
    )
    return responseData
  } catch (e: any) {
    throw new RgsProxyError(`RGS response not valid JSON.`, 500, {
      responseText,
      parseError: e.message,
    })
  }
}

export interface HandlePlatformGameRoundParams {
  userId: string
  platformGameId: string
  providerName: string
  providerGameId: string
  providerRoundId?: string
  providerSessionId: string
  wagerAmountCents: number
  winAmountCents: number
  currencyId: string
  rgsRawResponse: object
  operatorId: string
  user: UserProfile
}

export async function handlePlatformGameRound(
  params: HandlePlatformGameRoundParams,
  tx: Prisma.TransactionClient
): Promise<GamePlatformSpinResultDetails> {
  const {
    userId,
    platformGameId,
    providerName,
    providerGameId,
    providerRoundId,
    providerSessionId,
    wagerAmountCents,
    winAmountCents,
    currencyId,
    rgsRawResponse,
    operatorId,
    user: _user,
  } = params
  console.log('params', params)
  const wallet = await getOrCreateWallet(userId, currencyId, operatorId, tx)
  const balanceBeforeBetCents = toCents(wallet.balance)

  const betTransaction = await createTransactionRecord(
    {
      userId,
      type: TransactionType.BET,
      status: TransactionStatus.COMPLETED,
      amountInCents: wagerAmountCents,
      operatorId,
      description: `Bet on ${providerName} game ${providerGameId}, round ${providerRoundId || 'N/A'}`,
      provider: providerName,
      providerTxId: providerRoundId || `bet-${platformGameId}-${Date.now()}`,
      gameId: platformGameId,
      balanceBeforeInCents: balanceBeforeBetCents,
    },
    tx
  )
  await tx.transaction.update({
    where: { id: betTransaction.id },
    data: { relatedGameId: platformGameId },
  })

  let currentWalletState = await updateWalletBalance(wallet.id, -wagerAmountCents, 'balance', tx)
  await tx.transaction.update({
    where: { id: betTransaction.id },
    data: { balanceAfter: toCents(currentWalletState.balance) },
  })

  let winTransactionData: any = null
  // Note: We'll update this after jackpot processing to include jackpot wins

  let gameSession = await tx.gameSession.findFirst({
    where: { userId, gameId: platformGameId, isActive: true },
  })

  const sessionUpdateData: Prisma.GameSessionUpdateArgs['data'] = {
    totalWagered: { increment: wagerAmountCents },
    totalWon: { increment: winAmountCents },
    isActive: true,
  }

  if (gameSession) {
    gameSession = await tx.gameSession.update({
      where: { id: gameSession.id },
      data: sessionUpdateData,
    })
  } else {
    console.warn(
      `[PlatformRound] GameSession with authSessionId ${providerSessionId} not found. Creating.`
    )
    gameSession = await tx.gameSession.create({
      data: {
        userId,
        gameId: platformGameId,
        authSessionId: providerSessionId,
        currencyId,
        startingBalance: balanceBeforeBetCents,
        totalWagered: wagerAmountCents,
        totalWon: winAmountCents,
        isActive: true,
        startTime: new Date(),
      },
    })
  }

  const gameSpinRecord = await tx.gameSpin.create({
    data: {
      gameSessionId: gameSession.id,
      wagerAmount: wagerAmountCents,
      grossWinAmount: winAmountCents,
      currencyId,
      spinData: {
        providerRoundId: providerRoundId || `spin-${Date.now()}`,
        rgsRawResponse,
      } as Prisma.JsonObject,
      timeStamp: new Date(),
      sessionId: providerSessionId,
    },
  })

  // Jackpot processing will be moved outside transaction to avoid timeout
  let totalWinAmountCents = winAmountCents

  // Create win transaction for base winnings (jackpot will be processed separately)
  if (totalWinAmountCents > 0) {
    const winDescription = `Win on ${providerName} game ${providerGameId}, round ${providerRoundId || 'N/A'}`

    const createdWinTx = await createTransactionRecord(
      {
        userId,
        type: TransactionType.WIN,
        status: TransactionStatus.COMPLETED,
        amountInCents: totalWinAmountCents,
        operatorId,
        description: winDescription,
        provider: providerName,
        providerTxId: providerRoundId
          ? `win-${providerRoundId}`
          : `win-${platformGameId}-${Date.now()}`,
        gameId: platformGameId,
        balanceBeforeInCents: toCents(currentWalletState.balance),
      },
      tx
    )
    await tx.transaction.update({
      where: { id: createdWinTx.id },
      data: {
        relatedGameId: platformGameId,
        metadata: {
          gameSpinId: gameSpinRecord.id,
        } as Prisma.JsonObject,
      },
    })
    currentWalletState = await updateWalletBalance(wallet.id, totalWinAmountCents, 'balance', tx)
    winTransactionData = await tx.transaction.update({
      where: { id: createdWinTx.id },
      data: { balanceAfter: toCents(currentWalletState.balance) },
    })
  }

  let xpAwardedThisSpin = 0
  if (_user.vipInfo) {
    xpAwardedThisSpin = XpService.calculateXpForWager(
      fromCentsToFloat(wagerAmountCents),
      _user.vipInfo
    )
    if (xpAwardedThisSpin > 0) {
      await XpService.addXpToUser(
        userId,
        xpAwardedThisSpin,
        `GAME_WAGER_${providerName.toUpperCase()}`,
        gameSpinRecord.id,
        undefined, // Corrected: meta: JsonObject | undefined (pass undefined instead of null)
        tx
      )
    }
  }

  // Tournament points will be recorded outside the transaction to avoid timeout
  let tournamentPointsAwardedThisSpin = 0
  const pointsForTournament = Math.floor(wagerAmountCents / 100)
  if (pointsForTournament > 0 && gameSession?.id) {
    tournamentPointsAwardedThisSpin = pointsForTournament
  }

  return {
    betTransaction: betTransaction as any,
    winTransaction: winTransactionData,
    finalPlatformWallet: currentWalletState,
    updatedGameSession: gameSession,
    gameSpinRecord,
    xpAwardedThisSpin,
    tournamentPointsAwardedThisSpin,
    winAmountPlatformCents: totalWinAmountCents,
    // Jackpot information is stored in gameSpinRecord.spinData and transaction metadata
  }
}

export async function rtgSettings(
  c: Context,
  buser: User,
  platformGameId: string
): Promise<Response> {
  // Request data from client is available via c.req.json() if needed
  const session = c.env.context.session
  const user = await db.userProfile.findUnique({
    where: { id: buser.id },
    include: { vipInfo: true },
  })
  if (!user || !session || !user.vipInfo) {
    return c.json({ success: false, error: 'UNAUTHENTICATED_OR_INCOMPLETE_DATA' }, 401) // Corrected: Direct status number
  }

  // Provider name: 'RTG'
  // Provider config would be: await getProviderConfig('RTG')

  const platformGame = await db.game.findFirst({ where: { name: platformGameId + 'RTG' } })
  if (!platformGame || !platformGame.name) {
    return c.json({ success: false, error: 'GAME_NOT_FOUND_OR_PROVIDER_GAME_ID_MISSING' }, 404) // Corrected
  }
  // RTG game ID would be: platformGame.name.replace('RTG', '')
  // Default currency: 'USD'
  // Default language: 'en'
  const rtgSettingsPayload = await c.req.json()
  // const rgsSettingsPayload: RTGSettingsRequestDto = {
  //   userId: `${rtgProviderConfig.providerUserIdPrefix || ''}${user.id}`,
  //   currency: userCurrencyId,
  //   language: userLanguage,
  //   mode: 'real',
  //   token: session.token,
  //   gameId: rtgGameId,
  //   userData: {
  //     userId: `${rtgProviderConfig.providerUserIdPrefix || ''}${user.id}`,
  //     hash: session.token,
  //     affiliate: 'none', // user.referrerId doesn't exist on UserProfile
  //     lang: userLanguage,
  //     channel: 'web',
  //     userType: 'real',
  //     fingerprint: 'clientFingerprintIfAvailable',
  //   },
  //   custom: { siteId: 'yourSiteIdWithRTG', extras: 'anyExtraParamsNeededByRTG' },
  // }
  // console.log(rtgSettingsPayload)
  try {
    const DEVMODE = rtgSettingsPayload.playMode === 'test' ? true : false
    let rgsResponse
    if (DEVMODE == true) {
      rgsResponse = await import('./json/rtg-settings.result.json')
      // return c.json(rgsResponse)
    } else {
      rgsResponse = await proxyRequestToRgs(
        // providerName,
        'settings',
        'POST',
        rtgSettingsPayload,
        session.token
      )
    }

    // const rgsResponse = await import('./json/rtg-settings.result.json')
    // if (!(rgsResponse as any).sessionId) {
    //   throw new Error('Invalid RGS settings response: missing sessionId.')
    // }
    // return c.json(rgsResponse)
    await db.$transaction(
      async (tx: {
        gameSession: {
          updateMany: (arg0: {
            where: { userId: string; isActive: boolean }
            data: { isActive: boolean; endTime: Date }
          }) => any
          // findFirst: (arg0: { where: { gameId: any; userId: string } }) => any
          // update: (arg0: { where: { id: any }; data: { isActive: boolean } }) => any
          create: (arg0: {
            data: {
              userId: string
              gameId: any
              // authSessionId: any
              currencyId: any
              startingBalance: number
              isActive: boolean
              startTime: Date
            }
          }) => any
        }
      }) => {
        console.log('startting transaction ...')
        await tx.gameSession.updateMany({
          where: {
            userId: user.id,
            // gameId: platformGame.id,
            isActive: true,
            // NOT: {
            //   authSessionId: undefined
            // }
          },
          data: { isActive: false, endTime: new Date() },
        })

        // const existingSession = await tx.gameSession.findFirst({
        //   where: {
        //     // authSessionId: (rgsResponse as any).sessionId,
        //     gameId: platformGame.id,
        //     userId: user.id,
        //   },
        // })
        const operatorId = user.operatorId
        const currencyId = 'USD'
        console.log(user.id, currencyId, operatorId!, tx)
        const platformWallet = await getOrCreateWallet(user.id, currencyId, operatorId!, tx)
        const currentPlatformBalanceCents = toCents(platformWallet.balance)

        // if (existingSession) {
        //   await tx.gameSession.update({
        //     where: { id: existingSession.id },
        //     data: { isActive: true },
        //   })
        // } else {
        console.log('creating new session')
        await tx.gameSession.create({
          data: {
            userId: user.id,
            gameId: platformGame.id,
            // authSessionId: (rgsResponse as any).sessionId,
            currencyId: currencyId,
            startingBalance: currentPlatformBalanceCents,
            isActive: true,
            startTime: new Date(),
          },
        })
        // }
      }
    )

    // const clientResponse: RTGSettingsResponseDto = {
    //   success: false,
    //   result: rgsResponse as any,
    // }
    return c.json(rgsResponse)
    // const error = 'asdf'
    // const typedError = new Error(String('asdf'))
    // return c.json({
    //   success: false,
    //   error: 'RGS_ERROR',
    //   message: typedError.message,
    //   details: typedError instanceof RgsProxyError ? typedError.providerDetails : undefined,
    // })
  } catch (error: unknown) {
    const typedError = error instanceof RgsProxyError ? error : new Error(String(error))
    // Corrected: Pass status code as a direct number
    return c.json({
      success: false,
      error: 'RGS_ERROR',
      message: typedError.message,
      details: typedError instanceof RgsProxyError ? typedError.providerDetails : undefined,
    })
  }
}
///rtg/games/rtg/platform/0Fnal8tl5RQwjg2nHZXkeD2jNTBnJiPO/777Strike/game/settings
export async function rtgSpin(
  c: Context,
  buser: User,
  session: Session,
  platformGameId: string
): Promise<Response> {
  const user = await db.userProfile.findUnique({
    where: { id: buser.id },
    include: { vipInfo: true },
  })
  if (!user || !session || !user.vipInfo) {
    return c.json({ success: false, error: 'UNAUTHENTICATED_OR_INCOMPLETE_DATA' }, 401) // Corrected: Direct status number
  }

  const providerName = 'RTG'
  // console.log(platformGameId + 'RTG')

  const rtgProviderConfig = await getProviderConfig(providerName)

  console.log(rtgProviderConfig)
  const platformGame = await db.game.findFirst({ where: { name: platformGameId + 'RTG' } })
  // console.log(platformGame)
  if (!platformGame || !platformGame.name) {
    return c.json({ success: false, error: 'GAME_NOT_FOUND_OR_PROVIDER_GAME_ID_MISSING' }, 404) // Corrected
  }
  const rtgGameId = platformGame.name

  // let clientSpinRequest: RTGSpinRequestDto
  // try {
  //   clientSpinRequest = await c.req.json<RTGSpinRequestDto>()
  // } catch (e) {
  //   return c.json({ success: false, error: 'INVALID_REQUEST_BODY' }, 400) // Corrected
  // }
  const clientSpinRequestImport = await c.req.json() //await import('./json/rtg-spin-lose.result.json')
  // console.log(clientSpinRequestImport)
  const clientSpinRequest = clientSpinRequestImport as unknown as RTGSpinRequestDto
  console.log(clientSpinRequest)
  const activeGameSession = await db.gameSession.findFirst({
    where: {
      userId: user.id,
      gameId: platformGame.id,
      // authSessionId: (clientSpinRequest as any).sessionId,
      isActive: true,
    },
  })

  if (!activeGameSession || !activeGameSession.currencyId) {
    return c.json({ success: false, error: { code: 'NO_ACTIVE_VALID_SESSION' } }, 400) // Corrected
  }
  const currencyId = activeGameSession.currencyId
  const wagerAmountCents = toCents(clientSpinRequest.stake)

  try {
    const operatorId = user.operatorId
    const wallet = await getOrCreateWallet(user.id, currencyId, operatorId!, db)
    if (toCents(wallet.balance) < wagerAmountCents) {
      return c.json({ success: false, error: { msg: 'INSUFFICIENT_FUNDS' } }, 200) // Corrected
    }

    typedAppEventEmitter.emit(AppEvents.USER_BALANCE_UPDATED, {
      userId: user.id,
      newBalance: wallet.balance - wagerAmountCents,
      table: 'wallets',
      // operatorId,
      changeAmount: fromCentsToFloat(wagerAmountCents) * -1,
      transactionType: TransactionType.BET,
      relatedTransactionId: 'pre-transaction',
    })
    // const rgsSpinPayload = {
    //   token: activeGameSession.authSessionId,
    //   userId: `${rtgProviderConfig.providerUserIdPrefix || ''}${user.id}`,
    //   gameId: rtgGameId,
    //   stake: (clientSpinRequest as any).stake,
    //   currency: currencyId,
    //   playMode: (clientSpinRequest as any).playMode || 'real',
    //   sessionId: (clientSpinRequest as any).sessionId,
    //   custom: (clientSpinRequest as any).custom,
    //   bonusId: (clientSpinRequest as any).bonusId,
    //   extras: (clientSpinRequest as any).extras,
    //   siteId: (clientSpinRequest as any).siteId,
    // }
    let rgsSpinResponse
    const DEVMODE = clientSpinRequest.playMode === 'test' ? true : false
    if (DEVMODE == false) {
      rgsSpinResponse = await proxyRequestToRgs<typeof clientSpinRequest, ProviderSpinResponseData>(
        'spin',
        'POST',
        clientSpinRequest,
        session.token
      )
      rgsSpinResponse = rgsSpinResponse.result as ProviderSpinResponseData
    } else {
      rgsSpinResponse = (await import('./json/rtg-spin-lose.result.json')) as any
      // console.log(rgsSpinResponse)
      // rgsSpinResponse = JSON.parse(rgsSpinResponse)
      rgsSpinResponse = rgsSpinResponse.default as any
      rgsSpinResponse = rgsSpinResponse[0].result as unknown as ProviderSpinResponseData
    }
    if (
      !rgsSpinResponse.game ||
      rgsSpinResponse.game.win?.total === undefined ||
      !rgsSpinResponse.transactions
    ) {
      throw new Error('Invalid RGS spin response structure.')
    }
    console.log(rgsSpinResponse)
    if (
      !rgsSpinResponse.game ||
      rgsSpinResponse.game.win?.total === undefined ||
      !rgsSpinResponse.transactions
    ) {
      throw new Error('Invalid RGS spin response structure.')
    }
    const actualWinAmountCents = toCents(rgsSpinResponse.game.win.total)
    const providerRoundIdFromRgs = rgsSpinResponse.transactions.roundId?.toString()
    console.log('starting transaction ...')
    const start = Bun.nanoseconds()
    const platformUpdates = await db.$transaction(
      async (tx: any) => {
        return handlePlatformGameRound(
          {
            userId: user.id,
            platformGameId: platformGame.id,
            providerName,
            providerGameId: rtgGameId,
            providerRoundId: providerRoundIdFromRgs,
            providerSessionId: (clientSpinRequest as any).sessionId,
            wagerAmountCents,
            operatorId: user.operatorId!,
            winAmountCents: actualWinAmountCents,
            currencyId,
            rgsRawResponse: rgsSpinResponse,
            user,
          },
          tx
        )
      },
      {
        timeout: 10000, // Increase timeout to 10 seconds
      }
    )
    console.log('transaction time', (Bun.nanoseconds() - start) / 1000)

    console.log('platformUpdates', platformUpdates)

    // Process jackpots outside the main transaction to avoid timeout
    try {
      const gameSpinService = new GameSpinService()
      const jackpotResult = await gameSpinService.processGameSpin({
        gameSessionId: platformUpdates.updatedGameSession.id,
        sessionId: (clientSpinRequest as any).sessionId,
        spinNumber: (platformUpdates.updatedGameSession.totalWagered || 0) + 1,
        wagerAmount: wagerAmountCents,
        grossWinAmount: actualWinAmountCents,
        currencyId,
        spinData: {
          providerRoundId: providerRoundIdFromRgs || `spin-${Date.now()}`,
          rgsRawResponse: rgsSpinResponse,
        },
      })

      // Handle jackpot wins if any
      if (jackpotResult.jackpotContributions.jackpotWin) {
        const jackpotWinAmountCents = jackpotResult.jackpotContributions.jackpotWin.winAmountCoins

        // Update game spin record with jackpot information
        await db.gameSpin.update({
          where: { id: platformUpdates.gameSpinRecord.id },
          data: {
            grossWinAmount: actualWinAmountCents + jackpotWinAmountCents,
            spinData: {
              ...(platformUpdates.gameSpinRecord.spinData as any),
              jackpotWin: jackpotResult.jackpotContributions.jackpotWin,
              jackpotContributions: jackpotResult.jackpotContributions.contributions,
            } as Prisma.JsonObject,
          },
        })

        // Create separate jackpot win transaction
        await db.$transaction(async (tx: any) => {
          const wallet = await getOrCreateWallet(user.id, currencyId, user.operatorId!, tx)
          const jackpotWinTx = await createTransactionRecord(
            {
              userId: user.id,
              type: TransactionType.WIN,
              status: TransactionStatus.COMPLETED,
              amountInCents: jackpotWinAmountCents,
              operatorId: user.operatorId!,
              description: `Jackpot win on ${providerName} game ${rtgGameId}`,
              provider: providerName,
              providerTxId: `jackpot-${providerRoundIdFromRgs || Date.now()}`,
              gameId: platformGame.id,
              balanceBeforeInCents: toCents(wallet.balance),
            },
            tx
          )

          const updatedWallet = await updateWalletBalance(
            wallet.id,
            jackpotWinAmountCents,
            'balance',
            tx
          )
          await tx.transaction.update({
            where: { id: jackpotWinTx.id },
            data: {
              balanceAfter: toCents(updatedWallet.balance),
              metadata: {
                jackpotType:
                  jackpotResult.jackpotContributions.jackpotWin?.jackpotType || 'unknown',
                gameSpinId: platformUpdates.gameSpinRecord.id,
              } as Prisma.JsonObject,
            },
          })
        })
      }
    } catch (jackpotError) {
      console.error('Error processing jackpots:', jackpotError)
      // Don't fail the entire spin if jackpot processing fails
    }

    // Record tournament points outside the main transaction to avoid timeout
    const pointsForTournament = Math.floor(wagerAmountCents / 100)
    if (pointsForTournament > 0 && platformUpdates.gameSpinRecord?.id) {
      try {
        const tournamentIdsToUpdate = await db.$transaction(
          async (tx: any) => {
            return await TournamentService.recordTournamentPoints(
              user.id,
              platformGame.id,
              pointsForTournament,
              platformUpdates.gameSpinRecord.id,
              tx
            )
          },
          {
            timeout: 8000, // Separate timeout for tournament processing
          }
        )

        // Publish leaderboard updates outside the transaction
        for (const tournamentId of tournamentIdsToUpdate) {
          try {
            const leaderboard = await TournamentService.getTournamentLeaderboard(tournamentId, 20)
            typedAppEventEmitter.emit(AppEvents.TOURNAMENT_LEADERBOARD_UPDATED, {
              tournamentId,
              leaderboard: leaderboard.map((p: any) => ({
                userId: p.userId,
                username: p.user.username || 'Player',
                score: p.score,
                rank: p.rank,
                avatarUrl: p.user.avatar,
              })),
            })
          } catch (leaderboardError) {
            console.error(
              `Error publishing leaderboard update for tournament ${tournamentId}:`,
              leaderboardError
            )
          }
        }
      } catch (error) {
        console.error('Error recording tournament points:', error)
        // Don't fail the entire spin if tournament recording fails
      }
    }

    typedAppEventEmitter.emit(AppEvents.USER_BALANCE_UPDATED, {
      userId: user.id,
      newBalance: platformUpdates.finalPlatformWallet.balance,
      table: 'wallets',
      // operatorId,
      changeAmount: fromCentsToFloat(actualWinAmountCents - wagerAmountCents),
      transactionType: TransactionType.BET,
      relatedTransactionId: (platformUpdates.betTransaction as any).id,
    })

    typedAppEventEmitter.emit(AppEvents.GAME_SPIN_COMPLETED, {
      userId: user.id,
      gameId: platformGame.id,
      provider: providerName,
      providerGameId: rtgGameId,
      wagerAmount: wagerAmountCents,
      winAmount: actualWinAmountCents,
      currencyId,
      xpGained: platformUpdates.xpAwardedThisSpin,
      timestamp: new Date().toISOString(),
      gameSpinRecordId: platformUpdates.gameSpinRecord.id,
    })

    const clientResponsePayload = {
      success: true,
      result: rgsSpinResponse as unknown as RtgSpinResult,
    }
    return c.json(clientResponsePayload)
  } catch (error: unknown) {
    const typedError = error instanceof RgsProxyError ? error : new Error(String(error))
    return c.json({
      success: false,
      error: 'RGS_ERROR',
      message: typedError.message,
      details: typedError instanceof RgsProxyError ? typedError.providerDetails : undefined,
    })
  }
}
