import { Hono } from 'hono'
const MD5 = require('md5.js')
import axios from 'axios'
import { Context } from 'hono'
import prisma from '../../../prisma'
// const prisma = new PrismaClient()
import * as machine from './engine/machine'
// import * as replayer from './replayer'
// import * as promo from './promo'
import * as generator from './engine/generator'

const ASSET_HOST = process.env.ASSET_HOST || 'http://onlinecasino0001.com:8989'
const GAME_HOST = process.env.GAME_HOST || 'http://pragmatic.kro.kr:8940'
const REPLAY_HOST = process.env.REPLAY_HOST || 'http://pragmatic.kro.kr:8940'
const REAL_GAME_HOST = process.env.REAL_GAME_HOST || 'http://pragmatic.kro.kr:8940'

const mini_lobby_games = require('./Json/mini_lobby_games')
const game243: string[] = []

export class GameAPI {
  public app: Hono

  constructor(app) {
    this.app = app
    this.setupRoutes()
  }

  private setupRoutes() {
    this.app.get('/game_start.do', this.gameRun.bind(this))
    this.app.get('/game_demo.do', this.gameDemo.bind(this))
    this.app.get('/game_list.do', this.gameList.bind(this))
    this.app.get('/game_maintenance.do', this.gameMaintenance.bind(this))
    this.app.post('/games_with_pattern.do', this.gamesWithPattern.bind(this))
    this.app.post('/game_change_status', this.changeGameStatus.bind(this))
    this.app.post('/pattern_gen.do', generator.OnRequest_Generate.bind(generator))
    this.app.post('/gs2c/v3/gameService', machine.OnRequest_GameService.bind(machine))
    this.app.post('/gs2c/gameService', machine.OnRequest_GameService.bind(machine))
    this.app.get('/isAlive', (c: Context) => c.json({ status: 'success' }))
    this.app.get('/gs2c/minilobby/games', (c: Context) => c.json(mini_lobby_games))
    this.app.get('/gs2c/minilobby/start', this.miniLobbyGameRun.bind(this))
    this.app.get('/gs2c/reloadBalance.do', this.reloadBalance.bind(this))
    this.app.get('/gs2c/lastGameHistory.do', this.gameHistory.bind(this))
    this.app.get('/gs2c/gameHistoryDetailsPage.do', this.detailGameHistory.bind(this))
    this.app.get('/gs2c/generalGameHistory.do', this.generalGameHistory.bind(this))
    this.app.get('/gs2c/childrenHistory.do', this.childrenHistory.bind(this))
    this.app.post('/gs2c/stats.do', this.childrenHistory.bind(this))
  }

  private async gameRun(c: Context) {
    const gameCode = c.req.query('gameSymbol')
    const token = c.req.query('mgckey')

    if (!gameCode || !token) {
      return this.renderMaintenance(c)
    }

    const game = await prisma.game.findFirst({ where: { name: gameCode } })
    if (!game) {
      return this.renderMaintenance(c)
    }

    return `
      <!DOCTYPE html>
      <html>
        <head>
          <title>${gameCode}</title>
        </head>
        <body>
          <div id="app"></div>
          <script>
            window.gameConfig = {
              title: '${gameCode}',
              gameName: '${gameCode}',
              resourceName: '${ASSET_HOST}',
              serviceApi: '${GAME_HOST}/gs2c/v3/gameService',
              gameHost: '${GAME_HOST}',
              replayHost: '${REPLAY_HOST}',
              token: '${token}',
              lang: '${c.req.query('lang') || 'ko'}',
              currency: 'KRW'
            };
          </script>
          <script src="${ASSET_HOST}/gs2c/index.js"></script>
        </body>
      </html>
    `
  }

  private async miniLobbyGameRun(c: Context) {
    const gameCode = c.req.query('gameSymbol')
    const token = c.req.query('mgckey')

    if (!gameCode || !token) {
      return this.renderMaintenance(c)
    }

    const user = await prisma.user.findFirst({ where: { token } })
    if (!user) {
      return this.renderMaintenance(c)
    }

    if (user.agentCode === 'justslot') {
      const [agentCode, userCode] = user.userCode.split('#JS#')
      const jsonBody = {
        method: 'game_launch',
        agent_code: agentCode,
        agent_token: 'token',
        user_code: userCode,
        provider_code: 'PRAGMATIC_OLD',
        game_code: gameCode,
        rtp: user.targetRtp,
      }

      try {
        const ret = await axios.post('http://justslot.kro.kr:2422/api', jsonBody)
        if (ret.data.status === 1) {
          return c.redirect(ret.data.launch_url)
        }
        return this.renderMaintenance(c)
      } catch (error) {
        console.error(error)
        return this.renderMaintenance(c)
      }
    } else {
      const game = await prisma.game.findFirst({ where: { g_name: gameCode } })
      if (game?.status === 1) {
        return this.gameRun(c)
      }
      return this.renderMaintenance(c)
    }
  }

  private async gameDemo(c: Context) {
    const gameCode = c.req.query('game')
    const token = c.req.query('token')

    if (!gameCode || !token) {
      return this.renderMaintenance(c)
    }

    const game = await prisma.game.findFirst({ where: { g_name: gameCode } })
    if (!game) {
      return this.renderMaintenance(c)
    }

    return `
      <!DOCTYPE html>
      <html>
        <head>
          <title>${gameCode}</title>
        </head>
        <body>
          <div id="app"></div>
          <script>
            window.gameConfig = {
              title: '${gameCode}',
              gameName: '${gameCode}',
              resourceName: '${ASSET_HOST}',
              serviceApi: '${GAME_HOST}/gs2c/v3/gameService',
              gameHost: '${REAL_GAME_HOST}',
              replayHost: '${REPLAY_HOST}',
              token: '${token}',
              lang: 'ko',
              currency: 'KRW'
            };
          </script>
          <script src="${ASSET_HOST}/gs2c/index.js"></script>
        </body>
      </html>
    `
  }

