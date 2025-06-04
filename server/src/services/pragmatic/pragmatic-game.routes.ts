import z from 'zod'
const MD5 = require('md5.js')
import axios from 'axios'
import prisma from '../../../prisma'
import { protectedProcedure, publicProcedure } from '../../lib/orpc'
import * as generator from './engine/generator'

const ASSET_HOST = process.env.ASSET_HOST || 'http://onlinecasino0001.com:8989'
const GAME_HOST = process.env.GAME_HOST || 'http://pragmatic.kro.kr:8940'
const REPLAY_HOST = process.env.REPLAY_HOST || 'http://pragmatic.kro.kr:8940'
const REAL_GAME_HOST = process.env.REAL_GAME_HOST || 'http://pragmatic.kro.kr:8940'

const mini_lobby_games = require('./Json/mini_lobby_games')
const game243: string[] = []

// --- Zod Schemas for Input Validation ---
const GameRunSchema = z.object({
  gameSymbol: z.string().min(1),
  mgckey: z.string().min(1),
  lang: z.string().optional().default('ko'),
})

const GameDemoSchema = z.object({
  game: z.string().min(1),
  token: z.string().min(1),
})

const GameStatusChangeSchema = z.object({
  id: z.number().int().positive(),
  status: z.number().int().min(0).max(1),
})

const GameHistorySchema = z.object({
  mgckey: z.string().min(1),
  symbol: z.string().min(1),
  recordId: z.string().optional(),
})

const ReloadBalanceSchema = z.object({
  mgckey: z.string().min(1),
})

const ChildrenHistorySchema = z.object({
  token: z.string().min(1),
  symbol: z.string().min(1),
  id: z.string().min(1),
})

const DetailGameHistorySchema = z.object({
  mgckey: z.string().min(1),
  symbol: z.string().min(1),
  playSessionId: z
    .string()
    .min(1)
    .transform((val) => parseInt(val, 10)),
})

// Helper function to get main code for game symbols
const getMainCode = (gameSymbol: string): string => {
  const mainCode: Record<string, string[]> = {
    '7559f21d': [
      // Add game symbols list here if needed
    ],
    '56f51456': ['vs10runes', 'vs20fparty2'],
    '6c8ff85f': ['vs25wolfgold', 'vswayshive'],
  }

  for (const [code, symbols] of Object.entries(mainCode)) {
    if (symbols.includes(gameSymbol)) {
      return code
    }
  }

  return '7559f21d'
}

// Helper function to render maintenance page
const renderMaintenance = () => {
  return `
    <!DOCTYPE html>
    <html>
      <head>
        <title>Maintenance</title>
      </head>
      <body>
        <h1>Game is under maintenance</h1>
        <p>Please try again later</p>
      </body>
    </html>
  `
}

