export class NetentGame {
  private internal_token: string
  private url: string
  private exploded_url: string[]
  select_session: any

  constructor(request: any) {
    this.internal_token = request.internal_token
    this.select_session = this.get_internal_session(this.internal_token)['data']
    this.url = request.url
    this.exploded_url = this.url.split(';jsession')
  }

  async http_get(_callback_url: string) {
    const resp = await fetch(
      `https://netentff-game.casinomodule.com/servlet/CasinoGameServlet;jsession${this.exploded_url[1]}`
    )
    return resp.text()
  }
  async bridged(request: any): string {
    if (this.exploded_url[1]) {
      const callback_url = `https://netentff-game.casinomodule.com/servlet/CasinoGameServlet;jsession${this.exploded_url[1]}`
      let http = await this.http_get(callback_url)

      if (request.action === 'init') {
        const get_balance = this.get_balance(this.internal_token)
        const credit_current = this.in_between('&credit=', '&', http)

        if (credit_current) {
          // Cache.set(`${this.internal_token}:netentHiddenBalance`, parseInt(data_origin.credit))
          http = http.replace(`credit=${credit_current}`, `credit=${get_balance}`)
        }

        http = http.replace('playforfun=true', 'playforfun=false')
        http = http.replace('g4mode=false', 'g4mode=true')
        return http
      }

      const data_origin = this.parse_query(http)
      data_origin.playforfun = false
      data_origin.g4mode = true

      if (data_origin.credit) {
        const bridge_balance = parseInt(Cache.get(`${this.internal_token}:netentHiddenBalance`))

        if (!bridge_balance) {
          Cache.set(`${this.internal_token}:netentHiddenBalance`, parseInt(data_origin.credit))
        }

        const current_balance = parseInt(data_origin.credit)

        if (bridge_balance !== current_balance) {
          let winAmount = 0
          let betAmount = 0

          if (bridge_balance > current_balance) {
            betAmount = bridge_balance - current_balance
          } else {
            winAmount = current_balance - bridge_balance
          }

          Cache.set(`${this.internal_token}:netentHiddenBalance`, current_balance)
          const process_and_get_balance = this.process_game(
            this.internal_token,
            betAmount,
            winAmount,
            data_origin
          )
          data_origin.credit = process_and_get_balance
        } else {
          Cache.set(`${this.internal_token}:netentHiddenBalance`, current_balance)
          const get_balance = this.get_balance(this.internal_token)
          data_origin.credit = get_balance
        }
      }

      const build = this.build_query(data_origin)
      const final = build.replace('_', '.')
      return final
    } else {
      const callback_url = 'https://netentff-game.casinomodule.com/mobile-game-launcher/version'
      return this.curl_request(callback_url, request)
    }
  }
  process_game(_internal_token: string, _betAmount: number, _winAmount: number, _data_origin: any) {
    throw new Error('Method not implemented.')
  }

  game_event(request: any): string {
    return this.bridged(request)
  }

  curl_request(url: string, request: any): string {
    const resp = ProxyHelperFacade.CreateProxy(request).toUrl(url)
    return resp
  }

  // Mocked methods for TypeScript conversion
  private get_internal_session(_token: string): any {
    // Implementation here
    return {}
  }

  private get_balance(_token: string): number {
    // Implementation here
    return 0
  }

  private parse_query(_http: string): any {
    // Implementation here
    return {}
  }

  private in_between(_start: string, _end: string, _str: string): string {
    // Implementation here
    return ''
  }

  private build_query(_data_origin: any): string {
    // Implementation here
    return ''
  }
}