  private async gamesWithPattern(c: Context) {
    const games = await prisma.game.findMany({
      where: { gameProviderId: 'cmbbeokyv004tmdzr1hqhjryn' },
    })
    const gameList = games.map((item) => ({
      id: item.id,
      bannerUrl: item.bannerUrl,
      status: item.status,
      name: item.name,
      title: item.title,
      // enName: item.enName,
      // memo: item.memo,
    }))

    return c.json({
      draw: Number(c.req.query('draw')),
      recordsTotal: gameList.length,
      recordsFiltered: gameList.length,
      data: gameList,
    })
  }

  private gameMaintenance(c: Context) {
    return c.render(`game/maintenancing.ejs`)
  }

  private async changeGameStatus(c: Context) {
    const { id, status } = await c.req.json()
    const game = await prisma.game.findFirst({ where: { id } })

    if (!game) {
      return c.json({ status: false, msg: 'Game not found' })
    }

    const retObj = await prisma.game.update({
      where: { id },
      data: { status: Number(status) },
    })
    return c.json({ status: !!retObj, msg: !!retObj ? 'Success' : 'Failed' })
  }

  private async gameHistory(c: Context) {
    const token = c.req.query('mgckey')
    const gameSymbol = c.req.query('symbol')
    const recordId = c.req.query('recordId')

    if (!token || !gameSymbol) {
      return c.text('Invalid parameters')
    }

    const player = await prisma.player.findFirst({ where: { token } })
    if (!player) {
      return c.text('Player not found')
    }

    const mainCode = this.getMainCode(gameSymbol)

    if (game243.includes(gameSymbol)) {
      const histData = await prisma.history.findMany({
        where: {
          agentCode: player.agentCode,
          userCode: player.userCode,
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
            <p>Token: ${token}</p>
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
            <p>Token: ${token}</p>
            <p>Record ID: ${recordId}</p>
            <p>Main Code: ${mainCode}</p>
          </body>
        </html>
      `
    }
  }

  private generalGameHistory(c: Context) {
    return c.json({
      language: 'en',
      jurisdiction: '99',
      jurisdictionRequirements: [],
      brandRequirements: [],
    })
  }

  private async detailGameHistory(c: Context) {
    const token = c.req.query('mgckey')
    const gameSymbol = c.req.query('symbol')
    const recordId = c.req.query('playSessionId')

    if (!token || !gameSymbol || !recordId) {
      return c.text('Invalid parameters')
    }

    const player = await prisma.player.findFirst({ where: { token } })
    if (!player) {
      return c.text('Player not found')
    }

    const histData = await prisma.history.findFirst({
      where: {
        id: recordId,
        agentCode: player.agentCode,
        userCode: player.userCode,
        gameCode: gameSymbol,
      },
    })

    if (!histData) {
      return c.text('History not found')
    }

    const data = JSON.parse(histData.data)
    return `
      <!DOCTYPE html>
      <html>
        <head>
          <title>Game History Details</title>
        </head>
        <body>
          <h1>Game History Details</h1>
          <p>Asset Host: ${ASSET_HOST}</p>
          <p>Token: ${token}</p>
          <p>Game Symbol: ${gameSymbol}</p>
          <p>Record ID: ${recordId}</p>
        </body>
      </html>
    `
  }

  private async lastItemsHistory(c: Context) {
    const token = c.req.query('token')
    const gameSymbol = c.req.query('symbol')
    const recordId = c.req.query('recordId')

    if (!token || !gameSymbol) {
      return c.json([])
    }

    const player = await prisma.player.findFirst({ where: { token } })
    if (!player) {
      return c.json([])
    }

    const histData = await prisma.history.findMany({
      where: {
        agentCode: player.agentCode,
        userCode: player.userCode,
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

    return c.json(resData)
  }

  private async childrenHistory(c: Context) {
    const token = c.req.query('token')
    const gameSymbol = c.req.query('symbol')
    const id = c.req.query('id')

    if (!token || !gameSymbol || !id) {
      return c.json([])
    }

    const player = await prisma.player.findFirst({ where: { token } })
    if (!player) {
      return c.json([])
    }

    const histData = await prisma.history.findFirst({
      where: {
        roundID: id,
        agentCode: player.agentCode,
        userCode: player.userCode,
        gameCode: gameSymbol,
      },
    })

    if (!histData) {
      return c.json([])
    }

    const childData = JSON.parse(histData.data)
    delete childData.request.UID
    delete childData.request.mgckey
    delete childData.request.l

    childData.roundId = histData.id
    childData.currency = 'KRW'
    childData.currencySymbol = '₩'
    childData.configHash = new MD5().update(`${histData.id}-${histData.createdAt}`).digest('hex')

    return c.json([childData])
  }

  private async reloadBalance(c: Context) {
    const token = c.req.query('mgckey')
    if (!token) {
      return c.json({ status: 'error', message: 'Missing token' })
    }

    const user = await prisma.user.findFirst({ where: { token } })
    if (!user) {
      return c.json({ status: 'error', message: 'User not found' })
    }

    return c.json({
      status: 'success',
      balance: user.balance,
      bonusBalance: user.bonusBalance,
    })
  }

  private getMainCode(gameSymbol: string): string {
    const mainCode: Record<string, string[]> = {
      '7559f21d': [
        // ... game symbols list from original
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

  private async gameList(c: Context) {
    return c.json({ message: 'Game list endpoint is under construction' })
  }

  private renderMaintenance(c: Context) {
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
}

// export default new GameAPI().app
