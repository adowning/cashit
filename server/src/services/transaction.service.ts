// File: server/src/services/transaction.service.ts

import {
  Prisma,
  Transaction,
  TransactionStatus,
  TransactionType,
  Wallet,
} from 'prisma/generated/client'

import prisma from '../../prisma/index'
import { AppEvents, typedAppEventEmitter } from '../lib/events'

// --- Core Transaction Creation ---

export interface CreateTransactionArgs {
  userId: string
  type: TransactionType
  status: TransactionStatus
  amountInCents: number
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
  gameId?: string | null
  roundId?: string | null
  operatorId?: string
}

export async function createTransactionRecord(
  args: CreateTransactionArgs,
  tx?: any
): Promise<Transaction> {
  const db = tx || prisma
  const { gameId, roundId } = args

  const createInput: Prisma.TransactionCreateInput = {
    description: args.description,
    provider: args.provider,
    providerTxId: args.providerTxId,
    metadata: args.metadata || Prisma.JsonNull,
    balanceBefore: args.balanceBeforeInCents,
    balanceAfter: args.balanceAfterInCents,
    bonusAmount: args.bonusAmountInCents,
    bonusBalanceBefore: args.bonusBalanceBeforeInCents,
    bonusBalanceAfter: args.bonusBalanceAfterInCents,
    type: args.type,
    status: args.status,
    amount: args.amountInCents,
    operator: { connect: { id: args.operatorId } },
  }

  // Connect to UserProfile
  if (args.userId) {
    createInput.userProfile = { connect: { id: args.userId } }
  }

  // Connect to wallet if provided
  if (args.walletId) {
    createInput.wallet = { connect: { id: args.walletId } }
  }

  // Connect to product if provided
  if (args.productId) {
    createInput.product = { connect: { id: args.productId } }
  }

  // Add game and round IDs if provided
  if (gameId) {
    createInput.relatedGameId = gameId
  }
  if (roundId) {
    createInput.relatedRoundId = roundId
  }

  const transaction = await db.transaction.create({ data: createInput })

  typedAppEventEmitter.emit(AppEvents.TRANSACTION_CREATED, {
    userId: args.userId,
    transactionId: transaction.id,
    transactionType: args.type,
    newStatus: args.status,
    amount: args.amountInCents,
    currencyId: 'USD', // Default for now since schema doesn't have currencyId
  })

  return transaction
}

// --- Wallet Management ---
export async function getOrCreateWallet(
  userId: string,
  // currencyId: string,
  operatorId: string,
  tx?: any
): Promise<Wallet> {
  const db = tx || prisma
  let wallet = await db.wallet.findFirst({
    where: { AND: [{ userId: userId }, { operatorId: operatorId }] },
  })
  if (!wallet) {
    wallet = await db.wallet.create({
      data: {
        balance: 0,
        bonusBalance: 0,
        paymentMethod: 'CASH_APP',
        lockedBalance: 0,
        operator: {
          connect: {
            id: operatorId,
          },
        },
        user: {
          connect: {
            id: userId,
          },
        },
      },
    })
  }
  return wallet
}

export async function updateWalletBalance(
  walletId: string,
  amountInCents: number,
  balanceType: 'balance' | 'bonusBalance' | 'lockedBalance' = 'balance',
  tx: any
): Promise<Wallet> {
  const wallet = await tx.wallet.findUniqueOrThrow({ where: { id: walletId } })
  let newBalanceValue: number
  const updateData: Prisma.WalletUpdateInput = {}

  switch (balanceType) {
    case 'balance':
      newBalanceValue = wallet.balance + amountInCents
      if (amountInCents < 0 && newBalanceValue < 0) {
        throw new Error('Insufficient real balance.')
      }
      updateData.balance = newBalanceValue
      break
    case 'bonusBalance':
      newBalanceValue = wallet.bonusBalance + amountInCents
      if (amountInCents < 0 && newBalanceValue < 0) {
        throw new Error('Insufficient bonus balance.')
      }
      updateData.bonusBalance = newBalanceValue
      break
    case 'lockedBalance':
      newBalanceValue = wallet.lockedBalance + amountInCents
      if (amountInCents < 0 && newBalanceValue < 0) {
        throw new Error('Insufficient locked funds to release.')
      }
      updateData.lockedBalance = newBalanceValue
      break
    default:
      throw new Error('Invalid balance type specified.')
  }
  return tx.wallet.update({ where: { id: walletId }, data: updateData })
}

