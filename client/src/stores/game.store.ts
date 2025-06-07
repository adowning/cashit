/* eslint-disable @typescript-eslint/no-unused-vars */
import { useAppBarStore } from '@/stores/appBar.store'
import { useAuthStore } from '@/stores/auth.store'
import { defineStore } from 'pinia'
import { orpcManager } from '@/utils/orpc.client'

import { handleException } from './exception'
import {
  Game,
  GameBigWinData,
  GameEnterBody,
  GameEnterResponse,
  GameHistoryResponse,
  GameSearchResponse,
  GameUserBody,
  LaunchGameResponseDto,
  PrismaGame,
  Search,
} from 'shared'
import destr from 'destr'
import { GameCategory } from '@/interfaces'

type dialogType = 'login' | 'signup'

export const useGameStore = defineStore(
  'game',
  () => {
    /**
     * @state success - Indicates if the last operation was successful.
     */
    const success = ref<boolean>(false)
    /**
     * @state errMessage - Stores the error message if an operation fails.
     */
    const errMessage = ref<string>('')
    /**
     * @state errMessage - Stores the error message if an operation fails.
     */
    const isPlaying = ref<boolean>(false)
    /**
     * @state gameCategories - An array of game categories.
     */
    const gameCategories = ref<Array<GameCategory>>([])

    /**
     * @state gamedevelopers - An array of game developers.
     */
    const gamedevelopers = ref<Array<GameCategory>>([])

    /**
     * @state gameSearchList - Contains the list of searched games and the total count.
     */
    const gameSearchList = ref<GameSearchResponse>({
      items: [],
      total: 0,
    })

    /**
     * @state enterGameItem - Contains data required to enter a game.
     */
    const enterGameItem = ref<GameEnterResponse>({
      method: '',
      parames: '',
      developer: '',
      reserve: '',
      weburl: '',
    })
    const restClient = orpcManager.getRestClient()
    /**
     * @state searchGameDialogShow - Controls the visibility of the search game dialog.
     */
    const searchGameDialogShow = ref<boolean>(false)

    /**
     * @state mobileMenuShow - Controls the visibility of the mobile menu.
     */
    const mobileMenuShow = ref<boolean>(true)

    /**
     * @state searchTextList - An array of search terms.
     */
    const searchTextList = ref<Array<string>>([])

    /**
     * @state gameFilterText - The current text used for filtering games.
     */
    const gameFilterText = ref<string>('')

    /**
     * @state originalGames - An array to store the original list of games.
     */
    const originalGames = ref<Array<Search>>([])

    /**
     * @state gameHistoryItem - Contains the game history.
     */
    const gameHistoryItem = ref<GameHistoryResponse>({
      total_pages: 0,
      record: [],
    })

    /**
     * @state userSpinPage - Contains data about the user's spin page.
     */
    const userSpinPage = ref<any>({})

    /**
     * @state userSpin - Contains data about the user's spin.
     */
    const userSpin = ref<any>({})

    /**
     * @state language - The current language setting.
     */
    const language = ref<string>(localStorage.getItem('lang') || 'en')

    /**
     * @state betby - Stores the betby instance.
     */
    const betby = ref<any>(null)

    /**
     * @state gameBigWinItem - Contains data about big game wins.
     */
    const gameBigWinItem = ref<GameBigWinData>({
      high_rollers: [],
      lucky_bets: [],
    })

    /**
     * @state favoriteGameList - Stores the list of favorite games.
     */
    const favoriteGameList = ref<Array<number | string>>([])
    let injected: boolean = false

    // const styles: string = ''
    const scriptSrc: string = ''
    const initializeParams = {}

    // const target = 'bettech'

    let BTRenderer: any = null
    //  private styleElement: HTMLStyleElement;
    // const initialElement: HTMLMetaElement | null = null
    // const scriptElement: HTMLScriptElement | null = null

    /**
     * @action setSuccess - Sets the success state.
     * @param success - The new success value.
     */
    function setSuccess(_success: boolean) {
      success.value = _success
    }
    /**
     * @action setIsPlaying - Sets the success state.
     * @param success - The new success value.
     */
    function setIsPlaying(_isPlaying: boolean) {
      isPlaying.value = _isPlaying
    }

    /**
     * @action setErrorMessage - Sets the errMessage state.
     * @param message - The new error message.
     */
    function setErrorMessage(message: string) {
      errMessage.value = message
    }

    /**
     * @action setGameCategories - Sets the gameCategories state.
     * @param gameCategories - The new game categories.
     */
    function setGameCategories(_gameCategories: Array<GameCategory>) {
      gameCategories.value = _gameCategories
    }

    /**
     * @action setGamedevelopers - Sets the gamedevelopers state.
     * @param gamedevelopers - The new game developers.
     */
    function setGamedevelopers(_gamedevelopers: Array<GameCategory>) {
      gamedevelopers.value = _gamedevelopers
    }

    /**
     * @action setGameSearchList - Sets the gameSearchList state.
     * @param gameSearchList - The new game search list.
     */
    function setGameSearchList(_gameSearchList: GameSearchResponse) {
      gameSearchList.value = _gameSearchList
    }

    /**
     * @action setGameEnterItem - Sets the enterGameItem state.
     * @param enterGameItem - The new game enter item.
     */
    function setGameEnterItem(_enterGameItem: GameEnterResponse) {
      enterGameItem.value = _enterGameItem
    }

    /**
     * @action setSearchGameDialogShow - Sets the searchGameDialogShow state.
     * @param searchGameDialogShow - The new search game dialog show value.
     */
    function setSearchGameDialogShow(_searchGameDialogShow: boolean) {
      searchGameDialogShow.value = _searchGameDialogShow
    }

    /**
     * @action setSearchTextList - Adds a search text if not already in the array.
     * @param searchText - The search text to add.
     */
    function setSearchTextList(searchText: string) {
      const sameSearchText = searchTextList.value.filter((item) => item == searchText)
      if (sameSearchText.length == 0) {
        searchTextList.value.push(searchText)
      }
    }

    /**
     * @action removeSearchTextList - Removes a search text by index.
     * @param index - The index of the search text to remove.
     */
    function removeSearchTextList(index: number) {
      searchTextList.value.splice(index, 1)
    }

    /**
     * @action removeAllSearchTextList - Removes all search texts.
     */
    function removeAllSearchTextList() {
      searchTextList.value = []
    }

    /**
     * @action setGameFilterText - Sets the gameFilterText state.
     * @param gameFilterText - The new game filter text.
     */
    function setGameFilterText(_gameFilterText: string) {
      gameFilterText.value = _gameFilterText
    }

    /**
     * @action setOriginalGames - Sets the originalGames state.
     * @param originalGames - The new original games array.
     */
    function setOriginalGames(_originalGames: Array<Search>) {
      originalGames.value = _originalGames
    }

    /**
     * @action setMobileMenuShow - Sets the mobileMenuShow state.
     * @param mobileMenuShow - The new mobile menu show value.
     */
    function setMobileMenuShow(_mobileMenuShow: boolean) {
      mobileMenuShow.value = _mobileMenuShow
    }

    /**
     * @action setGameHistoryItem - Sets the gameHistoryItem state.
     * @param gameHistoryItem - The new game history item.
     */
    function setGameHistoryItem(_gameHistoryItem: GameHistoryResponse) {
      gameHistoryItem.value = _gameHistoryItem
    }

    /**
     * @action setUserSpinPage - Sets the userSpinPage state.
     * @param userSpinPage - The new user spin page data.
     */
    function setUserSpinPage(_userSpinPage: any) {
      userSpinPage.value = _userSpinPage
    }

    /**
     * @action setUserSpin - Sets the userSpin state.
     * @param userSpin - The new user spin data.
     */
    function setUserSpin(userSpin: any) {
      userSpin.value = userSpin
    }

    /**
     * @action setLanguage - Sets the language state.
     * @param lang - The new language.
     */
    function setLanguage(lang: string) {
      language.value = lang
    }

    /**
     * @action setFavoriteGameList - Sets the favoriteGameList state.
     * @param favoriteGameList - The new favoriteGameList.
     */
    function setFavoriteGameList(_favoriteGameList: Array<number | string>) {
      favoriteGameList.value = _favoriteGameList
    }

    /**
     * @action openDialog - Opens a dialog, sets the authModalType and authDialogVisible.
     * @param type - The type of the dialog to open.
     */
    function openDialog(type: dialogType) {
      const { setAuthModalType, setAuthDialogVisible } = useAuthStore()
      const { setOverlayScrimShow } = useAppBarStore()
      setAuthModalType(type)
      setAuthDialogVisible(true)
      setOverlayScrimShow(false)
    }

    /**
     * @action closeKill - Calls kill on betby.
     */
    function closeKill() {
      betby.value?.kill()
    }

    /**
     * @action setGameBigWinItem - Sets the gameBigWinItem state.
     * @param gameBigWinItem - The new game big win item.
     */
    function setGameBigWinItem(_gameBigWinItem: GameBigWinData) {
      gameBigWinItem.value = _gameBigWinItem
    }

    function inject(_gameBigWinItem: GameBigWinData) {
      if (injected) {
        return
      }

      injected = true

      // styleElement = document.createElement('style');
      // styleElement.textContent = styles;
      // document.head.appendChild(styleElement);

      const initialElement = document.createElement('meta')
      initialElement.name = 'betting-marker'
      initialElement.content = 'initial'
      document.head.appendChild(initialElement)

      const scriptElement = document.createElement('script')
      scriptElement.src = scriptSrc
      scriptElement.async = true
      document.body.appendChild(scriptElement)

      scriptElement.onload = () => {
        try {
          BTRenderer = new (window as any).BTRenderer().initialize(initializeParams)
        } catch {
          //   cleanup();
        }
      }
      scriptElement.onabort = () => {}
    }
    /**
     * @action getGameBetbyInit - Gets the betby game init, and sets the callbacks.
     */
    async function getGameBetbyInit() {
      if (!enterGameItem.value.reserve) {
        await dispatchGameEnter({ id: '9999', demo: false })
      }
      betby.value = new BTRenderer().initialize({
        token: enterGameItem.value.reserve || '',
        lang: language,
        target: document.getElementById('betby'),
        brand_id: '2331516940205559808',
        betSlipOffsetTop: 0,
        betslipZIndex: 999,
        themeName: 'default',
        onLogin: () => {
          openDialog('login')
        },
        onRegister: () => {
          openDialog('signup')
        },
        onTokenExpired: async () => {
          closeKill()
          await dispatchGameEnter({ id: '9999', demo: false })
          await getGameBetbyInit()
        },
        onSessionRefresh: async () => {
          closeKill()
          await getGameBetbyInit()
        },
      })
    }

    /**
     * @action dispatchGameCategories - Makes a network call to get categories.
     * @param sub_api - The sub api path.
     */
    async function dispatchGameCategories(sub_api: string) {
      setSuccess(false)
      try {
        const response = await restClient.game.getGameCategories()
        setSuccess(true)
        if (sub_api == '?type=developers') {
          // getGameDevelopers(response)
        } else {
          setGameCategories(response)
        }
      } catch (error: any) {
        setErrorMessage(handleException(error.code || 500))
      }
    }

    /**
     * @action dispatchGameSearch - Makes a network call to search for games.
     * @param sub_api - The sub api path.
     */
    async function dispatchGameSearch() {
      setSuccess(false)
      try {
        const api = useApiClient()
        const response = await restClient.game.searchGames()
        setSuccess(true)
        console.log(response.items)
        setGameSearchList({
          items: Array.isArray(response.items)
            ? response.items.map(
                (item: PrismaGame) =>
                  ({
                    // Map all required Game properties here, using defaults if missing
                    id: item.id,
                    name: item.name,
                    developer: item.gameProvider?.name.toLowerCase(),

                    // Add all required Game properties with sensible defaults
                    title: item.title ?? '',
                    category: item.category ?? '',
                    featured: item.featured ?? false,
                    // Add all other required properties from Game interface with defaults
                    // Example:
                    // propertyName: item.propertyName ?? defaultValue,
                    // Repeat for all 40+ properties as required by Game interface
                    // If you don't know the full list, import Game and use a type assertion as a workaround:
                  }) as Game
              )
            : [],
          total: response.total ? response.total : 0,
        })
      } catch (error: any) {
        setGameSearchList({ items: [], total: 0 })
        setErrorMessage(handleException(error.code || 500))
      }
      // const network: Network = Network.getInstance();
      // const next = (response: GetGameSearchResponse) => {
      //   if (response.code == 200) {
      //     setSuccess(true);
      //     setGameSearchList(response.data);
      //     console.log(response.data.list.length);
      //   } else {
      //     setGameSearchList({ list: [], total: 0 });
      //     setErrorMessage(handleException(response.code));
      //   }
      // };
      // await network.sendMsg(route, {}, next, 1, 4);
    }
    async function dispatchGetAllGames() {
      setSuccess(false)
      try {
        const api = useApiClient()
        const response = await restClient.game.getAllGames()
        setSuccess(true)
        // console.log(response.items)
        setGameSearchList({
          items: Array.isArray(response.items)
            ? response.items.map(
                (item: any) =>
                  ({
                    // Map all required Game properties here, using defaults if missing
                    id: item.id,
                    name: item.name,
                    developer: item.gameProvider?.name.toLowerCase(),
                    temperature:
                      Math.random() * 100 < 40 ? 'hot' : Math.random() * 100 < 20 ? 'cold' : 'none',
                    // Add all required Game properties with sensible defaults
                    title: item.title ?? '',
                    category: item.category ?? '',
                    featured: item.featured ?? false,
                    // Add all other required properties from Game interface with defaults
                    // Example:
                    // propertyName: item.propertyName ?? defaultValue,
                    // Repeat for all 40+ properties as required by Game interface
                    // If you don't know the full list, import Game and use a type assertion as a workaround:
                  }) as Game
              )
            : [],
          total: response.total ? response.total : 0,
        })
      } catch (error: any) {
        setGameSearchList({ items: [], total: 0 })
        setErrorMessage(handleException(error.code || 500))
      }
      // const network: Network = Network.getInstance();
      // const next = (response: GetGameSearchResponse) => {
      //   if (response.code == 200) {
      //     setSuccess(true);
      //     setGameSearchList(response.data);
      //     console.log(response.data.list.length);
      //   } else {
      //     setGameSearchList({ list: [], total: 0 });
      //     setErrorMessage(handleException(response.code));
      //   }
      // };
      // await network.sendMsg(route, {}, next, 1, 4);
    }

    /**
     * @action dispatchUserGame - Makes a network call to get user games.
     * @param data - The request data.
     */
    async function dispatchUserGame(data: GameUserBody) {
      setSuccess(false)
      try {
        const response = await restClient.game.getGameDetails({ id: data.id })
        setSuccess(true)
        setGameSearchList({
          items: Array.isArray(response) ? response : [],
          total: Array.isArray(response) ? response.length : 0,
        })
      } catch (error: any) {
        setGameSearchList({ items: [], total: 0 })
        setErrorMessage(handleException(error.code || 500))
      }
    }

    /**
     * @action dispatchFavoriteGame - Makes a network call to favorite games.
     * @param data - The request data.
     */
    async function dispatchFavoriteGame(data: any) {
      setSuccess(false)
      try {
        // TODO: Implement proper favorite game endpoint in apiClient
        console.warn('Favorite game endpoint not implemented in apiClient')
        setSuccess(true)
      } catch (error: any) {
        setErrorMessage(handleException(error.code || 500))
      }
    }

    /**
     * @action dispatchGameEnter - Makes a network call to enter game.
     * @param data - The request data.
     */
    async function dispatchGameEnter(data: GameEnterBody) {
      setSuccess(false)
      try {
        const gameData = await restClient.game.launchGame({
          id: data.id as string,
          demo: false,
        })
        const j = destr(gameData) as LaunchGameResponseDto
        const token = j.game_session_id as string
        // if (typeof j === Error) {
        //   throw new Error(error?.message || 'Failed to launch game')
        // }

        setSuccess(true)
        setErrorMessage('')
        setGameEnterItem({
          method: 'POST',
          parames: '',
          developer: '',
          reserve: token,
          weburl: '',
        })
      } catch (error: any) {
        setErrorMessage(handleException(error.code || 500))
      }
    }

    /**
     * @action dispatchGameHistory - Makes a network call to get game history.
     * @param data - The request data.
     */
    async function dispatchGameHistory(data: any) {
      setSuccess(false)
      try {
        const response = await restClient.game.getGameHistory() //('/game_history')
        setSuccess(true)
        setGameHistoryItem({
          total_pages: response.total || 0,
          record: Array.isArray(response) ? response : [],
        })
      } catch (error: any) {
        setErrorMessage(handleException(error.code || 500))
      }
    }

    /**
     * @action dispatchUserSpinPage - Makes a network call to get user spin page.
     * @param data - The request data.
     */
    async function dispatchUserSpinPage(data: any) {
      setSuccess(false)
      try {
        // TODO: Implement proper spin page endpoint in apiClient
        console.warn('Spin page endpoint not implemented in apiClient')
        setSuccess(true)
        setUserSpinPage({})
      } catch (error: any) {
        setErrorMessage(handleException(error.code || 500))
      }
    }

    /**
     * @action dispatchUserSpin - Makes a network call to get user spin.
     */
    async function dispatchUserSpin() {
      setSuccess(false)
      try {
        // TODO: Implement proper spin endpoint in apiClient
        console.warn('Spin endpoint not implemented in apiClient')
        setSuccess(true)
        setUserSpin({})
      } catch (error: any) {
        setErrorMessage(handleException(error.code || 500))
      }
    }

    /**
     * @action dispatchGameBigWin - Makes a network call to get game big win.
     */
    async function dispatchGameBigWin() {
      setSuccess(false)
      try {
        const bigwins = await restClient.game.getGameBigWins()
        setGameBigWinItem({
          high_rollers: Array.isArray(bigwins.high_rollers) ? bigwins.high_rollers : [],
          lucky_bets: Array.isArray(bigwins.lucky_bets) ? bigwins.lucky_bets : [],
        })
        setSuccess(true)
      } catch (error: any) {
        setErrorMessage(handleException(error.code || 500))
      }

      // const route: string = NETWORK_CONFIG.GAME_INFO.GAME_BIGWIN;
      // const network: Network = Network.getInstance();
      // const next = (response: GetGameBigWinResponse) => {
      //   if (response.code == 200) {
      //     setSuccess(true);
      //     setGameBigWinItem(response.data);
      //   } else {
      //     setErrorMessage(handleException(response.code));
      //   }
      // };
      // await network.sendMsg(route, {}, next, 1, 4);
    }

    /**
     * @action dispatchGameFavoriteList - Makes a network call to get game favorite list.
     */
    async function dispatchGameFavoriteList() {
      setSuccess(false)
      try {
        // TODO: Implement proper favorite list endpoint in apiClient
        console.warn('Favorite list endpoint not implemented in apiClient')
        setSuccess(true)
        setFavoriteGameList([])
      } catch (error: any) {
        setErrorMessage(handleException(error.code || 500))
      }
    }

    return {
      success,
      errMessage,
      gameCategories,
      gamedevelopers,
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
      isPlaying,
      setIsPlaying,
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
      dispatchGameSearch,
      dispatchUserGame,
      dispatchFavoriteGame,
      dispatchGameEnter,
      dispatchGameHistory,
      dispatchUserSpinPage,
      dispatchUserSpin,
      dispatchGameBigWin,
      dispatchGameFavoriteList,
      dispatchGetAllGames,
    }
  },
  {
    persist: true,
  }
)
