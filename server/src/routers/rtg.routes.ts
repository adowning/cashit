import { Hono } from 'hono'
import axios from 'axios'
import { Context } from 'hono'
import prisma from '../../prisma'
import { rtgSettings, rtgSpin } from '@/services/rtg.service'
import { Session } from 'better-auth'

export class RtgApi {
  public app: Hono

  constructor(app) {
    this.app = app
    this.setupRoutes()
  }
  private setupRoutes() {
    this.app.post(
      '/rtg/games/rtg/platform/:token/:gameName/game/settings',
      this.rtgSettings.bind(this)
    )
    this.app.post('/rtg/games/rtg/platform/:id/:token/game/spin', this.rtgSpin.bind(this))
  }

  private async rtgSettings(c: Context) {
    // const session = c.get('session') as Session
    // console.log(c.env.context.session.user)
    const gameName = c.req.param('gameName')
    // console.log('gameName', gameName)
    if (!gameName) {
      return c.json({ success: false, error: 'GAME_NAME_MISSING' }, 400)
    }
    return rtgSettings(c, c.env.context.user, gameName)
  }

  private async rtgSpin(c: Context) {
    return rtgSpin(c, c.env.context.user, c.env.context.session, c.req.param('token'))
  }
}
