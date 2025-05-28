/* eslint-disable @typescript-eslint/no-unused-vars */
import { useAppBarStore } from '@/stores/appBar.store'
import { useAuthStore } from '@/stores/auth.store'
import { defineStore } from 'pinia'
import { ref } from 'vue' // Removed computed as it's not used in the provided snippet

import { handleException } from './exception'
import { orpcManager } from '@/utils/orpc.client' // Import orpcManager

// Assuming these types are correctly imported or defined in shared/dist or client interfaces
import type {
  PrismaGameCategory, // This type comes from shared/dist/types/prisma
  PrismaGameCategoryName,
  PrismaGameProvider as PrismaGameProviderNameEnum,
  LaunchGameResponseDto,
  RTGSettingsRequestDto,
  RTGSettingsResponseDto,
  RTGSpinRequestDto,
  RTGSpinResponseDto,
  PrismaGameHistoryItem,
  PrismaGameBigWinData,
  PaginatedResponse,
  PrismaGameEnterBody, // From shared/dist/types/game
  PrismaGameUserBody, // From shared/dist/types/game
  // GameEnterResponse, // This seems to be part of LaunchGameResponseDto or specific to old API
  PrismaGameHistoryResponse as SharedGameHistoryResponse, // From shared/dist/types/game (ensure structure matches)
  PrismaGameSearchResponse as SharedGameSearchResponse, // From shared/dist/types/game
  PrismaGameProvider as SharedGameProviderType, // From shared/dist/types/prisma
} from 'shared/dist'

type DialogType = 'login' | 'signup' // Renamed for clarity

// Define more specific types if the shared ones are too broad or don't match exactly
// For example, the old GameCategory type in the store was different from PrismaGameCategory
interface ClientGameCategory {
  image: string
  pictures: string
  game_count: string | number
  name: string // This could be PrismaGameCategoryName
  slug: string
  games: Array<SharedSearchType> // Assuming Search type is appropriate here
  page_no: number
}

