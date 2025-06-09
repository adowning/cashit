// // src/services/cashapp-payment-processing.service.ts

// import * as transactionService from './transaction.service'
// import prisma from '@/prisma' // Your Prisma client instance
// import { AppEvents, typedAppEventEmitter } from '../lib/events'
// import { TransactionStatus, TransactionType, UserProfile } from '@/generated/client'
// import { ReceivedCashAppPayment, fetchReceivedVendorPayments } from './cashapp.integration'

// const VENDOR_CASHAPP_INTERNAL_CUSTOMER_ID = process.env['VENDOR_CASHAPP_INTERNAL_CUSTOMER_ID']
// const GAME_TOKEN_PRODUCT_ID_CASHAPP_DEPOSIT =
//   process.env['GAME_TOKEN_PRODUCT_ID_CASHAPP_DEPOSIT'] || 'CASHAPP_GAME_TOKENS_V1'
// const CASHAPP_DEPOSIT_PROVIDER_TAG = 'CASHAPP_AUTO_DEPOSIT'
// // const GAME_TOKEN_CURRENCY = process.env.GAME_TOKEN_CURRENCY || 'GTK' // Example currency for game tokens

// async function findUserForPayment(payment: ReceivedCashAppPayment): Promise<UserProfile | null> {
//   if (payment.senderCashtag) {
//     const cashtagToSearch = payment.senderCashtag.startsWith('$')
//       ? payment.senderCashtag.substring(1)
//       : payment.senderCashtag
//     const userByCashtag = await prisma.userProfile.findFirst({
//       where: { cashtag: cashtagToSearch },
//     })
//     if (userByCashtag) return userByCashtag
//   }

//   if (payment.note) {
//     const userIdMatch = payment.note.match(/userid:(\S+)/i) || payment.note.match(/user:(\S+)/i)
//     if (userIdMatch && userIdMatch[1]) {
//       const identifier = userIdMatch[1]
//       let user = await prisma.userProfile.findUnique({ where: { id: identifier } })
//       if (user) return user
//       user = await prisma.userProfile.findUnique({ where: { username: identifier } })
//       if (user) return user
//     }
//   }
//   return null
// }

// async function processSingleCashAppPayment(payment: ReceivedCashAppPayment): Promise<void> {
//   console.log(
//     `[CashAppProcessing] Attempting to process payment: ${payment.paymentToken}, Amount: ${payment.amount.amountInCents} ${payment.amount.currencyCode}, Sender: ${payment.senderCashtag || 'N/A'}, Note: "${payment.note}"`
//   )

//   const user = await findUserForPayment(payment)
//   if (!user) {
//     console.warn(
//       `[CashAppProcessing] No matching user found for CashApp payment ${payment.paymentToken}.`
//     )
//     // Log this for manual review:
//     await prisma.unmatchedCashAppPayment
//       .create({
//         // Example: Create a table for unmatched payments
//         data: {
//           paymentToken: payment.paymentToken,
//           senderId: payment.senderId,
//           senderCashtag: payment.senderCashtag,
//           amountInCents: payment.amount.amountInCents,
//           currencyCode: payment.amount.currencyCode,
//           note: payment.note,
//           paymentCreatedAt: payment.createdAt,
//         },
//       })
//       .catch((e: Error) => console.error('Failed to log unmatched payment', e))
//     return
//   }

//   console.log(
//     `[CashAppProcessing] Matched payment ${payment.paymentToken} to user: ${user.username} (ID: ${user.id})`
//   )

//   const existingTx = await prisma.transaction.findFirst({
//     where: {
//       provider: CASHAPP_DEPOSIT_PROVIDER_TAG,
//       providerTxId: payment.paymentToken,
//       userProfileId: user.id,
//       status: TransactionStatus.COMPLETED,
//     },
//   })

//   if (existingTx) {
//     console.log(
//       `[CashAppProcessing] Payment ${payment.paymentToken} already processed (Transaction ID: ${existingTx.id}). Skipping.`
//     )
//     return
//   }

//   // Find a PENDING deposit initiated by the user.
//   // This assumes user initiates a deposit in your system, which then waits for CashApp confirmation.
//   const pendingDeposit = await prisma.transaction.findFirst({
//     where: {
//       userProfileId: user.id,
//       type: TransactionType.DEPOSIT,
//       status: TransactionStatus.PENDING,
//       amount: payment.amount.amountInCents, // Match amount
//       // provider: 'USER_CASHAPP_INTENT', // Optional: Specific provider for user-initiated pending deposits
//     },
//     orderBy: { createdAt: 'desc' }, // Get the latest one if multiple
//   })

//   if (!pendingDeposit) {
//     console.warn(
//       `[CashAppProcessing] No PENDING deposit found for user ${user.id} matching amount ${payment.amount.amountInCents}. Payment ${payment.paymentToken}.`
//     )
//     // Optionally, create a new deposit transaction if your flow allows direct CashApp deposits without prior intent.
//     // For now, we'll assume a pending deposit must exist.
//     return
//   }

//   console.log(
//     `[CashAppProcessing] Found matching PENDING deposit ${pendingDeposit.id} for user ${user.id}.`
//   )

