/**
 * Phase 4.5: Asynchronous Jackpot Processing Service
 * Handles jackpot contributions and wins without blocking the main spin response
 */

import { sql } from 'bun'
import { SQL } from 'bun'
import { JackpotUtils, JACKPOT_CONFIG } from 'shared'
import { TransactionStatus } from '../../prisma/generated/client'
import { cacheService, CACHE_KEYS } from './redis-cache.service.js'

const jackpotSql = new SQL(
  'postgresql://postgres.acqrudqzutnwrvmvlshc:acqrudqzutnwrvmvlshc@aws-0-us-east-2.pooler.supabase.com:5432/postgres',
  {
    // prepare: false, // Disable persisting named prepared statements on the server
  }
)

interface AsyncJackpotProcessingRequest {
  gameSpinId: string
  userId: string
  operatorId: string
  walletId: string
  wagerAmountCents: number
  gameCategory: string
  providerRoundId: string
  providerName: string
  gameId: string
}

interface JackpotProcessingResult {
  contributions: Array<{
    jackpotType: string
    contributionAmountCoins: number
    contributionAmountDollars: number
  }>
  jackpotWin?: {
    id: string
    jackpotType: string
    winAmountCoins: number
    winAmountDollars: number
    gameSpinId: string
  }
  jackpotWinTransactionId?: string
}

class AsyncJackpotService {
  /**
   * Process jackpot contributions and wins asynchronously
   * This runs after the main spin transaction completes
   */
  async processJackpotsAsync(request: AsyncJackpotProcessingRequest): Promise<JackpotProcessingResult> {
    const {
      gameSpinId,
      userId,
      operatorId,
      walletId,
      wagerAmountCents,
      gameCategory,
      providerRoundId,
      providerName,
      gameId,
    } = request

    console.log(`🎰 [ASYNC] Starting jackpot processing for spin ${gameSpinId}`)

    // Only SLOTS games are eligible for jackpots
    if (gameCategory !== 'SLOTS') {
      console.log(`🎰 [ASYNC] Game category ${gameCategory} not eligible for jackpots`)
      return { contributions: [] }
    }

    // Get eligible jackpot types for this wager
    const eligibleJackpotTypes = JackpotUtils.getEligibleJackpots(wagerAmountCents)

    if (eligibleJackpotTypes.length === 0) {
      console.log(`🎰 [ASYNC] Wager ${wagerAmountCents} coins not eligible for any jackpots`)
      return { contributions: [] }
    }

    console.log(`🎰 [ASYNC] Processing ${eligibleJackpotTypes.length} eligible jackpot types: ${eligibleJackpotTypes.join(', ')}`)

    try {
      // Get active jackpots (cached)
      const activeJackpots = await this.getActiveJackpots(eligibleJackpotTypes)

      if (activeJackpots.length === 0) {
        console.log(`🎰 [ASYNC] No active jackpots found for types: ${eligibleJackpotTypes.join(', ')}`)
        return { contributions: [] }
      }

      // Process jackpots in a separate transaction
      const result = await jackpotSql.begin(async (tx) => {
        const contributions: any[] = []
        let jackpotWin: any = null
        let jackpotWinTransaction: any = null

        for (const jackpot of activeJackpots) {
          const config = JACKPOT_CONFIG[jackpot.type as keyof typeof JACKPOT_CONFIG]
          if (!config) {
            console.warn(`🎰 [ASYNC] Unknown jackpot type: ${jackpot.type}`)
            continue
          }

          const contributionAmount = JackpotUtils.calculateContribution(
            wagerAmountCents,
            config.contributionRateBasisPoints
          )

          if (contributionAmount > 0) {
            console.log(`🎰 [ASYNC] Contributing ${contributionAmount} coins to ${jackpot.type} jackpot`)

            // Create contribution record
            await tx`
              INSERT INTO jackpot_contributions (
                id,
                "jackpotId",
                "gameSpinId",
                "contributionAmountCoins",
                "createdAt"
              ) VALUES (
                public.generate_cuid(),
                ${jackpot.id},
                ${gameSpinId},
                ${contributionAmount},
                NOW()
              )
            `

            // Update jackpot amount
            await tx`
              UPDATE jackpots
              SET "currentAmountCoins" = "currentAmountCoins" + ${contributionAmount}
              WHERE id = ${jackpot.id}
            `

            contributions.push({
              jackpotType: jackpot.type,
              contributionAmountCoins: contributionAmount,
              contributionAmountDollars: JackpotUtils.coinsToDollars(contributionAmount),
            })

            // Check for jackpot win (only one jackpot can be won per spin)
            if (!jackpotWin && this.shouldWinJackpot(jackpot)) {
              console.log(`🎰 [ASYNC] JACKPOT WIN! ${jackpot.type} jackpot triggered!`)

              const winAmount = jackpot.currentAmountCoins + contributionAmount

              // Create jackpot win record
              const [jackpotWinRecord] = await tx`
                INSERT INTO jackpot_wins (
                  id,
                  "jackpotId",
                  "winnerId",
                  "winAmountCoins",
                  "gameSpinId",
                  "createdAt"
                ) VALUES (
                  public.generate_cuid(),
                  ${jackpot.id},
                  ${userId},
                  ${winAmount},
                  ${gameSpinId},
                  NOW()
                )
                RETURNING id
              `

              // Reset jackpot to random seed amount
              const newSeedAmount = JackpotUtils.generateRandomSeedAmount(jackpot.seedAmountCoins)
              await tx`
                UPDATE jackpots
                SET "currentAmountCoins" = ${newSeedAmount},
                    "lastWonAt" = NOW(),
                    "lastWonBy" = ${userId}
                WHERE id = ${jackpot.id}
              `

              // Create jackpot win transaction
              const [jackpotTx] = await tx`
                INSERT INTO transactions (
                  id, "userProfileId", "operatorId", "walletId", type, status, amount,
                  "balanceBefore", "balanceAfter", description, provider, "providerTxId",
                  "relatedGameId", "relatedRoundId", "createdAt", "updatedAt"
                ) VALUES (
                  public.generate_cuid(), ${userId}, ${operatorId}, ${walletId},
                  'JACKPOT_WIN', ${TransactionStatus.COMPLETED}, ${winAmount},
                  (SELECT balance * 100 FROM wallets WHERE id = ${walletId}),
                  (SELECT balance * 100 FROM wallets WHERE id = ${walletId}) + ${winAmount},
                  ${`${jackpot.type} Jackpot Win`}, ${providerName}, ${'jackpot-' + providerRoundId},
                  ${gameId}, ${providerRoundId}, NOW(), NOW()
                )
                RETURNING id
              `

              // Update wallet with jackpot win
              await tx`
                UPDATE wallets
                SET balance = balance + ${winAmount / 100}
                WHERE id = ${walletId}
              `

              jackpotWin = {
                id: jackpotWinRecord.id,
                jackpotType: jackpot.type,
                winAmountCoins: winAmount,
                winAmountDollars: JackpotUtils.coinsToDollars(winAmount),
                gameSpinId: gameSpinId,
              }

              jackpotWinTransaction = jackpotTx

              console.log(`🎰 [ASYNC] Jackpot win processed: ${winAmount} coins`)
            }
          }
        }

        return {
          contributions,
          jackpotWin,
          jackpotWinTransactionId: jackpotWinTransaction?.id || null,
        }
      })

      // Invalidate caches after successful processing
      if (result.contributions.length > 0 || result.jackpotWin) {
        await this.invalidateJackpotCache()
        
        // Invalidate wallet cache if there was a jackpot win
        if (result.jackpotWin) {
          await cacheService.invalidateWallet(userId, operatorId)
        }
      }

      console.log(`🎰 [ASYNC] Jackpot processing completed: ${result.contributions.length} contributions, ${result.jackpotWin ? '1 win' : '0 wins'}`)

      return result

    } catch (error) {
      console.error(`🎰 [ASYNC] Jackpot processing failed for spin ${gameSpinId}:`, error)
      // Don't throw - jackpot processing failure shouldn't affect the main spin
      return { contributions: [] }
    }
  }