export const useGameStore = defineStore(
  'game',
  () => {
    const { restClient } = orpcManager.getClients()
    const authStore = useAuthStore()
    const appBarStore = useAppBarStore()

    const success = ref<boolean>(false)
    const errMessage = ref<string>('')

    const gameCategories = ref<Array<ClientGameCategory>>([]) // Using client-specific type
    const gameDevelopers = ref<Array<SharedGameProviderType>>([]) // Using shared provider type

    const gameSearchList = ref<SharedGameSearchResponse>({
      // Using shared search response type
      items: [],
      total: 0,
    })

    // For game launch, LaunchGameResponseDto from shared is more appropriate
    const enterGameItem = ref<LaunchGameResponseDto | null>(null)
    // const enterGameItem = ref<GameEnterResponse>({ // Old type
    //   method: '', parames: '', developer: '', reserve: '', weburl: '',
    // });

    const searchGameDialogShow = ref<boolean>(false)
    const mobileMenuShow = ref<boolean>(true) // Default might change based on useDisplay
    const searchTextList = ref<Array<string>>([])
    const gameFilterText = ref<string>('')
    const originalGames = ref<Array<any>>([]) // Using shared Search type

    const gameHistoryItem = ref<SharedGameHistoryResponse>({
      // Using shared history response type
      total_pages: 0,
      record: [],
    })

    // userSpinPage and userSpin are 'any'. Need more context for proper typing.
    // These might relate to custom mini-games or specific provider data not covered by generic types.
    const userSpinPage = ref<any>({})
    const userSpin = ref<any>({})

    const language = ref<string>(localStorage.getItem('lang') || 'en')
    const betby = ref<any>(null) // For Betby SDK instance
    const gameBigWinItem = ref<GameBigWinData>({
      high_rollers: [],
      lucky_bets: [],
    })
    const favoriteGameList = ref<Array<string>>([]) // Store game IDs (string/CUID)

    function setSuccess(_success: boolean) {
      success.value = _success
    }
    function setErrorMessage(message: string) {
      errMessage.value = message
    }
    function setGameCategories(_gameCategories: Array<ClientGameCategory>) {
      gameCategories.value = _gameCategories
    }
    function setGamedevelopers(_gamedevelopers: Array<SharedGameProviderType>) {
      gameDevelopers.value = _gamedevelopers
    }
    function setGameSearchList(_gameSearchList: SharedGameSearchResponse) {
      gameSearchList.value = _gameSearchList
    }
    function setGameEnterItem(_enterGameItem: LaunchGameResponseDto | null) {
      enterGameItem.value = _enterGameItem
    }
    function setSearchGameDialogShow(_searchGameDialogShow: boolean) {
      searchGameDialogShow.value = _searchGameDialogShow
    }
    function setSearchTextList(searchText: string) {
      const sameSearchText = searchTextList.value.filter((item) => item == searchText)
      if (sameSearchText.length == 0) {
        searchTextList.value.push(searchText)
      }
    }
    function removeSearchTextList(index: number) {
      searchTextList.value.splice(index, 1)
    }
    function removeAllSearchTextList() {
      searchTextList.value = []
    }
    function setGameFilterText(_gameFilterText: string) {
      gameFilterText.value = _gameFilterText
    }
    function setOriginalGames(_originalGames: Array<SharedSearchType>) {
      originalGames.value = _originalGames
    }
    function setMobileMenuShow(_mobileMenuShow: boolean) {
      mobileMenuShow.value = _mobileMenuShow
    }
    function setGameHistoryItem(_gameHistoryItem: SharedGameHistoryResponse) {
      gameHistoryItem.value = _gameHistoryItem
    }
    function setUserSpinPage(_userSpinPage: any) {
      userSpinPage.value = _userSpinPage
    }
    function setUserSpin(_userSpin: any) {
      userSpin.value = _userSpin
    }
    function setLanguage(lang: string) {
      language.value = lang
    }
    function setFavoriteGameList(_favoriteGameList: Array<string>) {
      favoriteGameList.value = _favoriteGameList
    }
    function openDialog(type: DialogType) {
      authStore.setAuthModalType(type)
      authStore.setAuthDialogVisible(true)
      appBarStore.setOverlayScrimShow(false) // Assuming this is from appBarStore
    }
    function closeKill() {
      betby.value?.kill()
    }
    function setGameBigWinItem(_gameBigWinItem: GameBigWinData) {
      gameBigWinItem.value = _gameBigWinItem
    }

    // Betby specific logic - likely remains similar, ensure `enterGameItem.value.reserve` corresponds to the token needed.
    // This part is highly dependent on the Betby SDK and its initialization requirements.
    // If `enterGameItem.value.reserve` was populated by the old `dispatchGameEnter`, the new one should do the same.
    // The `BTRenderer` is a global from Betby's script.
    async function getGameBetbyInit() {
      if (!enterGameItem.value?.launch_url) {
        // Check for launch_url as per LaunchGameResponseDto
        // The '9999' ID for Betby might be a special case
        await dispatchGameEnter({ id: 'betby-sportbook', demo: false }) // Use a descriptive ID
      }
      if (betby.value) {
        // If already initialized, kill and re-init
        closeKill()
      }
      if (typeof (window as any).BTRenderer === 'undefined') {
        console.error('Betby BTRenderer is not available. Ensure Betby script is loaded.')
        setErrorMessage('Sportsbook is currently unavailable.')
        return
      }
      // Assuming enterGameItem.value.launch_url contains the token or relevant param for Betby
      // The structure of provider_parameters in LaunchGameResponseDto would be important here
      // For now, let's assume the launch_url itself or a parameter within it (like 'token') is needed.
      // This needs to align with how your `gameRouter.launchGame` for Betby prepares `LaunchGameResponseDto`
      const betbyToken =
        enterGameItem.value?.provider_parameters?.token || enterGameItem.value?.launch_url

      if (!betbyToken) {
        setErrorMessage('Failed to get Betby token.')
        return
      }

      betby.value = new (window as any).BTRenderer().initialize({
        token: betbyToken, // This token should come from your launchGame oRPC call for Betby
        lang: language.value,
        target: document.getElementById('betby'), // Ensure this element exists
        brand_id: '2331516940205559808', // This is specific, ensure it's correct
        betSlipOffsetTop: 0,
        betslipZIndex: 999,
        themeName: 'default', // Or your custom theme
        onLogin: () => openDialog('login'),
        onRegister: () => openDialog('signup'),
        onTokenExpired: async () => {
          closeKill()
          await dispatchGameEnter({ id: 'betby-sportbook', demo: false }) // Re-fetch token
          await getGameBetbyInit()
        },
        onSessionRefresh: async () => {
          // Similar to token expired
          closeKill()
          await dispatchGameEnter({ id: 'betby-sportbook', demo: false })
          await getGameBetbyInit()
        },
      })
    }

    async function dispatchGameCategories() {
      // Removed sub_api, handle developer list separately if needed
      setSuccess(false)
      try {
        // Assuming getGameCategories returns PrismaGameCategoryName[]
        const categoriesNames = await restClient.game.getGameCategories.call()
        setSuccess(true)
        // This mapping is now different as server returns names, not ClientGameCategory structure
        // You might need another endpoint or client-side mapping if ClientGameCategory structure is complex
        const clientCategories: ClientGameCategory[] = categoriesNames.map((name) => ({
          name: name,
          slug: name.toLowerCase().replace('_', '-'),
          // Other fields need to be populated from elsewhere or defaults
          image: '',
          pictures: '',
          game_count: 0,
          games: [],
          page_no: 0,
        }))
        setGameCategories(clientCategories)
      } catch (error: any) {
        setErrorMessage(handleException(error.code || 500))
      }
    }

    async function dispatchGameDevelopers() {
      setSuccess(false)
      try {
        const developers = await restClient.game.getGameProviders.call()
        setSuccess(true)
        setGamedevelopers(developers)
      } catch (error: any) {
        setErrorMessage(handleException(error.code || 500))
      }
    }

    async function dispatchGameSearch(payload?: GameUserBody) {
      // GameUserBody might not map directly to GameSearchQuerySchema
      setSuccess(false)
      try {
        const queryParams: z.infer<typeof GameSearchQuerySchema> = {
          // Map from GameUserBody if necessary
          // category: payload?.game_categories_slug as PrismaGameCategoryName, // Needs careful mapping/validation
          page: payload?.page,
          limit: payload?.limit,
          isActive: true,
        }
        const response = await restClient.game.searchGames.call(queryParams)
        setSuccess(true)
        setGameSearchList({
          items: response.items as unknown as SharedSearchType[], // items are SharedPrismaGame, might need mapping to SharedSearchType
          total: response.total,
        })
        setOriginalGames(response.items as unknown as SharedSearchType[]) // Store for client-side filtering if needed
      } catch (error: any) {
        setGameSearchList({ items: [], total: 0 })
        setOriginalGames([])
        setErrorMessage(handleException(error.code || 500))
      }
    }

    async function dispatchFavoriteGame(gameId: string, isFavorite: boolean) {
      setSuccess(false)
      try {
        await restClient.game.setFavoriteGame.call({ gameId, isFavorite })
        setSuccess(true)
        // After setting, re-fetch favorite list
        await dispatchGameFavoriteList()
      } catch (error: any) {
        setErrorMessage(handleException(error.code || 500))
      }
    }

    async function dispatchGameEnter(data: GameEnterBody) {
      setSuccess(false)
      try {
        const response = await restClient.game.launchGame.call({
          id: data.id as string,
          demo: data.demo,
        })
        setSuccess(true)
        setErrorMessage('')
        setGameEnterItem(response) // Response is LaunchGameResponseDto
      } catch (error: any) {
        setErrorMessage(handleException(error.code || 500))
        setGameEnterItem(null)
      }
    }

    async function dispatchGameHistory(data?: { page?: number; limit?: number }) {
      setSuccess(false)
      try {
        const response = await restClient.game.getGameHistory.call(data)
        setSuccess(true)
        setGameHistoryItem({
          total_pages: response.totalPages ?? 0,
          record: response.items,
        })
      } catch (error: any) {
        setErrorMessage(handleException(error.code || 500))
      }
    }

    // dispatchUserSpinPage and dispatchUserSpin need specific oRPC endpoints
    // For now, they remain as placeholders calling non-existent oRPC methods
    async function dispatchUserSpinPage(data: any) {
      setSuccess(false)
      try {
        // Example: const response = await restClient.game.getUserSpinPageData.call(data);
        console.warn('dispatchUserSpinPage: oRPC endpoint not implemented')
        // setUserSpinPage(response);
        setSuccess(true)
      } catch (error: any) {
        setErrorMessage(handleException(error.code || 500))
      }
    }

    async function dispatchUserSpin() {
      setSuccess(false)
      try {
        // Example: const response = await restClient.game.executeUserSpin.call();
        console.warn('dispatchUserSpin: oRPC endpoint not implemented')
        // setUserSpin(response);
        setSuccess(true)
      } catch (error: any) {
        setErrorMessage(handleException(error.code || 500))
      }
    }

    async function dispatchGameBigWin() {
      setSuccess(false)
      try {
        const bigWinsData = await restClient.game.getGameBigWins.call()
        setGameBigWinItem(bigWinsData)
        setSuccess(true)
      } catch (error: any) {
        setErrorMessage(handleException(error.code || 500))
      }
    }

    async function dispatchGameFavoriteList() {
      setSuccess(false)
      if (!authStore.isAuthenticated) {
        setFavoriteGameList([])
        return
      }
      try {
        const favIds = await restClient.game.getFavoriteGames.call()
        setFavoriteGameList(favIds)
        setSuccess(true)
      } catch (error: any) {
        setErrorMessage(handleException(error.code || 500))
      }
    }
    // RTG specific actions
    async function dispatchRtgSettings(payload: RTGSettingsRequestDto) {
      setSuccess(false)
      try {
        const response = await restClient.game.rtgSettings.call(payload)
        setSuccess(true)
        // Handle response - e.g., store session data, update UI
        // This might involve setting parts of enterGameItem or a dedicated state for game provider sessions
        console.log('RTG Settings Response:', response)
        if (response.result) {
          // Example: Store RTG session token if needed by the game client
          // authStore.setGameProviderSession('rtg', response.result.user.token);
        }
        return response
      } catch (error: any) {
        setErrorMessage(handleException(error.code || 500))
        throw error
      }
    }

    async function dispatchRtgSpin(payload: RTGSpinRequestDto) {
      setSuccess(false)
      try {
        const response = await restClient.game.rtgSpin.call(payload)
        setSuccess(true)
        // Handle spin response - update balance, game state, etc.
        console.log('RTG Spin Response:', response)
        // This would typically trigger balance updates via user store or direct mutation here
        // authStore.fetchCurrentUser(); // Example: refresh user balance
        return response
      } catch (error: any) {
        setErrorMessage(handleException(error.code || 500))
        throw error
      }
    }

    return {
      success,
      errMessage,
      gameCategories,
      gameDevelopers,
      gameSearchList,
      enterGameItem,
      searchGameDialogShow,
      mobileMenuShow,
      searchTextList,
      gameFilterText,
      originalGames,
      gameHistoryItem,
      userSpinPage,
      userSpin,
      language,
      betby,
      gameBigWinItem,
      favoriteGameList,
      setSuccess,
      setErrorMessage,
      setGameCategories,
      setGamedevelopers,
      setGameSearchList,
      setGameEnterItem,
      setSearchGameDialogShow,
      setSearchTextList,
      removeSearchTextList,
      removeAllSearchTextList,
      setGameFilterText,
      setOriginalGames,
      setMobileMenuShow,
      setGameHistoryItem,
      setUserSpinPage,
      setUserSpin,
      setLanguage,
      setFavoriteGameList,
      openDialog,
      closeKill,
      setGameBigWinItem,
      getGameBetbyInit,
      dispatchGameCategories,
      dispatchGameDevelopers,
      dispatchGameSearch,
      dispatchFavoriteGame,
      dispatchGameEnter,
      dispatchGameHistory,
      dispatchUserSpinPage,
      dispatchUserSpin,
      dispatchGameBigWin,
      dispatchGameFavoriteList,
      dispatchRtgSettings,
      dispatchRtgSpin,
    }
  },
  {
    persist: {
      paths: ['searchTextList', 'favoriteGameList', 'language'], // Persist only these specific states
      storage: localStorage,
    },
  }
)
// // Suggested content for: ai_folder/packages/types/src/interface/game.ts
// // This file should be reviewed to ensure RTGSpinResponseDto, RtgSpinResult,
// // ProviderSpinResponseData, and ProviderSettingsResponseData are consistent
// // and that Provider types can be safely cast or mapped to RtgSpinResult/RtgSettingsResult.