// --- Helper Functions ---
export function toCents(amount: number): number {
  return Math.round(amount * 100)
}

export function fromCents(amountInCents: number): number {
  return amountInCents / 100
}

// --- System Award Transaction Helper ---
export async function recordSystemAwardTransaction(
  args: Omit<CreateTransactionArgs, 'status' | 'provider'> & {
    type: 'BONUS_AWARD' | 'XP_AWARD' | 'REBATE_PAYOUT'
  },
  tx: any
): Promise<Transaction> {
  const wallet = await getOrCreateWallet(args.userId, 'USD', args.operatorId || 'default')
  const amountInCents = args.amountInCents
  let balanceBeforeInCents: number
  let balanceTypeToUpdate: 'balance' | 'bonusBalance' = 'balance'

  if (args.type === TransactionType.BONUS_AWARD) {
    balanceBeforeInCents = wallet.bonusBalance
    balanceTypeToUpdate = 'bonusBalance'
  } else {
    balanceBeforeInCents = wallet.balance
  }

  await updateWalletBalance(wallet.id, amountInCents, balanceTypeToUpdate, tx)
  const updatedWallet = await tx.wallet.findUniqueOrThrow({ where: { id: wallet.id } })
  const balanceAfterInCents =
    balanceTypeToUpdate === 'bonusBalance' ? updatedWallet.bonusBalance : updatedWallet.balance

  const transactionArgs: CreateTransactionArgs = {
    ...args,
    status: TransactionStatus.COMPLETED,
    provider: 'System',
    walletId: wallet.id,
    balanceBeforeInCents: balanceBeforeInCents,
    balanceAfterInCents: balanceAfterInCents,
  }

  if (args.type === TransactionType.BONUS_AWARD) {
    transactionArgs.bonusAmountInCents = amountInCents
    transactionArgs.bonusBalanceBeforeInCents = balanceBeforeInCents
    transactionArgs.bonusBalanceAfterInCents = balanceAfterInCents
  }

  return createTransactionRecord(transactionArgs, tx)
}

// --- Transaction History ---
export async function getTransactionHistory(
  userId: string,
  filters: {
    type?: TransactionType | TransactionType[]
    status?: TransactionStatus | TransactionStatus[]
  } = {},
  pagination: { skip?: number; take?: number } = { skip: 0, take: 20 }
) {
  const whereClause: Prisma.TransactionWhereInput = { userProfileId: userId }

  if (filters.type) {
    whereClause.type = Array.isArray(filters.type) ? { in: filters.type } : filters.type
  }
  if (filters.status) {
    whereClause.status = Array.isArray(filters.status) ? { in: filters.status } : filters.status
  }

  const total = await prisma.transaction.count({ where: whereClause })
  const transactions = await prisma.transaction.findMany({
    where: whereClause,
    orderBy: { createdAt: 'desc' },
    skip: pagination.skip,
    take: pagination.take,
  })

  return {
    items: transactions.map((t) => ({
      id: t.id,
      date: t.createdAt,
      type: t.type,
      status: t.status,
      amount: t.amount,
      description: t.description,
      provider: t.provider,
      providerTxId: t.providerTxId,
    })),
    total,
    page:
      pagination.skip !== undefined && pagination.take
        ? Math.floor(pagination.skip / pagination.take) + 1
        : 1,
    limit: pagination.take || 20,
    totalPages: pagination.take ? Math.ceil(total / pagination.take) : 1,
  }
}