  /**
   * Get active jackpots (cached)
   */
  private async getActiveJackpots(eligibleTypes: string[]): Promise<any[]> {
    const cacheKey = eligibleTypes.sort().join(',')
    const cached = await cacheService.get<any[]>(CACHE_KEYS.JACKPOTS, cacheKey)
    if (cached) {
      return cached
    }

    // Query all active jackpots and filter in JavaScript
    const allJackpots = await jackpotSql`
      SELECT
        id, type, "currentAmountCoins", "seedAmountCoins",
        "minimumBetCoins", "contributionRateBasisPoints",
        "probabilityPerMillion", "minimumTimeBetweenWinsMinutes",
        "lastWonAt", "lastWonBy", "isActive"
      FROM jackpots
      WHERE "isActive" = true
    `

    const jackpots = allJackpots.filter((jackpot: any) => 
      eligibleTypes.includes(jackpot.type)
    )

    // Cache for 5 minutes
    if (jackpots.length > 0) {
      await cacheService.set(CACHE_KEYS.JACKPOTS, cacheKey, jackpots, 300)
    }

    return jackpots
  }

  /**
   * Check if a jackpot should win
   */
  private shouldWinJackpot(jackpot: any): boolean {
    const config = JACKPOT_CONFIG[jackpot.type as keyof typeof JACKPOT_CONFIG]
    if (!config) {
      return false
    }

    // Check minimum time between wins
    if (!JackpotUtils.canWinJackpot(jackpot.lastWonAt, config.minimumTimeBetweenWinsMinutes)) {
      return false
    }

    // Check probability
    return JackpotUtils.checkJackpotWin(config.probabilityPerMillion)
  }

  /**
   * Invalidate jackpot cache
   */
  private async invalidateJackpotCache(): Promise<void> {
    const possibleKeys = [
      'MINOR', 'MAJOR', 'GRAND',
      'MAJOR,MINOR', 'GRAND,MAJOR', 'GRAND,MAJOR,MINOR',
      'GRAND,MINOR', 'MINOR,MAJOR',
    ]

    for (const key of possibleKeys) {
      await cacheService.delete(CACHE_KEYS.JACKPOTS, key)
    }
  }
}

export const asyncJackpotService = new AsyncJackpotService()