// // Original imports from your file
// // import { GameSession, Prisma, Wallet as PrismaWallet, Transaction as PrismaTransaction, GameSpin as PrismaGameSpin } from 'shared';
// // import { CurrencyInfo } from './currency';
// // import { UserProfile } from '../index'; // Use UserProfile from the main types entry
// // import { JsonArray } from '@prisma/client/runtime/library'; // This might need to be Prisma.JsonArray

// // Ensure RTGUser, RtgSettingsBalance, ResultGame etc. are what ProviderSettingsResponseData maps to.
// // Ensure RTGUser, RtgSpinBalance, RtgGame etc. are what ProviderSpinResponseData maps to.

// // Example: RTGSpinResponseDto and RtgSpinResult
// // (Assuming RtgSpinResult is the actual data payload when success is true)

// // Provider's raw response shape for user settings/init call (e.g., from RTG)
// // This is what `proxyRequestToRgs` will return for settings.
// // Based on your `ProviderSettingsResponseData` type in the original game.service.ts context.
// export interface ProviderSettingsResponseData {
//   user: {
//     balance: { cash: string; freeBets?: string; bonus?: string; [key: string]: any }
//     canGamble: boolean
//     userId: number | string // Provider's user ID
//     sessionId: string // Provider's session ID
//     sessionNetPosition?: string
//     token: string // Provider's session token
//     country?: string
//     currency?: { code: string; symbol: string }
//     stakes?: any
//     limits?: any
//     serverTime: string // ISO Date string
//     [key: string]: any // Allow other provider-specific fields
//   }
//   game?: {
//     version?: string
//     gameType?: string
//     [key: string]: any
//   }
//   launcher?: {
//     version?: string
//     [key: string]: any
//   }
//   jackpots?: any
//   // ... any other top-level properties from the provider's settings response
// }