//   try {
//     await prisma.$transaction(async (tx) => {
//       // 1. Update PENDING deposit to COMPLETED
//       const completedDeposit = await tx.transaction.update({
//         where: { id: pendingDeposit.id },
//         data: {
//           status: TransactionStatus.COMPLETED,
//           provider: CASHAPP_DEPOSIT_PROVIDER_TAG,
//           providerTxId: payment.paymentToken,
//           description: pendingDeposit.description
//             ? `${pendingDeposit.description} (CashApp: ${payment.paymentToken})`
//             : `CashApp Deposit via ${payment.senderCashtag || payment.paymentToken}`,
//           updatedAt: new Date(),
//         },
//       })
//       console.log(
//         `[CashAppProcessing] Deposit ${completedDeposit.id} for user ${user.id} marked COMPLETED.`
//       )

//       // 2. Credit user's main wallet
//       const wallet = await transactionService.getOrCreateWallet(
//         user.id,
//         'USD', // Default to USD since currency is not on the user model
//         user.operatorId || undefined, // Convert null to undefined to match expected type
//         tx
//       )
//       const mainBalanceBefore = wallet.balance
//       await transactionService.updateWalletBalance(
//         wallet.id,
//         payment.amount.amountInCents,
//         'balance',
//         tx
//       )
//       const updatedWallet = await tx.wallet.findUniqueOrThrow({ where: { id: wallet.id } }) // Re-fetch for latest balance

//       console.log(
//         `[CashAppProcessing] User ${user.id} main balance updated. Before: ${mainBalanceBefore}, After: ${updatedWallet.balance}`
//       )

//       // 3. Award Game Tokens (e.g., 1 token per cent deposited)
//       const gameTokensToAward = payment.amount.amountInCents // Example conversion
//       const bonusBalanceBefore = updatedWallet.bonusBalance // Assuming game tokens are in bonusBalance

//       // Use recordSystemAwardTransaction or a more specific function if available
//       await transactionService.recordSystemAwardTransaction(
//         {
//           userId: user.id,
//           type: TransactionType.BONUS_AWARD, // Or a new 'GAME_TOKEN_CREDIT' type
//           amountInCents: gameTokensToAward,
//           description: `Game Tokens for CashApp Deposit (${payment.paymentToken})`,
//           walletId: wallet.id,
//           productId: GAME_TOKEN_PRODUCT_ID_CASHAPP_DEPOSIT,
//           operatorId: user.operatorId,
//           bonusAmountInCents: gameTokensToAward,
//           bonusBalanceBeforeInCents: bonusBalanceBefore,
//           bonusBalanceAfterInCents: bonusBalanceBefore + gameTokensToAward,
//           // Not setting main balanceBefore/After here as it's handled by the deposit itself
//         },
//         tx
//       )

//       // If game tokens are a separate field, update it directly:
//       // await tx.wallet.update({
//       //   where: { id: wallet.id },
//       //   data: { gameTokenBalance: { increment: gameTokensToAward } },
//       // });

//       console.log(
//         `[CashAppProcessing] Awarded ${gameTokensToAward} game tokens to user ${user.id}.`
//       )

//       // Emit events
//       // Emit balance update with required properties
//       typedAppEventEmitter.emit(AppEvents.USER_BALANCE_UPDATED, {
//         userId: user.id,
//         newBalance: updatedWallet.balance,
//         table: 'wallet',
//         changeAmount: payment.amount.amountInCents,
//         transactionType: 'DEPOSIT',
//         relatedTransactionId: pendingDeposit.id
//       })
//       // If game tokens are separate and have their own event:
//       // typedAppEventEmitter.emit(AppEvents.USER_GAME_TOKEN_BALANCE_UPDATED, { userId: user.id, newGameTokenBalance: updatedWallet.gameTokenBalance });
//     })
//     console.log(
//       `[CashAppProcessing] Successfully processed CashApp payment ${payment.paymentToken} for user ${user.id}.`
//     )
//   } catch (error: any) {
//     console.error(
//       `[CashAppProcessing] ERROR processing payment ${payment.paymentToken} for user ${user.id}: ${error.message}`,
//       error.stack
//     )
//     // Potentially revert PENDING deposit status or log for manual intervention
//   }
// }

// export async function runCashAppPaymentCheckJob(): Promise<void> {
//   if (!VENDOR_CASHAPP_INTERNAL_CUSTOMER_ID) {
//     console.error(
//       '[CashAppJob] VENDOR_CASHAPP_INTERNAL_CUSTOMER_ID is not configured. Payment check skipped.'
//     )
//     return
//   }
//   console.log(
//     `[CashAppJob] Starting check for payments to vendor ID: ${VENDOR_CASHAPP_INTERNAL_CUSTOMER_ID}`
//   )
//   try {
//     const newPayments = await fetchReceivedVendorPayments(VENDOR_CASHAPP_INTERNAL_CUSTOMER_ID)
//     if (newPayments.length > 0) {
//       console.log(`[CashAppJob] Found ${newPayments.length} new CashApp payment(s).`)
//       for (const payment of newPayments) {
//         await processSingleCashAppPayment(payment)
//       }
//     } else {
//       console.log('[CashAppJob] No new CashApp payments found for vendor.')
//     }
//   } catch (error: any) {
//     console.error(`[CashAppJob] Critical error during payment check: ${error.message}`, error.stack)
//   }
// }