export const pragmaticRouter = {
  // Health check endpoint
  isAlive: publicProcedure.handler(() => {
    return { status: 'success' }
  }),

  // Mini lobby games endpoint
  miniLobbyGames: publicProcedure.handler(() => {
    return mini_lobby_games
  }),

  // Game run endpoint
  gameRun: publicProcedure.input(GameRunSchema).handler(async ({ input }) => {
    const { gameSymbol, mgckey, lang } = input

    const game = await prisma.game.findFirst({
      where: { gameCode: gameSymbol },
    })

    if (!game) {
      return renderMaintenance()
    }

    return `
        <!DOCTYPE html>
        <html>
          <head>
            <title>${gameSymbol}</title>
          </head>
          <body>
            <div id="app"></div>
            <script>
              window.gameConfig = {
                title: '${gameSymbol}',
                gameName: '${gameSymbol}',
                resourceName: '${ASSET_HOST}',
                serviceApi: '${GAME_HOST}/gs2c/v3/gameService',
                gameHost: '${GAME_HOST}',
                replayHost: '${REPLAY_HOST}',
                token: '${mgckey}',
                lang: '${lang}',
                currency: 'KRW'
              };
            </script>
            <script src="${ASSET_HOST}/gs2c/index.js"></script>
          </body>
        </html>
      `
  }),

  // Mini lobby game run endpoint
  miniLobbyGameRun: publicProcedure.input(GameRunSchema).handler(async ({ input }) => {
    const { gameSymbol, mgckey } = input

    const user = await prisma.user.findFirst({ where: { token: mgckey } })
    if (!user) {
      return renderMaintenance()
    }

    // Handle justslot specific logic
    if (user.login?.includes('justslot')) {
      const [agentCode, userCode] = user.login.split('#JS#')
      const jsonBody = {
        method: 'game_launch',
        agent_code: agentCode,
        agent_token: 'token',
        user_code: userCode,
        provider_code: 'PRAGMATIC_OLD',
        game_code: gameSymbol,
        rtp: user.targetRtp,
      }

      try {
        const ret = await axios.post('http://justslot.kro.kr:2422/api', jsonBody)
        if (ret.data.status === 1) {
          return { redirect: ret.data.launch_url }
        }
        return renderMaintenance()
      } catch (error) {
        console.error(error)
        return renderMaintenance()
      }
    } else {
      const game = await prisma.game.findFirst({
        where: { gameCode: gameSymbol },
      })
      if (game?.status === 1) {
        // Return game run response
        return `
            <!DOCTYPE html>
            <html>
              <head>
                <title>${gameSymbol}</title>
              </head>
              <body>
                <div id="app"></div>
                <script>
                  window.gameConfig = {
                    title: '${gameSymbol}',
                    gameName: '${gameSymbol}',
                    resourceName: '${ASSET_HOST}',
                    serviceApi: '${GAME_HOST}/gs2c/v3/gameService',
                    gameHost: '${GAME_HOST}',
                    replayHost: '${REPLAY_HOST}',
                    token: '${mgckey}',
                    lang: '${input.lang}',
                    currency: 'KRW'
                  };
                </script>
                <script src="${ASSET_HOST}/gs2c/index.js"></script>
              </body>
            </html>
          `
      }
      return renderMaintenance()
    }
  }),

  // Game demo endpoint
  gameDemo: publicProcedure.input(GameDemoSchema).handler(async ({ input }) => {
    const { game: gameCode, token } = input

    const game = await prisma.game.findFirst({
      where: { gameCode },
    })

    if (!game) {
      return renderMaintenance()
    }

    return `
        <!DOCTYPE html>
        <html>
          <head>
            <title>Demo - ${gameCode}</title>
          </head>
          <body>
            <div id="app"></div>
            <script>
              window.gameConfig = {
                title: 'Demo - ${gameCode}',
                gameName: '${gameCode}',
                resourceName: '${ASSET_HOST}',
                serviceApi: '${GAME_HOST}/gs2c/v3/gameService',
                gameHost: '${REAL_GAME_HOST}',
                replayHost: '${REPLAY_HOST}',
                token: '${token}',
                lang: 'ko',
                currency: 'KRW',
                demo: true
              };
            </script>
            <script src="${ASSET_HOST}/gs2c/index.js"></script>
          </body>
        </html>
      `
  }),

  // Games with pattern endpoint
  gamesWithPattern: publicProcedure
    .input(
      z.object({
        draw: z.number().optional().default(1),
      })
    )
    .handler(async ({ input }) => {
      const games = await prisma.game.findMany()
      const gameList = games.map((item) => ({
        id: item.id,
        banner: item.banner,
        status: item.status,
        gameCode: item.gameCode,
        gameName: item.gameName,
        enName: item.enName,
        memo: item.memo,
      }))

      return {
        draw: input.draw,
        recordsTotal: gameList.length,
        recordsFiltered: gameList.length,
        data: gameList,
      }
    }),

  // Game maintenance endpoint
  gameMaintenance: publicProcedure.handler(() => {
    return renderMaintenance()
  }),

  // Change game status endpoint
  changeGameStatus: protectedProcedure.input(GameStatusChangeSchema).handler(async ({ input }) => {
    const { id, status } = input
    const game = await prisma.game.findFirst({ where: { id } })

    if (!game) {
      return { status: false, msg: 'Game not found' }
    }

    const retObj = await prisma.game.update({
      where: { id },
      data: { status: Number(status) },
    })
    return { status: !!retObj, msg: !!retObj ? 'Success' : 'Failed' }
  }),

  // Game history endpoint
  gameHistory: publicProcedure.input(GameHistorySchema).handler(async ({ input }) => {
    const { mgckey, symbol: gameSymbol, recordId } = input

    const player = await prisma.player.findFirst({ where: { token: mgckey } })
    if (!player) {
      return 'Player not found'
    }

    const mainCode = getMainCode(gameSymbol)

    if (game243.includes(gameSymbol)) {
      await prisma.history.findMany({
        where: {
          agentCode: player.agentCode || '',
          userCode: player.userCode || '',
          gameCode: gameSymbol,
        },
        take: 100,
        orderBy: {
          createdAt: 'desc',
        },
      })

      return `
          <!DOCTYPE html>
          <html>
            <head>
              <title>Game History</title>
            </head>
            <body>
              <h1>Game History (243)</h1>
              <p>Asset Host: ${ASSET_HOST}</p>
              <p>Token: ${mgckey}</p>
              <p>Game Symbol: ${gameSymbol}</p>
              <p>Main Code: ${mainCode}</p>
            </body>
          </html>
        `
    } else {
      return `
          <!DOCTYPE html>
          <html>
            <head>
              <title>Game History</title>
            </head>
            <body>
              <h1>Game History</h1>
              <p>Asset Host: ${ASSET_HOST}</p>
              <p>Token: ${mgckey}</p>
              <p>Record ID: ${recordId}</p>
              <p>Main Code: ${mainCode}</p>
            </body>
          </html>
        `
    }
  }),

  // General game history endpoint
  generalGameHistory: publicProcedure.handler(() => {
    return {
      language: 'en',
      jurisdiction: '99',
      jurisdictionRequirements: [],
      brandRequirements: [],
    }
  }),

  // Detail game history endpoint
  detailGameHistory: publicProcedure.input(DetailGameHistorySchema).handler(async ({ input }) => {
    const { mgckey, symbol: gameSymbol, playSessionId: recordId } = input

    const player = await prisma.player.findFirst({ where: { token: mgckey } })
    if (!player) {
      return 'Player not found'
    }

    const histData = await prisma.history.findFirst({
      where: {
        id: recordId,
        agentCode: player.agentCode || '',
        userCode: player.userCode || '',
        gameCode: gameSymbol,
      },
    })

    if (!histData) {
      return 'History not found'
    }

    // Parse the data for potential future use
    JSON.parse(histData.data)
    return `
        <!DOCTYPE html>
        <html>
          <head>
            <title>Game History Details</title>
          </head>
          <body>
            <h1>Game History Details</h1>
            <p>Asset Host: ${ASSET_HOST}</p>
            <p>Token: ${mgckey}</p>
            <p>Game Symbol: ${gameSymbol}</p>
            <p>Record ID: ${recordId}</p>
          </body>
        </html>
      `
  }),

  // Last items history endpoint
  lastItemsHistory: publicProcedure
    .input(
      z.object({
        token: z.string().min(1),
        symbol: z.string().min(1),
        recordId: z.string().optional(),
      })
    )
    .handler(async ({ input }) => {
      const { token, symbol: gameSymbol } = input

      const player = await prisma.player.findFirst({ where: { token } })
      if (!player) {
        return []
      }

      const histData = await prisma.history.findMany({
        where: {
          agentCode: player.agentCode || '',
          userCode: player.userCode || '',
          gameCode: gameSymbol,
        },
        take: 100,
        orderBy: {
          createdAt: 'desc',
        },
      })

      const resData = histData.map((item) => ({
        roundId: item.roundID,
        dateTime: item.createdAt,
        bet: item.bet,
        win: item.win,
        balance: item.balance,
        roundDetails: null,
        currency: 'KRW',
        currencySymbol: '₩',
        hash: new MD5().update(`${item.id}-${item.createdAt}`).digest('hex'),
      }))

      return resData
    }),

  // Children history endpoint
  childrenHistory: publicProcedure.input(ChildrenHistorySchema).handler(async ({ input }) => {
    const { token, symbol: gameSymbol, id } = input

    const player = await prisma.player.findFirst({ where: { token } })
    if (!player) {
      return []
    }

    const histData = await prisma.history.findFirst({
      where: {
        roundID: id,
        agentCode: player.agentCode || '',
        userCode: player.userCode || '',
        gameCode: gameSymbol,
      },
    })

    if (!histData) {
      return []
    }

    const childData = JSON.parse(histData.data)
    delete childData.request.UID
    delete childData.request.mgckey
    delete childData.request.l

    childData.roundId = histData.id
    childData.currency = 'KRW'
    childData.currencySymbol = '₩'
    childData.configHash = new MD5().update(`${histData.id}-${histData.createdAt}`).digest('hex')

    return [childData]
  }),

  // Reload balance endpoint
  reloadBalance: publicProcedure.input(ReloadBalanceSchema).handler(async ({ input }) => {
    const { mgckey } = input

    const user = await prisma.user.findFirst({ where: { token: mgckey } })
    if (!user) {
      return { status: 'error', message: 'User not found' }
    }

    return {
      status: 'success',
      balance: user.balance,
      bonusBalance: 0, // Default bonus balance since it's not in the schema
    }
  }),

  // Game list endpoint
  gameList: publicProcedure.handler(() => {
    return { message: 'Game list endpoint is under construction' }
  }),

  // Pattern generation endpoint
  patternGen: publicProcedure
    .input(
      z.object({
        gameCode: z.string().min(1),
        patCount: z.number().optional(),
      })
    )
    .handler(async ({ input }) => {
      // Create a mock request/response object for the legacy function
      const mockReq = {
        body: input,
        app: {
          db: { User: prisma.user, Player: prisma.player },
          redis_client: { set: async () => {} },
        },
      }
      const mockRes = {
        json: (data: any) => data,
      }

      try {
        await generator.OnRequest_Generate(mockReq, mockRes)
        return { status: 'success', message: 'Pattern generation completed' }
      } catch (error) {
        return { status: 'error', message: 'Pattern generation failed' }
      }
    }),

  // Game service endpoint
  gameService: publicProcedure
    .input(
      z.object({
        action: z.string().min(1),
        symbol: z.string().optional(),
        mgckey: z.string().optional(),
      })
    )
    .handler(async ({ input }) => {
      // For now, return a placeholder response since the legacy machine function
      // requires complex setup with database models and response objects
      // This should be properly implemented when integrating with the game engine
      return {
        status: 'success',
        message: 'Game service endpoint - implementation pending',
        action: input.action,
        symbol: input.symbol,
        mgckey: input.mgckey,
      }
    }),
}

export default pragmaticRouter