// // The DTO your /rtg/settings endpoint will return to the client
// export interface RTGSettingsResponseDto {
//   success: boolean
//   result?: ProviderSettingsResponseData // If successful, this is the data from the provider
//   error?: {
//     code: string
//     message: string
//     details?: any
//   }
// }

// // Provider's raw response shape for a spin/play call (e.g., from RTG)
// // This is what `proxyRequestToRgs` will return for a spin.
// // Based on your `ProviderSpinResponseData` type in the original game.service.ts context.
// export interface ProviderSpinResponseData {
//   transactions: {
//     roundId: number | string // Provider's round ID
//     [key: string]: any
//   }
//   user: {
//     balance: {
//       // Balance structure after spin
//       cash: { atStart?: string; afterBet?: string; atEnd: string } // atEnd is primary
//       freeBets?: { atStart?: string; afterBet?: string; atEnd: string }
//       bonus?: { atStart?: string; afterBet?: string; atEnd: string }
//       [key: string]: any
//     }
//     userId: number | string
//     sessionId: string
//     sessionNetPosition?: string
//     token: string
//     serverTime: string // ISO Date string
//     canGamble?: boolean
//     [key: string]: any
//   }
//   game: {
//     win: {
//       instantWin?: string
//       lines?: string
//       total: string // Total win amount as string from provider
//       [key: string]: any
//     }
//     stake: string // Stake amount for this spin
//     multiplier?: number
//     winLines?: any[]
//     reelsBuffer?: Array<Array<number[]>>
//     [key: string]: any // Other game-specific outcomes
//   }
//   jackpots?: any | null
//   bonusChance?: any | null
//   // Any other fields specific to the provider's spin response
// }

// // This is the "result" part of RTGSpinResponseDto,
// // it should be structurally compatible with ProviderSpinResponseData.
// // If they are identical, you can alias: export type RtgSpinResult = ProviderSpinResponseData;
// // If not, define RtgSpinResult explicitly and map ProviderSpinResponseData to it.
// export type RtgSpinResult = ProviderSpinResponseData // Assuming direct compatibility for now. Adjust if needed.

// // The DTO your /rtg/spin endpoint will return to the client
// export interface RTGSpinResponseDto {
//   success: boolean
//   result?: RtgSpinResult // If successful, this is the (potentially mapped) data
//   error?: {
//     code: string
//     message: string
//     details?: any
//   }
// }

// // Request DTOs remain largely the same, ensure they match provider's requirements
// export interface RTGSettingsRequestDto {
//   gameId: string
//   token: string // Platform session token or provider specific?
//   userId: string // Platform user ID, possibly prefixed
//   currency: string
//   language: string
//   mode: 'real' | 'demo'
//   // Include all other fields RTG /settings endpoint expects
//   // Based on original game.ts:
//   custom?: { siteId?: string; extras?: string; [key: string]: any }
//   userData?: {
//     userId?: string | number
//     hash?: string
//     affiliate?: string
//     lang?: string
//     channel?: string
//     userType?: string
//     fingerprint?: string
//     [key: string]: any
//   }
//   // [key: string]: any; // For flexibility if many varying fields
// }

// export interface RTGSpinRequestDto {
//   token: string // Platform session token OR provider's game session token
//   userId: string // Platform user ID, possibly prefixed for provider
//   gameId: string // Provider's game ID
//   stake: number | string // Stake amount
//   currency: string
//   sessionId: string // THIS IS CRUCIAL - Provider's session ID obtained from settings call
//   playMode?: 'real' | 'demo'
//   actions?: any[] // Specific game actions
//   // Include all other fields RTG /spin endpoint expects
//   // Based on original game.ts context and game.ts type file:
//   custom?: { siteId?: string; extras?: string; [key: string]: any }
//   bonusId?: any
//   extras?: any
//   siteId?: string
//   userType?: string
//   lang?: string | number
//   fingerprint?: string | number
//   channel?: string | number
//   affiliate?: string | number
//   userData?: {
//     userId?: string | number
//     affiliate?: string
//     lang?: string
//     channel?: string
//     userType?: string
//     [key: string]: any
//   }
//   roundId?: string | number // Optional if client tracks/sends it
//   transactionId?: string | number // Optional platform-side tx id if sent to provider
//   // [key: string]: any;
// }

// // --- GamePlatformSpinResultDetails (Internal Backend Type) ---
// // This defines the structure returned by your internal handlePlatformGameRound function.
// // It uses Prisma's GetPayload types for precision.
// export interface GamePlatformSpinResultDetails {
//   betTransaction: Prisma.TransactionGetPayload<{
//     include: {
//       originatorUser: {
//         // Renamed from originatedUser for consistency if schema uses 'originatorUser'
//         select: {
//           id: true
//           username: true
//         }
//       }
//     }
//   }>
//   winTransaction?: Prisma.TransactionGetPayload<{
//     include: {
//       originatorUser: {
//         // Renamed for consistency
//         select: {
//           id: true
//           username: true
//         }
//       }
//     }
//   }> | null
//   finalPlatformWallet: PrismaWallet
//   updatedGameSession: PrismaGameSession
//   gameSpinRecord: PrismaGameSpin
//   xpAwardedThisSpin: number
//   tournamentPointsAwardedThisSpin: number
// }

// // Other existing types from your packages/types/src/interface/game.ts
// // ... (GameCategoryName, Game, RTGUser, ResultGame, Launcher, etc. - review for consistency with above)
// // It's important that if RTGUser used in RtgSpinResult is different from RTGUser used in RTGSettingsResponseDto's result,
// // they are named distinctly, e.g., RtgSettingsUser, RtgSpinUser.
// // The ProviderSpinResponseData and ProviderSettingsResponseData above try to generalize this.

// export { GameSession } // Re-export if used directly by client-facing types

// export type GameCategoryName = 'TABLE' | 'FISH' | 'POKER' | 'SLOTS' | 'OTHER' //

// // ... (Keep other types like GameListResponse, Search, GameItem, etc., ensuring they align)
// // For GameListResponse and GetGameSearchResponse, ensure they use the updated PaginatedResponse structure if applicable.

// export interface GameListResponse {
//   // Example if you keep this specific structure
//   code: number
//   list: Game[] // Define Game type if not already
//   total: number
// }

// export interface Game {
//   // Basic Game definition, expand as needed
//   id: string
//   name: string
//   title: string
//   providerName?: string // Was 'developer'
//   providerGameId?: string // External ID from provider
//   category?: GameCategoryName // from enum GameCategory in schema
//   isActive?: boolean
//   thumbnailUrl?: string
//   popularity?: number
//   // ... other fields from your Prisma Game model that client needs
// }
// // Ensure all DTOs used in game.service.ts (like LaunchGameResponseDto) are defined here too.
// export interface LaunchGameResponseDto {
//   launch_url: string
//   game_session_id?: string
//   launch_strategy?: 'IFRAME' | 'REDIRECT' | 'POPUP'
//   provider_parameters?: Record<string, any> | string
// }
// // import { GameSession } from 'shared'
// // import { CurrencyInfo } from './currency'
// // import { UserProfile } from './user'
// // import { JsonArray } from '@prisma/client/runtime/library'

// // export type GameCategoryName = 'TABLE' | 'FISH' | 'POKER' | 'SLOTS' | 'OTHER'

// // export interface Game {
// //   id: string
// //   name: string
// //   title: string
// //   temperature: string | null
// //   developer: string | null
// //   vipLevel: number | null
// //   isActive: boolean | null
// //   device: number | null
// //   featured: boolean | null
// //   gamebank: string | null
// //   bet: number | null
// //   denomination: number | null
// //   categoryTemp: number | null
// //   originalId: number | null
// //   bids: number | null
// //   statIn: number | null
// //   statOut: number | null
// //   currentRtp: number | null
// //   rtpStatIn: number | null
// //   rtpStatOut: number | null
// //   standardRtp: number | null
// //   popularity: number | null
// //   chanceFirepot1: number | null
// //   chanceFirepot2: number | null
// //   chanceFirepot3: number | null
// //   fireCount1: number | null
// //   fireCount2: number | null
// //   fireCount3: number | null
// //   linesPercentConfigSpin: string | null
// //   linesPercentConfigSpinBonus: string | null
// //   linesPercentConfigBonus: string | null
// //   linesPercentConfigBonusBonus: string | null
// //   rezerv: number | null
// //   cask: number | null
// //   advanced: string | null
// //   scaleMode: string
// //   slotViewState: string
// //   view: number | null
// //   categoryId: string | null
// //   operatorId: string | null
// //   providerId: string | null
// //   createdAt: Date
// //   updatedAt: Date
// //   category: GameCategoryName
// //   jackpotGroupId: string | null
// //   active: boolean
// //   password: string | null
// //   // ope
// //   // rator: Operator | null;
// // }
// // export interface RTGSettingsRequestDto {
// //   token: string
// //   gameId: string
// //   userData: {
// //     userId: string
// //     hash: string
// //     affiliate: string
// //     lang: string
// //     channel: string
// //     userType: string
// //     fingerprint: string
// //   }
// //   custom: {
// //     siteId: string
// //     extras: string
// //   }
// // }
// // export interface RTGSettingsResponseDto {
// //   success: boolean
// //   result: RtgSettingsResult
// // }

// // export interface RtgSettingsResult {
// //   user: RTGUser
// //   game: ResultGame
// //   launcher: Launcher
// //   jackpots: null
// // }

// // export interface ResultGame {
// //   cols: number
// //   rows: number
// //   offset: number
// //   multiplierSequence: MultiplierSequence
// //   extraWin: ExtraWin
// //   lines: Array<number[]>
// //   tiles: Tile[]
// //   reelsBuffer: Array<Array<number[]>>
// //   paysType: string
// //   features: string[]
// //   singlePayline: boolean
// //   hasState: boolean
// //   version: string
// //   rtp: RTP
// //   volatilityIndex: string
// //   maxMultiplier: string
// //   maxWinlineHitRate: string
// //   maxMultiplierHitRate: string
// //   maxMultiplierHitFrequency: string
// //   maxMultiplierWinLines: string
// //   maxMultiplierWinLinesHitRate: string
// //   maxMultiplierWinLinesHitFrequency: string
// //   hasGambleGame: boolean
// //   gameType: string
// //   stateful: boolean
// //   hasChoices: boolean
// //   stateExpireDays: null
// //   hasBonuses: boolean
// //   pendingRoundDays: number
// //   skin: null
// //   hasFeatureBuy: boolean
// // }

// // export interface ExtraWin {
// //   bigWin: string
// //   superWin: string
// //   megaWin: string
// // }

// // export interface MultiplierSequence {
// //   Progress: Progress[]
// // }

// // export interface Progress {
// //   count: number
// //   multiplier: number
// //   spins: number
// // }

// // export interface RTP {
// //   game: RtgGame
// // }

// // // export interface RtgGame {
// // //   default: string

// // export interface Tile {
// //   id: number
// //   type: Type
// //   pays: string[]
// // }

// // export enum Type {
// //   Normal = 'normal',
// //   Scatter = 'scatter',
// // }

// // export interface Launcher {
// //   version: string
// // }

// // export interface RTGUser {
// //   balance: RtgSettingsBalance | RtgSpinBalance
// //   notifications: any[]
// //   messages: any[]
// //   bonuses: any[]
// //   tournaments: any[]
// //   vouchers: any[]
// //   userId: number
// //   country: string
// //   casino: string
// //   vertical: string
// //   currency: Currency
// //   token: string
// //   sessionId: string
// //   sessionNetPosition: string
// //   aamsParticipationId: null
// //   aamsSessionId: null
// //   depositedAmount: string
// //   maxDeposit: string
// //   canGamble: boolean
// //   lastWin: string
// //   prevRounds: any[]
// //   limits: Limits
// //   stakes: Stakes
// //   autoplay: Autoplay
// //   serverTime: Date
// //   additional: null
// // }

// // export interface Autoplay {
// //   type: string
// //   options: Options
// // }

// // export interface Options {
// //   spins: RtgSpins
// //   stopOnFeature: StopOnFeature
// //   stopOnLossLimits: StopOnLossLimits
// //   stopOnWin: StopOnWin
// //   hasRestart: boolean
// // }

// // export interface RtgSpins {
// //   values: string[]
// //   default: number
// // }

// // export interface StopOnFeature {
// //   enabled: boolean
// // }

// // export interface StopOnLossLimits {
// //   mandatory: boolean
// //   enabled: boolean
// //   values: string[]
// //   default: number
// // }

// // export interface StopOnWin {
// //   enabled: boolean
// //   values: string[]
// // }

// // export interface RtgSettingsBalance {
// //   cash: string
// //   freeBets: string
// //   sessionCash: string
// //   sessionFreeBets: string
// //   bonus: string
// // }

// // export interface Currency {
// //   code: string
// //   symbol: string
// // }

// // export interface Limits {
// //   maxGambleStake: string
// //   maxTotalStake: TotalStake
// //   minTotalStake: TotalStake
// //   spinDuration: null
// // }

// // export interface TotalStake {
// //   total: string
// // }

// // export interface Stakes {
// //   defaultIndex: number
// //   lastIndex: number
// //   types: string[]
// // }

// // export interface GameCategory {
// //   image: string
// //   pictures: string
// //   game_count: string | number
// //   name: string
// //   slug: string
// //   games: Array<Search>
// //   page_no: number
// // }
// // export interface GameListResponse {
// //   code: number
// //   list: Array<Game>
// //   total: number
// // }
// // export interface Search {
// //   id: string
// //   name: string
// //   image: string
// //   developer: string
// //   is_demo: boolean
// // }

// // export interface GameItem {
// //   id: number
// //   name: string
// //   image: string
// //   developer: string
// //   producer: string
// //   is_demo: boolean
// // }

// // export interface GameEnterBody {
// //   id: string | Array<string>
// //   demo: boolean
// // }

// // export interface GameUserBody {
// //   game_categories_slug: string
// //   page: number
// //   limit: number
// // }

// // export interface GameEnterResponse {
// //   method: string
// //   parames: string
// //   developer: string
// //   reserve: string
// //   weburl: string
// // }

// // export interface GameHistoryItem {
// //   name: string
// //   created_at: number
// //   amount: string | number
// //   multiplier: string | number
// //   bet_id: string | number
// //   status: string | number
// //   profit: number
// // }

// // export interface GameBigWinItem {
// //   game_id: string
// //   game_name: string
// //   game_icon: string
// //   user_name: string
// //   user_vip_group: number
// //   user_vip_level: number
// //   bet_amount: string
// //   multiplier: string
// //   win_amount: string
// //   time: number
// // }

// // export interface GameBigWinData {
// //   high_rollers: Array<GameBigWinItem>
// //   lucky_bets: Array<GameBigWinItem>
// // }

// // export interface GameHistoryResponse {
// //   total_pages: number
// //   record: Array<GameHistoryItem>
// // }

// // export interface GameSearchResponse {
// //   items: Array<Search>
// //   total: number
// // }

// // export type GetGameFavoriteListResponse = {
// //   code: number
// //   data: Array<number | string>
// //   message: string
// // }

// // export type GetGameBigWinResponse = {
// //   code: number
// //   data: GameBigWinData
// //   message: string
// // }
// // export type Category = {
// //   name: string
// //   games: Game[]
// // }

// // export type GetGameCategoriesResponse = {
// //   code: number
// //   data: Array<any>
// //   messsage: string
// // }

// // export type GetGameSearchResponse = {
// //   code: number
// //   data: GameSearchResponse
// //   message: string
// // }

// // export type GetGameEnterResponse = {
// //   code: number
// //   data: GameEnterResponse
// //   gameSession: GameSession
// //   message: string
// // }

// // export type GetGameHistoryResponse = {
// //   code: number
// //   data: GameHistoryResponse
// //   message: string
// // }

// // /**
// //  * Represents a Game Provider.
// //  * Based on the Prisma 'GameProvider' model.
// //  */
// // export interface GameProvider {
// //   id: string
// //   name: string
// //   slug: string
// //   description?: string | null
// //   logo_url?: string | null
// //   is_enabled: boolean
// //   created_at: Date
// //   updated_at: Date
// // }

// // /**
// //  * Represents a Game. Based on the Prisma 'Game' model.
// //  */
// // export interface GameType {
// //   id: string
// //   name: string
// //   slug: string
// //   provider_id: string
// //   category_id?: string | null
// //   description?: string | null
// //   thumbnail_url?: string | null
// //   banner_url?: string | null
// //   external_game_id?: string | null // ID from the game provider
// //   tags?: string[]
// //   rtp?: number | null // Return to Player percentage
// //   volatility?: string | null // e.g., 'low', 'medium', 'high'
// //   is_active: boolean
// //   is_featured?: boolean
// //   launch_options?: Record<string, any> | null // JSON for specific launch params
// //   created_at: Date
// //   updated_at: Date
// //   provider?: GameProvider // Optional relation
// //   // category?: GameCategoryType; // Optional relation
// // }

// // /**
// //  * Represents a Game Round or history entry.
// //  * Based on the Prisma 'GameRound' model.
// //  */
// // export interface GameSpin {
// //   id: string
// //   user_id: string
// //   game_id: string
// //   currency_id: string
// //   bet_amount: number // Consider using a Decimal library
// //   win_amount: number // Consider using a Decimal library
// //   profit: number // Consider using a Decimal library (win_amount - bet_amount)
// //   external_round_id?: string | null // ID from the game provider, if available
// //   status: string // e.g., 'PENDING', 'COMPLETED', 'FAILED'
// //   bet_details?: Record<string, any> | null // JSON for complex bet info
// //   win_details?: Record<string, any> | null // JSON for complex win info
// //   created_at: Date
// //   updated_at: Date
// //   user?: UserProfile // Optional relation
// //   game?: GameType // Optional relation
// //   currency?: CurrencyInfo // Optional relation
// // }
// // /**
// //  * Represents a Game Round or history entry.
// //  * Based on the Prisma 'GameRound' model.
// //  */
// // export interface RawGameSpinBody {
// //   user_id: string
// //   game_id: string
// //   currency_id: string
// //   rawVendorData: JsonArray
// //   created_at: Date
// // }
// // // Suggested location: packages/types/src/interface/game.ts
// // export interface LaunchGameResponseDto {
// //   /**
// //    * The URL to launch the game session.
// //    * This could be an iframe source or a URL for redirection.
// //    */
// //   launch_url: string

// //   /**
// //    * A unique session identifier for this game launch, if provided by the game aggregator or server.
// //    * Can be used for tracking or further communication related to this session.
// //    */
// //   game_session_id?: string

// //   /**
// //    * Any specific strategy for launching the game (e.g., 'IFRAME', 'REDIRECT', 'POPUP').
// //    * Optional, defaults to client figuring it out or a standard method.
// //    */
// //   launch_strategy?: 'IFRAME' | 'REDIRECT' | 'POPUP'

// //   /**
// //    * Additional parameters or tokens required by the game provider, serialized as a string
// //    * or as a nested object.
// //    * Optional.
// //    */
// //   provider_parameters?: Record<string, any> | string
// // }
// // export interface RTGSpinRequestDto {
// //   gameId: string
// //   custom: {
// //     siteId: string
// //     extras: string
// //   }
// //   bonusId: any
// //   extras: any
// //   siteId: string
// //   userType: string
// //   lang: number
// //   fingerprint: number
// //   channel: number
// //   affiliate: number
// //   userData: {
// //     userId: number
// //     affiliate: string
// //     lang: string
// //     channel: string
// //     userType: string
// //   }
// //   token: string

// //   stake: number
// //   sessionId: string
// //   playMode: string
// // }
// // export interface RTGSpinResponseDto {
// //   success: boolean
// //   result: RtgSpinResult
// //   error?: any
// // }

// // export interface RtgSpinResult {
// //   transactions: Transactions
// //   user: RTGUser
// //   game: RtgGame
// //   jackpots: null
// //   bonusChance: null
// // }

// // export interface RtgGame {
// //   win: Win
// //   winsMultipliers: Win
// //   stake: string
// //   multiplier: number
// //   winLines: any[]
// //   spinMode: string
// //   fatTiles: FatTile[]
// //   instantWin: InstantWin
// //   actions: Action[]
// //   scatters: any[]
// //   reelsBuffer: Array<Array<number[]>>
// //   features: any[]
// //   hasState: boolean
// // }

// // export interface Action {
// //   type: string
// //   data: Data
// // }

// // export interface Data {
// //   multiplier?: number
// //   index?: number
// //   fatTiles?: FatTile[]
// // }

// // export interface FatTile {
// //   tileId: number
// //   reel: number
// //   index: number
// //   width: number
// //   height: number
// //   multiplier: number
// //   amount: string
// // }

// // export interface InstantWin {
// //   multiplier: string
// //   amount: string
// //   options: string[]
// // }

// // export interface Win {
// //   instantWin: string
// //   lines: string
// //   total: string
// // }

// // export interface Transactions {
// //   roundId: number
// // }

// // export interface RTGUser {
// //   balance: RtgSpinBalance | RtgSettingsBalance
// //   canGamble: boolean
// //   userId: number
// //   sessionId: string
// //   sessionNetPosition: string
// //   token: string
// //   bonuses: any[]
// //   tournaments: any[]
// //   vouchers: any[]
// //   messages: any[]
// //   limits: Limits
// //   serverTime: Date
// // }

// // export interface RtgSpinBalance {
// //   cash: RtgBonus
// //   freeBets: RtgBonus
// //   bonus: RtgBonus
// //   sessionCash: RtgBonus
// //   sessionFreeBets: RtgBonus
// // }

// // export interface RtgBonus {
// //   atStart: string
// //   afterBet: string
// //   atEnd: string
// // }

// // export interface Limits {
// //   betThresholdTime: number
// // }

// // import type {
// //   Wallet as PrismaWallet,
// //   Transaction as PrismaTransaction,
// //   GameSession as PrismaGameSession,
// //   GameSpin as PrismaGameSpin,
// //   Prisma,
// // } from 'shared' // Assuming Prisma types are re-exported

// // // --- ProviderSettingsResponseData ---
// // // This is the expected structure of the data AFTER your proxy calls the
// // // game provider's /settings or /initUser endpoint.
// // // Your existing `game.ts` has RTG-specific types like RTGUser, RtgSettingsBalance, etc.
// // // that fulfill this. For RTG, this would be something like:

// // export interface RtgSettingsBalance {
// //   // As per your game.ts
// //   cash: string // Provider's balance for the user, often a string representation
// //   freeBets: string
// //   bonus: string
// //   // ... other balance types if any
// // }

// // export interface RTGUserForSettings {
// //   // Based on RTGUser in your game.ts
// //   balance: RtgSettingsBalance
// //   canGamble: boolean
// //   userId: number | string // Provider's user ID
// //   sessionId: string // Provider's session ID for this game session
// //   sessionNetPosition?: string
// //   token: string // Provider's session token (might be same as sessionId or different)
// //   bonuses?: any[]
// //   tournaments?: any[]
// //   vouchers?: any[]
// //   messages?: any[]
// //   limits?: any // Define if structure is known
// //   serverTime: string // ISO Date string
// //   // ... any other fields RTG returns on settings/init
// // }

// // // This is the actual data structure returned by a provider's settings call.
// // // For RTG, it's wrapped in the `RTGSettingsResponseDto` which has a `result` field.
// // // So, `ProviderSettingsResponseData` would be the type of that `result` field.
// // export type ProviderSettingsResponseData = RTGUserForSettings & {
// //   // Include other top-level properties returned by the provider for settings
// //   // Example from your game.ts ProviderSettingsResponseData
// //   game?: {
// //     version?: string
// //     gameType?: string
// //     // ... other game-specific settings from provider
// //   }
// //   launcher?: {
// //     version?: string
// //   }
// //   // Any other fields specific to the provider's settings response
// // }

// // // --- ProviderSpinResponseData ---
// // // This is the expected structure of the data AFTER your proxy calls the
// // // game provider's /spin or /play endpoint.
// // // Your existing `game.ts` has RTG-specific types.

// // export interface RtgSpinWinDetails {
// //   // As per Win in your game.ts
// //   instantWin: string
// //   lines: string
// //   total: string // Total win amount as a string from provider
// // }

// // export interface RtgSpinGameDetails {
// //   // As per RtgGame in your game.ts
// //   win: RtgSpinWinDetails
// //   winsMultipliers?: RtgSpinWinDetails // Optional
// //   stake: string // Stake amount for this spin as a string
// //   multiplier?: number
// //   winLines?: any[]
// //   spinMode?: string
// //   reelsBuffer?: Array<Array<number[]>> // Or appropriate type
// //   // ... other game-specific outcomes from RTG spin
// //   actions?: any[] // Define if structure known
// //   features?: any[]
// //   hasState?: boolean
// // }

// // export interface RtgSpinTransactionDetails {
// //   // As per Transactions in your game.ts
// //   roundId: number | string // Provider's round ID
// //   // ... other transaction details from provider
// // }

// // export interface RtgSpinUserBalance {
// //   // As per RtgSpinBalance in your game.ts
// //   cash: {
// //     // Structure for cash balance after spin
// //     atStart: string
// //     afterBet: string
// //     atEnd: string // Provider's balance after this spin
// //   }
// //   // ... other balance types (freeBets, bonus) if applicable
// // }

// // export interface RTGUserForSpin {
// //   // Based on RTGUser in your game.ts
// //   balance: RtgSpinUserBalance // Different balance structure for spin
// //   userId: number | string
// //   sessionId: string
// //   sessionNetPosition?: string
// //   token: string
// //   serverTime: string // ISO Date string
// //   // ... other user-related fields from provider's spin response
// // }

// // // This is the actual data structure returned by a provider's spin call.
// // // For RTG, it's wrapped in the `RtgSpinResult` which has a `result` field.
// // // So, `ProviderSpinResponseData` would be the type of that `result` field.
// // export type ProviderSpinResponseData = {
// //   transactions: RtgSpinTransactionDetails
// //   user: RTGUserForSpin
// //   game: RtgSpinGameDetails
// //   jackpots?: any | null // Define if structure known
// //   bonusChance?: any | null // Define if structure known
// //   // Any other fields specific to the provider's spin response
// // }

// // // --- GamePlatformSpinResultDetails ---
// // // This is a new interface to standardize the data structure that
// // // `handlePlatformGameRound` returns after processing a spin and updating your platform.
// // // It's used internally within your backend.

// // export interface GamePlatformSpinResultDetails {
// //   betTransaction: Prisma.TransactionGetPayload<{
// //     // Select specific fields if you don't need the whole object
// //     include: {
// //       originatedUser: {
// //         select: {
// //           id: true
// //           username: true
// //         }
// //       }
// //     }
// //   }>
// //   winTransaction?: Prisma.TransactionGetPayload<{
// //     include: {
// //       originatedUser: {
// //         select: {
// //           id: true
// //           username: true
// //         }
// //       }
// //     }
// //   }> | null
// //   finalPlatformWallet: PrismaWallet // The user's wallet state on your platform AFTER the spin
// //   updatedGameSession: PrismaGameSession
// //   gameSpinRecord: PrismaGameSpin
// //   xpAwardedThisSpin: number
// //   tournamentPointsAwardedThisSpin: number
// //   // You might also include:
// //   // platformUserId: string;
// //   // platformGameId: string;
// //   // currencyId: string;
// //   // wagerAmountPlatformCents: number;
// //   // winAmountPlatformCents: number;
// // }
