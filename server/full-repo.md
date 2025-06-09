This file is a merged representation of a subset of the codebase, containing specifically included files and files not matching ignore patterns, combined into a single document by Repomix.
The content has been processed where comments have been removed, empty lines have been removed, content has been compressed (code blocks are separated by ⋮---- delimiter).

# File Summary

## Purpose
This file contains a packed representation of the entire repository's contents.
It is designed to be easily consumable by AI systems for analysis, code review,
or other automated processes.

## File Format
The content is organized as follows:
1. This summary section
2. Repository information
3. Directory structure
4. Repository files (if enabled)
5. Multiple file entries, each consisting of:
  a. A header with the file path (## File: path/to/file)
  b. The full contents of the file in a code block

## Usage Guidelines
- This file should be treated as read-only. Any changes should be made to the
  original repository files, not this packed version.
- When processing this file, use the file path to distinguish
  between different files in the repository.
- Be aware that this file may contain sensitive information. Handle it with
  the same level of security as you would the original repository.
- Pay special attention to the Repository Description. These contain important context and guidelines specific to this project.

## Notes
- Some files may have been excluded based on .gitignore rules and Repomix's configuration
- Binary files are not included in this packed representation. Please refer to the Repository Structure section for a complete list of file paths, including binary files
- Only files matching these patterns are included: **/*.ts, **/*.js, **/*.vue, **/*.json, **/*.md, **/*.sql, **/*.prisma, **/*.css, **/*.html, **/*.config.*, **/package.json, **/tsconfig.json, **/README.md, **/*.sh
- Files matching these patterns are excluded: **/node_modules/**, **/dist/**, **/build/**, **/.next/**, **/.nuxt/**, **/coverage/**, **/.cache/**, **/tmp/**, **/temp/**, **/logs/**, **/*.log, **/bun.lock, **/package-lock.json, **/yarn.lock, **/.DS_Store, **/Thumbs.db, **/*.min.js, **/*.min.css, **/public/games/**, **/public/images/**, **/public/nolimit/**, **/client/public/images/**, **/client/public/games/**, **/*.png, **/*.jpg, **/*.jpeg, **/*.gif, **/*.webp, **/*.avif, **/*.svg, **/*.ico, **/*.woff, **/*.woff2, **/*.ttf, **/*.eot, **/*.otf, **/server/public/**, **/server/performance-logs/**, **/server/prisma/generated/**, **/server/prisma/migrations/**, **/client/src/assets/anim/**, **/client/src/assets/bigwin/**, **/client/src/assets/vip/**, **/*.mjs, **/.timestamp-*, **/repomix-output.*, **/*.bridge.js, **/nolimit_loader_template.html, **/rtg_loader_template.html, **/docker/**, **/*.so.node, *.json, ./public, performance-logs, dist, cashapp, src/generated
- Files matching patterns in .gitignore are excluded
- Files matching default ignore patterns are excluded
- Code comments have been removed from supported file types
- Empty lines have been removed from all files
- Content has been compressed - code blocks are separated by ⋮---- delimiter
- Files are sorted by Git change count (files with more changes are at the bottom)

# User Provided Header
# Full Repository Analysis

This is a comprehensive analysis of the CashIt gaming platform repository.


# Directory Structure
```
config/
  json/
    rtg-settings.result.json
    rtg-spin-lose.result.json
  leveling.config.ts
  prisma.config.ts
handlers/
  chat.handler.ts
  heartbeat.handler.ts
  index.ts
  kagaming-proxy.handler.ts
  nolimit-proxy.handler.ts
  php-slots.handler.ts
  tournament.handler.ts
jobs/
  cashapp-watcher.job.ts
  jackpot.jobs.ts
lib/
  auth.ts
  context.ts
  events.ts
  orpc.ts
prisma/
  index.ts
routers/
  game.router.ts
  index.ts
  jackpot.router.ts
  netent.routes.ts
  netgame.routes.ts
  performance.routes.ts
  php.routes.ts
  rtg.routes.ts
  socket.router.ts
  tournament.router.ts
  transaction.ts
  user.router.ts
  vip.router.ts
  websocket-monitor.router.ts
services/
  dbupdates/
    config.ts
    logger.ts
    table.ts
    types.ts
    version.ts
  cashapp-payment-processing.service.ts
  cashapp.integration.ts
  game-spin.service.ts
  jackpot-async.service.ts
  jackpot.service.ts
  performance-monitor.service.ts
  realtime.service.ts
  redis.service.ts
  rtg-jackpot.integration.ts
  rtg-proxy.service.ts
  tournament.service.ts
  transaction.service.ts
  update.service.ts
  websocket-monitor.service.ts
  xp.service.ts
types/
  types/
    achievement.ts
    affiliate-invite.ts
    animation.ts
    appBar.ts
    auth.interface.ts
    auth.socket-interface.ts
    banner.ts
    bonus.ts
    chat.ts
    deposit.ts
    event.ts
    game.ts
    index.ts
    invite.ts
    jackpot.ts
    mail.ts
    prisma.ts
    promo.ts
    reward.ts
    rgs-proxy.error.ts
    routes.ts
    signin.ts
    signup.ts
    socket.ts
    tournament.ts
    transaction.ts
    user.ts
    vip.ts
    withdraw.ts
  index.ts
  schema.ts
  utils.ts
utils/
  chat.ts
  debounce.ts
  env.ts
  formatters.ts
  index.ts
  proxy.ts
  ws.ts
  xpCalculations.ts
🎉 You've achieved something pretty spec.md
server.ts
```

# Files

## File: config/json/rtg-settings.result.json
```json
{
  "success": true,
  "result": {
    "user": {
      "balance": {
        "cash": "100.00",
        "freeBets": "0.00",
        "sessionCash": "0.00",
        "sessionFreeBets": "0.00",
        "bonus": "0.00"
      },
      "notifications": [],
      "messages": [],
      "bonuses": [],
      "tournaments": [],
      "vouchers": [],
      "userId": 7427503,
      "country": "US",
      "casino": "NONE",
      "vertical": "Default",
      "currency": {
        "code": "GBP",
        "symbol": "£"
      },
      "token": "db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a",
      "sessionId": "0",
      "sessionNetPosition": "0.00",
      "aamsParticipationId": null,
      "aamsSessionId": null,
      "depositedAmount": "0.00",
      "maxDeposit": "0.00",
      "canGamble": false,
      "lastWin": "0.00",
      "prevRounds": [],
      "limits": {
        "maxGambleStake": "10000.00",
        "maxTotalStake": {
          "total": "20.00"
        },
        "minTotalStake": {
          "total": "0.20"
        },
        "spinDuration": null
      },
      "stakes": {
        "defaultIndex": 5,
        "lastIndex": 5,
        "types": [
          "0.2",
          "0.4",
          "0.6",
          "0.8",
          "1",
          "2",
          "4",
          "6",
          "8",
          "10",
          "20"
        ]
      },
      "autoplay": {
        "type": "modal",
        "options": {
          "spins": {
            "values": ["10", "20", "30", "50", "100"],
            "default": 10
          },
          "stopOnFeature": {
            "enabled": true
          },
          "stopOnLossLimits": {
            "mandatory": true,
            "enabled": true,
            "values": [
              "10",
              "20",
              "30",
              "50",
              "100",
              "200",
              "500",
              "1000",
              "5000",
              "10000"
            ],
            "default": 0
          },
          "stopOnWin": {
            "enabled": true,
            "values": [
              "10",
              "20",
              "30",
              "50",
              "100",
              "200",
              "500",
              "1000",
              "5000",
              "10000",
              "50000",
              "100000"
            ]
          },
          "hasRestart": false
        }
      },
      "serverTime": "2025-02-20 14:42:59",
      "additional": null
    },
    "game": {
      "cols": 5,
      "rows": 4,
      "offset": 3,
      "multiplierSequence": {
        "Progress": [
          {
            "count": 8,
            "multiplier": 2,
            "spins": 10
          },
          {
            "count": 8,
            "multiplier": 3,
            "spins": 10
          },
          {
            "count": 8,
            "multiplier": 5,
            "spins": 10
          },
          {
            "count": 8,
            "multiplier": 10,
            "spins": 10
          }
        ]
      },
      "extraWin": {
        "bigWin": "15.00",
        "superWin": "50.00",
        "megaWin": "100.00"
      },
      "lines": [
        [0, 0, 0, 0, 0],
        [1, 1, 1, 1, 1],
        [2, 2, 2, 2, 2],
        [3, 3, 3, 3, 3],
        [0, 1, 2, 1, 0],
        [1, 2, 3, 2, 1],
        [2, 1, 0, 1, 2],
        [3, 2, 1, 2, 3],
        [1, 0, 1, 0, 1],
        [2, 3, 2, 3, 2]
      ],
      "tiles": [
        {
          "id": 1,
          "type": "normal",
          "pays": ["0.00", "0.00", "0.10", "0.30", "1.00"]
        },
        {
          "id": 2,
          "type": "normal",
          "pays": ["0.00", "0.00", "0.10", "0.40", "1.50"]
        },
        {
          "id": 3,
          "type": "normal",
          "pays": ["0.00", "0.00", "0.20", "0.50", "2.00"]
        },
        {
          "id": 4,
          "type": "normal",
          "pays": ["0.00", "0.00", "0.20", "0.60", "2.50"]
        },
        {
          "id": 5,
          "type": "normal",
          "pays": ["0.00", "0.00", "0.30", "0.80", "3.00"]
        },
        {
          "id": 6,
          "type": "normal",
          "pays": ["0.00", "0.00", "1.00", "3.00", "10.00"]
        },
        {
          "id": 7,
          "type": "normal",
          "pays": ["0.00", "0.00", "1.50", "4.50", "15.00"]
        },
        {
          "id": 8,
          "type": "normal",
          "pays": ["0.00", "0.00", "2.00", "6.00", "20.00"]
        },
        {
          "id": 9,
          "type": "normal",
          "pays": ["0.00", "0.00", "3.00", "10.00", "30.00"]
        },
        {
          "id": 10,
          "type": "normal",
          "pays": ["0.00", "0.00", "0.00", "0.00", "0.00"]
        },
        {
          "id": 11,
          "type": "normal",
          "pays": ["0.00", "0.00", "0.00", "0.00", "0.00"]
        },
        {
          "id": 12,
          "type": "normal",
          "pays": ["0.00", "0.00", "0.00", "0.00", "0.00"]
        },
        {
          "id": 13,
          "type": "normal",
          "pays": ["0.00", "0.00", "0.00", "0.00", "0.00"]
        },
        {
          "id": 14,
          "type": "scatter",
          "pays": ["0.00", "0.00", "0.00", "0.00", "0.00"]
        }
      ],
      "reelsBuffer": [
        [
          [5, 2, 6],
          [5, 3, 6, 3],
          [9, 6, 2]
        ],
        [
          [4, 1, 7],
          [1, 7, 4, 4],
          [8, 7, 8]
        ],
        [
          [3, 4, 9],
          [1, 2, 2, 6],
          [1, 1, 5]
        ],
        [
          [1, 4, 9],
          [9, 3, 5, 7],
          [9, 6, 4]
        ],
        [
          [7, 5, 6],
          [3, 3, 8, 9],
          [9, 1, 4]
        ]
      ],
      "paysType": "LTR",
      "features": [
        "FreeSpins_cheap",
        "FreeSpins_normal",
        "FreeSpins_expensive",
        "FreeSpins"
      ],
      "singlePayline": true,
      "hasState": false,
      "version": "4.0.1",
      "rtp": {
        "game": {
          "default": "95.70"
        }
      },
      "volatilityIndex": "3.04",
      "maxMultiplier": "4835.30",
      "maxWinlineHitRate": "0.001883",
      "maxMultiplierHitRate": "0.001883",
      "maxMultiplierHitFrequency": "53106",
      "maxMultiplierWinLines": "60.00",
      "maxMultiplierWinLinesHitRate": "0.0000000000200000",
      "maxMultiplierWinLinesHitFrequency": "5000000000000",
      "hasGambleGame": false,
      "gameType": "slot",
      "stateful": false,
      "hasChoices": false,
      "stateExpireDays": null,
      "hasBonuses": false,
      "pendingRoundDays": 0,
      "skin": null,
      "hasFeatureBuy": false
    },
    "launcher": {
      "version": "1.31.3"
    },
    "jackpots": null
  }
}
```

## File: config/json/rtg-spin-lose.result.json
```json
[
  {
    "success": true,
    "result": {
      "transactions": {
        "roundId": 202900066
      },
      "user": {
        "balance": {
          "cash": {
            "atStart": "114.00",
            "afterBet": "112.00",
            "atEnd": "112.00"
          },
          "freeBets": {
            "atStart": "0.00",
            "afterBet": "0.00",
            "atEnd": "0.00"
          },
          "bonus": {
            "atStart": "0.00",
            "afterBet": "0.00",
            "atEnd": "0.00"
          },
          "sessionCash": {
            "atStart": "0.00",
            "afterBet": "0.00",
            "atEnd": "0.00"
          },
          "sessionFreeBets": {
            "atStart": "0.00",
            "afterBet": "0.00",
            "atEnd": "0.00"
          }
        },
        "canGamble": false,
        "userId": 7427503,
        "sessionId": "0",
        "sessionNetPosition": "12.00",
        "token": "db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a",
        "bonuses": [],
        "tournaments": [],
        "vouchers": [],
        "messages": [],
        "limits": {
          "betThresholdTime": 925
        },
        "serverTime": "2025-02-20 14:46:16"
      },
      "game": {
        "win": {
          "lines": "0.00",
          "total": "0.00"
        },
        "winsMultipliers": {
          "lines": "0.00",
          "total": "0.00"
        },
        "stake": "2.00",
        "multiplier": 1,
        "winLines": [],
        "spinMode": "Normal",
        "fatTiles": [
          {
            "tileId": 10,
            "reel": 3,
            "index": 2,
            "width": 1,
            "height": 1,
            "multiplier": 2,
            "amount": "4.00"
          },
          {
            "tileId": 10,
            "reel": 3,
            "index": 4,
            "width": 1,
            "height": 1,
            "multiplier": 2,
            "amount": "4.00"
          },
          {
            "tileId": 10,
            "reel": 3,
            "index": 6,
            "width": 1,
            "height": 1,
            "multiplier": 2,
            "amount": "4.00"
          },
          {
            "tileId": 10,
            "reel": 4,
            "index": 0,
            "width": 1,
            "height": 1,
            "multiplier": 5,
            "amount": "10.00"
          },
          {
            "tileId": 10,
            "reel": 3,
            "index": 0,
            "width": 1,
            "height": 1,
            "multiplier": 5,
            "amount": "10.00"
          }
        ],
        "scatters": [],
        "reelsBuffer": [
          [
            [7, 7, 2],
            [3, 8, 4, 2],
            [2, 14, 2]
          ],
          [
            [7, 5, 5],
            [1, 4, 2, 4],
            [4, 5, 9]
          ],
          [
            [3, 3, 1],
            [2, 9, 6, 8],
            [3, 8, 3]
          ],
          [
            [5, 7, 5],
            [10, 1, 10, 8],
            [10, 14, 10]
          ],
          [
            [3, 3, 6],
            [10, 9, 7, 3],
            [2, 4, 2]
          ]
        ],
        "features": [],
        "hasState": false
      },
      "jackpots": null,
      "bonusChance": null
    }
  },
  {
    "token": "db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a",
    "sessionId": "0",
    "playMode": "demo",
    "gameId": "BassBoss",
    "userData": {
      "userId": 7427503,
      "affiliate": "",
      "lang": "en",
      "channel": "I",
      "userType": "U",
      "fingerprint": "14b172bd-596f-476f-8a5b-b2a7d903cc43"
    },
    "custom": {
      "siteId": "",
      "extras": ""
    },
    "stake": 2,
    "bonusId": null,
    "extras": null
  },
  {
    "success": true,
    "result": {
      "transactions": {
        "roundId": 202900143
      },
      "user": {
        "balance": {
          "cash": {
            "atStart": "112.00",
            "afterBet": "110.00",
            "atEnd": "110.00"
          },
          "freeBets": {
            "atStart": "0.00",
            "afterBet": "0.00",
            "atEnd": "0.00"
          },
          "bonus": {
            "atStart": "0.00",
            "afterBet": "0.00",
            "atEnd": "0.00"
          },
          "sessionCash": {
            "atStart": "0.00",
            "afterBet": "0.00",
            "atEnd": "0.00"
          },
          "sessionFreeBets": {
            "atStart": "0.00",
            "afterBet": "0.00",
            "atEnd": "0.00"
          }
        },
        "canGamble": false,
        "userId": 7427503,
        "sessionId": "0",
        "sessionNetPosition": "10.00",
        "token": "db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a",
        "bonuses": [],
        "tournaments": [],
        "vouchers": [],
        "messages": [],
        "limits": {
          "betThresholdTime": 929
        },
        "serverTime": "2025-02-20 14:47:19"
      },
      "game": {
        "win": {
          "lines": "0.00",
          "total": "0.00"
        },
        "winsMultipliers": {
          "lines": "0.00",
          "total": "0.00"
        },
        "stake": "2.00",
        "multiplier": 1,
        "winLines": [],
        "spinMode": "Normal",
        "fatTiles": [
          {
            "tileId": 11,
            "reel": 4,
            "index": 3,
            "width": 1,
            "height": 1,
            "multiplier": 10,
            "amount": "20.00"
          }
        ],
        "actions": [
          {
            "type": "SwingStart",
            "data": {
              "multiplier": 1,
              "index": 1
            }
          }
        ],
        "scatters": [],
        "reelsBuffer": [
          [
            [2, 7, 9],
            [2, 5, 5, 1],
            [9, 6, 2]
          ],
          [
            [6, 4, 2],
            [5, 4, 7, 3],
            [9, 9, 3]
          ],
          [
            [4, 6, 1],
            [4, 1, 6, 7],
            [2, 5, 2]
          ],
          [
            [5, 6, 3],
            [4, 4, 5, 7],
            [5, 5, 1]
          ],
          [
            [7, 4, 6],
            [4, 5, 3, 11],
            [9, 5, 2]
          ]
        ],
        "features": [],
        "hasState": false
      },
      "jackpots": null,
      "bonusChance": null
    }
  }
]
```

## File: config/leveling.config.ts
```typescript
export interface LevelConfig {
  level: number
  name: string
  xpRequired: number
  cumulativeXpToReach: number
  cashbackPercentage: number
  prioritySupport: boolean
  dailyBonusMultiplier: number
  weeklyBonusAmount?: number
  monthlyBonusPackage?: string
  initialSpecialBonuses?: number
  benefits: string[]
}
⋮----
export function getVipLevelConfiguration(level: number): LevelConfig | null
export function getAllVipLevelConfigurations(): LevelConfig[]
export function getNextLevelConfiguration(currentLevel: number): LevelConfig | null
export function getTotalXpRequiredForLevel(targetLevel: number): number
export function getLevelFromTotalXp(totalXp: number): number
export function getXpProgressInLevel(totalXp: number, currentLevel: number):
export function getLevelUpRewards(level: number):
export function hasPrioritySupport(level: number): boolean
export function getCashbackPercentage(level: number): number
export function getXpMultiplier(level: number): number
```

## File: config/prisma.config.ts
```typescript
import path from 'node:path'
```

## File: handlers/chat.handler.ts
```typescript
import { publish } from '@/utils'
import { JoinRoom, MessageHandlerContext, NewMessage, SendMessage, UserJoined } from '@/types'
export function handleJoinRoom(context: MessageHandlerContext<typeof JoinRoom>)
export function handleSendMessage(context: MessageHandlerContext<typeof SendMessage>)
```

## File: handlers/heartbeat.handler.ts
```typescript
import { MessageHandlerContext, Ping, Pong } from '@/types'
export function handlePing(context: MessageHandlerContext<typeof Ping>)
```

## File: handlers/index.ts
```typescript

```

## File: handlers/kagaming-proxy.handler.ts
```typescript
import { BufferSource, ServerWebSocket } from 'bun'
import { CloseHandlerContext, OpenHandlerContext, UserProfile, WsData } from '@/types'
⋮----
interface InitPayloadContent {
  type: string
  bet?: any
}
interface InitPayload {
  id: string
  type: string
  content: InitPayloadContent
  protocol: string
  gameClientVersion?: string
  data?: { extPlayerKey?: string }
}
⋮----
function toHex(byteArray: number[]): string
function fromHex(str: string): number[]
function rc4Logic(keyByteArray: number[], inputByteArray: number[]): number[]
function stringToByteArray(str: string): number[]
function byteArrayToString(byteArray: number[]): string
⋮----
function lzwDecode(input: string): string
// --- App specific WsData extension for KaGaming Proxy ---
// Ensure this is compatible or merged with your global AppWsData in types.ts
export interface KaGamingProxyWsData extends WsData {
  data: any
  isKaGamingProxy?: boolean
  clientId: string
  kagamingSessionKey?: string
  kagamingRemoteWs?: WebSocket
  kagamingMessageCounter?: number
  kagamingRememberedData?: { extPlayerKey?: string }
  user: UserProfile
  token: string
  // Add gameCodeString, clientString, language if passed during upgrade
  kagamingGameCodeString?: string
  kagamingClientString?: string
  kagamingLanguage?: string
  kagamingToken?: string // For real money play
}
⋮----
// Add gameCodeString, clientString, language if passed during upgrade
⋮----
kagamingToken?: string // For real money play
⋮----
// --- Proxy Handlers ---
export async function kagamingProxyOpenHandler(context: OpenHandlerContext<KaGamingProxyWsData>)
⋮----
const { clientId, userId, isKaGamingProxy } = ws.data // clientId is from router, userId from auth
⋮----
export function kagamingProxyMessageHandler(
  ws: ServerWebSocket<KaGamingProxyWsData>,
  message: string | Buffer
)
export function kagamingProxyCloseHandler(context: CloseHandlerContext<KaGamingProxyWsData>)
```

## File: handlers/nolimit-proxy.handler.ts
```typescript
import {  OpenHandlerContext, CloseHandlerContext, UserProfile, AppWsData } from '@/types'
import { BufferSource, ServerWebSocket } from 'bun'
⋮----
interface InitPayloadContent {
  type: string
  bet?: any
}
interface InitPayload {
  id: string
  type: string
  content: InitPayloadContent
  protocol: string
  gameClientVersion?: string
  data?: { extPlayerKey?: string }
}
⋮----
function toHex(byteArray: number[]): string
function fromHex(str: string): number[]
function rc4Logic(keyByteArray: number[], inputByteArray: number[]): number[]
function stringToByteArray(str: string): number[]
function byteArrayToString(byteArray: number[]): string
⋮----
function lzwDecode(input: string): string
// --- App specific WsData extension for NoLimit Proxy ---
// Ensure this is compatible or merged with your global AppWsData in types.ts
export interface NoLimitProxyWsData extends AppWsData {
  [key: string]: any
  user: UserProfile
  token: string
  isNoLimitProxy?: boolean
  clientId: string
  nolimitSessionKey?: string
  nolimitRemoteWs?: WebSocket
  nolimitMessageCounter?: number
  nolimitRememberedData?: { extPlayerKey?: string }
  // Add gameCodeString, clientString, language if passed during upgrade
  nolimitGameCodeString?: string
  nolimitClientString?: string
  nolimitLanguage?: string
  nolimitToken?: string // For real money play
}
⋮----
// Add gameCodeString, clientString, language if passed during upgrade
⋮----
nolimitToken?: string // For real money play
⋮----
// --- Proxy Handlers ---
export async function nolimitProxyOpenHandler(context: OpenHandlerContext<NoLimitProxyWsData>)
⋮----
const { clientId, userId, isNoLimitProxy } = ws.data // clientId is from router, userId from auth
⋮----
export function nolimitProxyMessageHandler(
  ws: ServerWebSocket<NoLimitProxyWsData>,
  message: string | Buffer
)
export function nolimitProxyCloseHandler(context: CloseHandlerContext<NoLimitProxyWsData>)
```

## File: handlers/php-slots.handler.ts
```typescript
import { AppEvents, typedAppEventEmitter } from '@/lib/events'
import { sendToLaravel } from '@/routers/php.routes.js'
import type { Server, ServerWebSocket } from 'bun'
import {
  OpenHandlerContext,
  UserBalanceUpdate,
  UserBalanceUpdatePayload,
  UserProfile,
  WsData,
} from '@/types'
export interface UserEventWsData extends WsData {
  clientId: string
  user: UserProfile
  token: string
}
export function userEventsOpenHandler(context: OpenHandlerContext<any>)
export interface UserEventWsData extends WsData {
  clientId: string
  token: string
}
export function handleUserConnection(ws: OpenHandlerContext<any>['ws'])
export function initializeGlobalEventListeners(server: Server)
export function handleLaravelCommand(
  ws: ServerWebSocket<UserEventWsData>,
  payload: any,
  server: Server
)
```

## File: handlers/tournament.handler.ts
```typescript
import { AppEvents, typedAppEventEmitter } from '@/lib/events'
import { validateAndPublish } from '@/utils'
import { Server } from 'bun'
import {
  TournamentCreatedPayload,
  TournamentEndedEvent,
  TournamentEndedPayload,
  TournamentLeaderboardUpdatedPayload,
  TournamentLeaderboardUpdateEvent,
  TournamentNotificationEvent,
  TournamentParticipantJoinedEvent,
  TournamentParticipantJoinedPayload,
  TournamentStartedEvent,
  TournamentStartedPayload,
} from '@/types'
⋮----
function formatWebSocketMessage<T>(type: string, payload: T)
export function setupTournamentWebSocketListeners(server: Server)
```

## File: jobs/cashapp-watcher.job.ts
```typescript

```

## File: jobs/jackpot.jobs.ts
```typescript
import prisma from '@/prisma/'
import { JackpotService } from '../services/jackpot.service.js'
import { JACKPOT_CONFIG, JackpotUtils } from '@/types'
⋮----
export class JackpotJobs
⋮----
private constructor()
static getInstance(): JackpotJobs
async startJobs(): Promise<void>
stopJobs(): void
private startMaintenanceJob(): void
private startMonitoringJob(): void
private async runMaintenanceTasks(): Promise<void>
private async runMonitoringTasks(): Promise<void>
private async ensureJackpotsExist(): Promise<void>
private async validateJackpotAmounts(): Promise<void>
private async cleanupOldContributions(): Promise<void>
private async verifyJackpotWinTransactions(): Promise<void>
private async checkForAnomalies(stats: any): Promise<void>
async runManualMaintenance(): Promise<void>
getJobStatus():
```

## File: lib/auth.ts
```typescript
import { betterAuth } from 'better-auth'
import { prismaAdapter } from 'better-auth/adapters/prisma'
import { username, bearer, createAuthMiddleware } from 'better-auth/plugins'
import prisma from '@/prisma'
```

## File: lib/context.ts
```typescript
import { Session } from 'better-auth'
import { BunRequest, ServerWebSocket } from 'bun'
import { UserProfile } from '@/types'
import { auth } from './auth'
export type CreateMyContextOptions = {
  context: {
    req: Request
    res?: Response
    ws?: ServerWebSocket
    user?: UserProfile
    token?: string
    key?: string
    session?: Session
  }
}
export type CreateMyWsContextOptions = {
  context: {
    req: BunRequest
    res: Response
    ws?: ServerWebSocket
    user: UserProfile
    clientId: string
    userId?: string
    key?: string
    currentRoomId?: string
    [key: string]: unknown
    username?: string
    token: string
    isNoLimitProxy?: boolean
    nolimitSessionKey?: string
    nolimitRemoteWs?: WebSocket
    nolimitMessageCounter?: number
    nolimitRememberedData?: { extPlayerKey?: string }
    nolimitGameCodeString?: string
    nolimitClientString?: string
    nolimitLanguage?: string
    nolimitToken?: string
    subscribedTournamentTopics?: Set<string>
    mode?: string
    gameCodeString?: string
    kaToken?: string
    gameId?: string
    isKaGamingProxy?: boolean
    session: Session
  }
}
export async function createContext(
export type Context = Awaited<ReturnType<typeof createContext>>
```

## File: lib/events.ts
```typescript
import { EventEmitter } from 'node:events'
import {
  UserCreatedPayload,
  UserProfileUpdatedPayload,
  UserEventPayload,
  UserXpGainedPayload,
  UserLeveledUpPayload,
  UserRewardClaimedPayload,
  TransactionStatusChangedPayload,
  DepositSuccessfulPayload,
  WithdrawalProcessedPayload,
  WebSocketMessageToUserPayload,
  WebSocketBroadcastPayload,
  TournamentCreatedPayload,
  TournamentScoreUpdatedPayload,
  TournamentStartedPayload,
  TournamentEndedPayload,
  TournamentParticipantJoinedPayload,
  TournamentLeaderboardUpdatedPayload,
  UserBalanceUpdatePayload,
} from '@/types'
⋮----
export enum AppEvents {
  USER_CREATED = 'user:created',
  USER_UPDATED = 'user:updated',
  USER_EMAIL_VERIFIED = 'user:emailVerified',
  USER_PASSWORD_RESET_REQUESTED = 'user:passwordResetRequested',
  USER_PASSWORD_CHANGED = 'user:passwordChanged',
  USER_LOGIN_SUCCESS = 'user:loginSuccess',
  USER_LOGIN_FAILURE = 'user:loginFailure',
  USER_LOGOUT = 'user:logout',
  USER_PROFILE_UPDATED = 'user:profileUpdated',
  USER_BALANCE_UPDATED = 'user:balanceUpdated',
  GAME_SPIN_COMPLETED = 'game:spinCompleted',
  USER_XP_GAINED = 'user:xpGained',
  USER_LEVELED_UP = 'user:leveledUp',
  USER_REWARD_CREATED = 'user:rewardCreated',
  USER_REWARD_CLAIMED = 'user:rewardClaimed',
  VIP_BENEFIT_UNLOCKED = 'vip:benefitUnlocked',
  TRANSACTION_CREATED = 'transaction:created',
  TRANSACTION_CHANGED = 'transaction:changed',
  TRANSACTION_COMPLETED = 'transaction:completed',
  TRANSACTION_FAILED = 'transaction:failed',
  DEPOSIT_SUCCESSFUL = 'transaction:depositSuccessful',
  WITHDRAWAL_REQUESTED = 'transaction:withdrawalRequested',
  WITHDRAWAL_PROCESSED = 'transaction:withdrawalProcessed',
  GAME_SESSION_STARTED = 'game:sessionStarted',
  GAME_SESSION_ENDED = 'game:sessionEnded',
  GAME_BET_PLACED = 'game:betPlaced',
  GAME_WIN = 'game:win',
  ACHIEVEMENT_UNLOCKED = 'achievement:unlocked',
  WEBSOCKET_MESSAGE_TO_USER = 'websocket:messageToUser',
  WEBSOCKET_BROADCAST = 'websocket:broadcast',
  SYSTEM_NOTIFICATION = 'system:notification',
  TOURNAMENT_CREATED = 'tournament:created',
  TOURNAMENT_UPDATED = 'tournament:updated',
  TOURNAMENT_STARTED = 'tournament:started',
  TOURNAMENT_ENDED = 'tournament:ended',
  TOURNAMENT_PARTICIPANT_JOINED = 'tournament:participantJoined',
  TOURNAMENT_LEADERBOARD_UPDATED = 'tournament:leaderboardUpdated',
  TOURNAMENT_SCORE_UPDATED = 'tournament:scoreUpdated',
}
export interface EventPayloads {
  [AppEvents.USER_CREATED]: UserCreatedPayload
  [AppEvents.USER_BALANCE_UPDATED]: UserBalanceUpdatePayload
  [AppEvents.USER_UPDATED]: UserProfileUpdatedPayload
  [AppEvents.USER_EMAIL_VERIFIED]: UserEventPayload
  [AppEvents.USER_PASSWORD_RESET_REQUESTED]: UserEventPayload & { email: string }
  [AppEvents.USER_PASSWORD_CHANGED]: UserEventPayload
  [AppEvents.USER_LOGIN_SUCCESS]: UserEventPayload & { ipAddress?: string }
  [AppEvents.USER_LOGIN_FAILURE]: { emailOrUserId?: string; reason: string; ipAddress?: string }
  [AppEvents.USER_LOGOUT]: UserEventPayload
  [AppEvents.USER_PROFILE_UPDATED]: UserProfileUpdatedPayload
  [AppEvents.USER_XP_GAINED]: UserXpGainedPayload
  [AppEvents.USER_LEVELED_UP]: UserLeveledUpPayload
  [AppEvents.USER_REWARD_CREATED]: UserEventPayload & {
    rewardId: string
    rewardType: string
    description: string
  }
  [AppEvents.USER_REWARD_CLAIMED]: UserRewardClaimedPayload
  [AppEvents.VIP_BENEFIT_UNLOCKED]: UserEventPayload & {
    benefitId: string
    benefitName: string
    level: number
  }
  [AppEvents.TRANSACTION_CREATED]: TransactionStatusChangedPayload
  [AppEvents.TRANSACTION_COMPLETED]: TransactionStatusChangedPayload
  [AppEvents.TRANSACTION_CHANGED]: TransactionStatusChangedPayload
  [AppEvents.TRANSACTION_FAILED]: TransactionStatusChangedPayload & { reason?: string }
  [AppEvents.DEPOSIT_SUCCESSFUL]: DepositSuccessfulPayload
  [AppEvents.WITHDRAWAL_PROCESSED]: WithdrawalProcessedPayload
  [AppEvents.WITHDRAWAL_REQUESTED]: UserEventPayload & {
    transactionId: string
    amount: number
    currencyId: string
  }
  [AppEvents.ACHIEVEMENT_UNLOCKED]: UserEventPayload & {
    achievementId: string
    achievementName: string
  }
  [AppEvents.WEBSOCKET_MESSAGE_TO_USER]: WebSocketMessageToUserPayload
  [AppEvents.WEBSOCKET_BROADCAST]: WebSocketBroadcastPayload
  [AppEvents.SYSTEM_NOTIFICATION]: {
    message: string
    level: 'info' | 'warn' | 'error'
    details?: unknown
  }
  [AppEvents.TOURNAMENT_CREATED]: TournamentCreatedPayload
  [AppEvents.TOURNAMENT_UPDATED]: TournamentScoreUpdatedPayload
  [AppEvents.TOURNAMENT_STARTED]: TournamentStartedPayload
  [AppEvents.TOURNAMENT_ENDED]: TournamentEndedPayload
  [AppEvents.TOURNAMENT_PARTICIPANT_JOINED]: TournamentParticipantJoinedPayload
  [AppEvents.TOURNAMENT_LEADERBOARD_UPDATED]: TournamentLeaderboardUpdatedPayload
  [key: string]: unknown
}
interface TypedEventEmitter<TEvents extends Record<string, unknown>> {
  on<TEventName extends keyof TEvents>(
    eventName: TEventName,
    listener: (payload: TEvents[TEventName]) => void
  ): EventEmitter
  once<TEventName extends keyof TEvents>(
    eventName: TEventName,
    listener: (payload: TEvents[TEventName]) => void
  ): EventEmitter
  emit<TEventName extends keyof TEvents>(
    eventName: TEventName,
    payload: TEvents[TEventName]
  ): boolean
  off<TEventName extends keyof TEvents>(
    eventName: TEventName,
    listener: (payload: TEvents[TEventName]) => void
  ): EventEmitter
  removeAllListeners<TEventName extends keyof TEvents>(eventName?: TEventName): EventEmitter
  listenerCount(eventName: keyof TEvents): number
}
⋮----
on<TEventName extends keyof TEvents>(
once<TEventName extends keyof TEvents>(
emit<TEventName extends keyof TEvents>(
off<TEventName extends keyof TEvents>(
removeAllListeners<TEventName extends keyof TEvents>(eventName?: TEventName): EventEmitter
listenerCount(eventName: keyof TEvents): number
```

## File: lib/orpc.ts
```typescript
import { ORPCError, os } from '@orpc/server'
import type { Context } from './context'
```

## File: prisma/index.ts
```typescript
import { withAccelerate } from '@prisma/extension-accelerate'
import { performance } from 'perf_hooks'
⋮----
import { Prisma, PrismaClient } from '../generated/index.js'
type PrismaModelName = Prisma.ModelName
type PayloadObjects<M extends PrismaModelName> =
  Prisma.TypeMap['model'][M]['payload'] extends infer P
    ? P extends { objects: infer O }
      ? O
      : Record<string, never>
    : Record<string, never>
type RelationFieldNames<M extends PrismaModelName> = keyof PayloadObjects<M>
type IncludeAllRelationsForModel<M extends PrismaModelName> = {
  [K in RelationFieldNames<M>]: true
}
⋮----
async findUniqueDetails<T_ExtendedClient extends PrismaClient, M extends PrismaModelName>(
        this: T_ExtendedClient,
        modelName: M,
        args: Omit<
          Prisma.Args<T_ExtendedClient[Uncapitalize<M>], 'findUnique'>,
          'include' | 'select'
        >
      ): Promise<Prisma.Result<
        T_ExtendedClient[Uncapitalize<M>],
        Prisma.Args<T_ExtendedClient[Uncapitalize<M>], 'findUnique'> & {
          include: IncludeAllRelationsForModel<M>
        },
        'findUnique'
      > | null> {
        const dmmfObject = (client as any).$dmmf
if (!dmmfObject?.datamodel?.models)
⋮----
const createExtendedClient = () =>
⋮----
async $allOperations(
⋮----
async exists<T>(
              this: T,
              where: Prisma.Args<T, 'findFirst'>['where']
): Promise<boolean>
⋮----
compute(user:
⋮----
compute(userProfile:
⋮----
export type ExtendedPrismaClient = ReturnType<typeof createExtendedClient>
```

## File: routers/game.router.ts
```typescript
import {
  PrismaGameBigWinData as GameBigWinData,
  PrismaGameHistoryItem as GameHistoryItem,
  LaunchGameResponseDto,
  PaginatedResponse,
  PrismaGameProviderName,
  PrismaGameProvider as SharedGameProvider,
  PrismaGame as SharedPrismaGame,
} from '@/types/'
import z from 'zod/v4'
import prisma from '@/prisma/'
import { Prisma, GameCategory as PrismaGameCategoryEnum } from '@/generated/client'
import { protectedProcedure, publicProcedure } from '../lib/orpc'
⋮----
type GameWithProvider = SharedPrismaGame & {
  gameProvider?: SharedGameProvider | null;
};
const mapPrismaGameToSharedGame = (game: GameWithProvider): SharedPrismaGame =>
⋮----
interface LuckyBetInfo {
        id: string;
        userId: string;
        username: string;
        avatar: string | null;
        gameId: string | null;
        gameName: string | null;
        winAmount: number;
        wagerAmount: number;
        multiplier: number | null;
        timestamp: Date;
      }
```

## File: routers/index.ts
```typescript
import { protectedProcedure, publicProcedure } from '../lib/orpc'
import { vipRouter } from './vip.router'
⋮----
export type AppRouter = typeof appRouter
```

## File: routers/jackpot.router.ts
```typescript
import { JackpotUtils, type GetJackpotsResponse, type JackpotDisplayDto } from '@/types'
import z from 'zod/v4'
import { protectedProcedure, publicProcedure } from '../lib/orpc'
import { GameSpinService } from '../services/game-spin.service'
import { JackpotService } from '../services/jackpot.service'
```

## File: routers/netent.routes.ts
```typescript

```

## File: routers/netgame.routes.ts
```typescript

```

## File: routers/performance.routes.ts
```typescript
import { cacheService } from '@/services/redis.service'
import { Hono } from 'hono'
import { performanceMonitor } from '../services/performance-monitor.service'
```

## File: routers/php.routes.ts
```typescript
import { ServerWebSocket } from 'bun'
⋮----
export function connectToLaravel()
export async function sendToLaravel(ws: ServerWebSocket<any>, message: any)
⋮----
// var paramStr = JSON.stringify(param)
// var options = {
//   method: 'post',
```

## File: routers/rtg.routes.ts
```typescript
import { Context, Hono } from 'hono'
import { rtgSpinCached } from '../services/rtg.service'
interface DebounceEntry {
  lastCall: number
  timeout?: NodeJS.Timeout
}
class Debouncer
⋮----
isDebounced(key: string): boolean
markCall(key: string): void
⋮----
export class RtgApi
⋮----
constructor(app)
private setupRoutes()
private async rtgSettings(c: Context)
private async rtgSpin(c: Context)
private async rtgSpinWithPerformance(c: Context)
private async rtgSpinOptimized(c: Context)
private async rtgSpinCached(c: Context)
```

## File: routers/socket.router.ts
```typescript
import { handleJoinRoom, handleSendMessage } from '@/handlers/chat.handler'
import { handlePing } from '@/handlers/heartbeat.handler'
import { nolimitProxyMessageHandler, NoLimitProxyWsData } from '@/handlers/nolimit-proxy.handler'
import { cacheService } from '@/services/redis.service'
import { WebSocketMonitorService } from '@/services/websocket-monitor.service'
import { safeJsonParse, subscribeToTopic, unsubscribeFromTopic, validateAndSend } from '@/utils'
import type { Server, ServerWebSocket, WebSocketHandler } from 'bun'
import {
  AppWsData,
  CloseHandler,
  CloseHandlerContext,
  GenericWsResponse,
  JoinRoom,
  LaravelCommand,
  MessageHandler,
  MessageHandlerContext,
  MessageHandlerEntry,
  MessageSchemaType,
  OpenHandler,
  OpenHandlerContext,
  Ping,
  SendFunction,
  SendMessage,
  SubscribeToGeneralTournaments,
  SubscribeToTournamentTopic,
  UnsubscribeFromGeneralTournaments,
  UnsubscribeFromTournamentTopic,
  UpgradeRequestOptions,
  UserBalanceUpdate,
  UserBalanceUpdatePayload,
  UserLeft,
} from '@/types'
import { v4 as randomUUIDv7 } from 'uuid'
import { z } from 'zod'
import {
  kagamingProxyMessageHandler,
  KaGamingProxyWsData,
} from '@/handlers/kagaming-proxy.handler'
import { handleLaravelCommand } from '@/handlers/php-slots.handler'
import { AppEvents, typedAppEventEmitter } from '@/lib/events'
function handleSubscribeToTournamentTopic(
  context: MessageHandlerContext<typeof SubscribeToTournamentTopic, AppWsData>
)
function handleUnsubscribeFromTournamentTopic(
  context: MessageHandlerContext<typeof UnsubscribeFromTournamentTopic, AppWsData>
)
function handleSubscribeToGeneralTournaments(
  context: MessageHandlerContext<typeof SubscribeToGeneralTournaments, AppWsData>
)
function handleUnsubscribeFromGeneralTournaments(
  context: MessageHandlerContext<typeof UnsubscribeFromGeneralTournaments, AppWsData>
)
export class WebSocketRouter<T extends AppWsData = AppWsData>
⋮----
constructor()
public setServer(server: Server): void
public registerMessageHandler<Schema extends MessageSchemaType>(
    schema: Schema,
    handler: MessageHandler<Schema, T>
): void
public addOpenHandler(handler: OpenHandler<T>): void
public addCloseHandler(handler: CloseHandler<T>): void
public upgrade(options: UpgradeRequestOptions<Omit<T, 'clientId'>>): string | null
⋮----
private async handleClose(
    ws: ServerWebSocket<T>,
    code: number,
    reasonMessage: string
): Promise<void>
private async handleOpen(ws: ServerWebSocket<T>): Promise<void>
private async handleMessage(ws: ServerWebSocket<T>, message: string | Buffer): Promise<void>
private createSendFunction(ws: ServerWebSocket<T>): SendFunction
public get websocket(): WebSocketHandler<T>
```

## File: routers/tournament.router.ts
```typescript
import {
  JoinTournamentResponse as JoinTournamentResponseShared,
  PrismaTournament,
  PrismaTournamentParticipant,
  PrismaTournamentReward,
  TournamentCore,
  TournamentDetailed,
  TournamentParticipantInfo,
  TournamentStatus,
} from '@/types/'
import z from 'zod/v4'
import prisma from '@/index'
import { protectedProcedure, publicProcedure } from '../lib/orpc'
⋮----
const mapPrismaTournamentToTournamentCore = (
  tournament: PrismaTournament & {
    participants?: PrismaTournamentParticipant[]
    TournamentGames?: any[]
    rewards?: PrismaTournamentReward[]
  }
): TournamentCore =>
```

## File: routers/transaction.ts
```typescript
import { type } from '@orpc/server'
import { Product, TransactionType } from '@/generated'
import {
  DepositHistoryItem,
  DepositHistoryResponse,
  DepositProduct,
  GetOperatorDataResponse,
  OperatorData,
} from '@/types'
import z from 'zod/v4'
import type { ExtendedPrismaClient } from '@/prisma'
import prisma from '@/index'
import { protectedProcedure } from '../lib/orpc'
⋮----
// currency: tx.currency,
```

## File: routers/user.router.ts
```typescript
import { protectedProcedure } from '@/lib/orpc'
import { Prisma } from '@/generated'
import {
  PaginatedResponse as PaginatedResponseType,
  PrismaUserProfile as PrismaUserProfileType,
} from '@/types/'
import z from 'zod/v4'
import type { ExtendedPrismaClient } from '@/prisma'
import prisma from '@/index'
⋮----
type UserProfileBasicUpdateResponse = Pick<
  PrismaUserProfileType,
  'id' | 'username' | 'avatar' | 'userId'
>
type UserProfileAvatarUpdateResponse = Pick<PrismaUserProfileType, 'id' | 'avatar' | 'userId'>
type UserProfileCashtagUpdateResponse = Pick<PrismaUserProfileType, 'id' | 'cashtag' | 'userId'>
type ReferredUserProfileSubset = Pick<
  PrismaUserProfileType,
  'id' | 'username' | 'avatar' | 'createdAt' | 'userId'
>
type LeaderboardUserSubset = Pick<
  PrismaUserProfileType,
  'id' | 'username' | 'avatar' | 'totalXpFromOperator'
>
```

## File: routers/vip.router.ts
```typescript
import { InferRouterOutputs } from '@orpc/server'
import { VipInfo } from '@/types/'
import type { ExtendedPrismaClient } from '@/prisma'
import prisma from '@/index'
import { protectedProcedure } from '../lib/orpc'
⋮----
export type Outputs = InferRouterOutputs<typeof vipRouter>
```

## File: routers/websocket-monitor.router.ts
```typescript
import { Elysia } from 'elysia'
import { WebSocketMonitorService } from '@/services/websocket-monitor.service'
import { z } from 'zod'
```

## File: services/dbupdates/config.ts
```typescript

```

## File: services/dbupdates/logger.ts
```typescript
import config from './config'
class Logger
⋮----
info(...args: any[])
warn(...args: any[])
error(...args: any[])
```

## File: services/dbupdates/table.ts
```typescript
import {
  TableOptions,
  Operation,
  PendingEvent,
  Event,
  EventCallback,
  StringKeyMap,
  TableOperationSubs,
} from './types'
import config from './config'
import debounce from '@/utils/debounce'
import uid from 'short-uuid'
import logger from './logger'
import { formatRelation, formatTablePath } from '@/utils/formatters'
import { Pool } from 'pg'
⋮----
export default class Table
⋮----
get schema(): string
get tablePath(): string
get bufferInterval(): number
get maxBufferSize(): number
constructor(name: string, pool: Pool, options?: TableOptions)
on(operation: Operation | string, cb: EventCallback): string | null
off(subscriptionId: string)
onInsert(cb: EventCallback): string
onUpdate(cb: EventCallback): string
onDelete(cb: EventCallback): string
onAll(cb: EventCallback): string
_newSub(operation: Operation, cb: EventCallback): string
_newPendingEvent(event: PendingEvent)
async _processBuffer()
async _processPendingEvents(pendingEvents: PendingEvent[])
_filterAndIndexPendingEvents(
    pendingEvents: PendingEvent[],
    processInserts: boolean,
    processUpdates: boolean,
    processDeletes: boolean
): StringKeyMap[][]
async _resolveEventRecords(eventsNeedingResolution: StringKeyMap[]): Promise<StringKeyMap[]>
async _getRecordsWhere(tablePath: string, whereGroups: StringKeyMap[]): Promise<StringKeyMap[]>
_splitEventsByOperation(allEvents: Event[]): Event[][]
_onError(err: Error)
```

## File: services/dbupdates/types.ts
```typescript
export interface PgRealtimeClientOptions {
  user?: string
  password?: string
  host?: string
  port?: number
  database?: string
  minPoolConnections?: number
  maxPoolConnections?: number
  channel?: string
  bufferInterval?: number
  maxBufferSize?: number
  onError?: (error: Error) => void
}
export interface TableOptions {
  schema?: string
  bufferInterval?: number
  maxBufferSize?: number
  onError?: (error: Error) => void
}
export enum Operation {
  INSERT = 'INSERT',
  UPDATE = 'UPDATE',
  DELETE = 'DELETE',
  ALL = '*',
}
export type StringKeyMap = { [key: string]: any }
export type TableOperationSubs = { [key: string]: EventCallback }
export interface PendingEvent {
  type: 'INSERT' | 'UPDATE' | 'DELETE'
  timestamp: string
  operation: Operation
  schema: string
  table: string
  data: StringKeyMap
  primaryKeyData: StringKeyMap
  columnNamesChanged?: string[]
}
export interface Event {
  timestamp: string
  operation: Operation
  schema: string
  table: string
  data: StringKeyMap
  columnNamesChanged?: string[]
}
export type EventCallback = (event: Event | Event[]) => void
```

## File: services/dbupdates/version.ts
```typescript

```

## File: services/cashapp-payment-processing.service.ts
```typescript

```

## File: services/cashapp.integration.ts
```typescript

```

## File: services/game-spin.service.ts
```typescript
import prisma from '@/prisma/'
import { JackpotService } from './jackpot.service'
import { type ProcessJackpotContributionsResponse, type JackpotWinDto } from '@/types'
export interface GameSpinProcessingResult {
  gameSpinId: string
  jackpotContributions: ProcessJackpotContributionsResponse
  transactionIds: string[]
}
export interface CreateGameSpinRequest {
  gameSessionId: string
  sessionId: string
  spinNumber: number
  wagerAmount: number
  grossWinAmount: number
  currencyId?: string
  spinData?: any
}
export class GameSpinService
⋮----
constructor()
async processGameSpin(request: CreateGameSpinRequest): Promise<GameSpinProcessingResult>
private async createJackpotWinTransaction(
    jackpotWin: JackpotWinDto,
    userId: string
): Promise<string>
async getGameSpinWithJackpots(gameSpinId: string)
async getRecentSpinsWithJackpots(limit: number = 20)
async getGameJackpotStats(gameId: string)
async initializeJackpots(): Promise<void>
```

## File: services/jackpot-async.service.ts
```typescript
import { SQL } from 'bun'
import { JACKPOT_CONFIG, JackpotUtils } from '@/types'
import { TransactionStatus } from '@/generated/client'
import { CACHE_KEYS, cacheService } from './redis.service'
⋮----
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
class AsyncJackpotService
⋮----
async processJackpotsAsync(
    request: AsyncJackpotProcessingRequest
): Promise<JackpotProcessingResult>
⋮----
// Update jackpot amount
⋮----
// Check for jackpot win (only one jackpot can be won per spin)
⋮----
// Create jackpot win record
⋮----
// Reset jackpot to random seed amount
⋮----
// Create jackpot win transaction
⋮----
// Update wallet with jackpot win
⋮----
private async getActiveJackpots(eligibleTypes: string[]): Promise<any[]>
private shouldWinJackpot(jackpot: any): boolean
private async invalidateJackpotCache(): Promise<void>
```

## File: services/jackpot.service.ts
```typescript
import {
  JACKPOT_CONFIG,
  JackpotUtils,
  type JackpotContributionDto,
  type JackpotWinDto,
  type ProcessJackpotContributionsRequest,
  type ProcessJackpotContributionsResponse,
} from '@/types'
import prisma from '@/prisma/'
export class JackpotService
⋮----
constructor()
async initializeJackpots(): Promise<void>
async getActiveJackpots()
async processJackpotContributions(
    request: ProcessJackpotContributionsRequest
): Promise<ProcessJackpotContributionsResponse>
private shouldWinJackpot(jackpot: any, config: any): boolean
private async processJackpotWin(jackpot: any, gameSpinId: string): Promise<JackpotWinDto>
async getJackpotStats()
⋮----
interface JackpotWithWinner {
      type: any
      currentAmountCoins: any
      lastWonAt: any
      lastWinner?: {
        username: string | null
      } | null
    }
⋮----
async getRecentJackpotWins(limit: number = 10)
async getUserJackpotContributions(userId: string, limit: number = 50)
async getUserJackpotWins(userId: string)
```

## File: services/performance-monitor.service.ts
```typescript
import { cacheService } from './redis.service'
class PerformanceMonitorService
⋮----
constructor()
private startMonitoring(): void
private async collectMetrics(): Promise<void>
private checkPerformanceAlerts(cacheMetrics: any, systemMetrics: any): void
getPerformanceSummary(minutes: number = 5): any
private getPerformanceStatus(hitRate: number, responseTime: number, memoryMB: number): string
private getPerformanceRecommendations(
    hitRate: number,
    responseTime: number,
    memoryMB: number
): string[]
generatePerformanceReport(): string
getApiMetrics(): any
stopMonitoring(): void
```

## File: services/realtime.service.ts
```typescript
import { validateAndPublish } from '@/utils'
import { createClient } from '@supabase/supabase-js'
import type { Server } from 'bun'
import type { UserBalanceUpdatePayloadType } from '@/types'
import { DatabaseUpdate } from '@/types'
import { PendingEvent, PgRealtimeClientOptions } from './dbupdates/types'
import PgRealtimeClient from './update.service'
⋮----
export class RealtimeService
⋮----
constructor(options: PgRealtimeClientOptions)
public setServer(server: Server): void
private _registerPgClientErrorHandlers(): void
public async startListening(): Promise<void>
⋮----
const receivedDatabaseEvent = (event: any) =>
⋮----
private _setupTableListeners(): void
private _handleRawDbEvent(event: PendingEvent): void
async updateUserBalanceAndNotify(userId: string, newBalance: number)
private publishDbUpdate(
    userId: string,
    payload: any
): void
public async stopListening(): Promise<void>
```

## File: services/redis.service.ts
```typescript
import { RedisClient } from 'bun'
type ExtendedRedisClient = RedisClient & {
  lrange(key: string, start: number, stop: number): Promise<string[]>
  multi(): Multi
  lpush(key: string, ...values: string[]): Promise<number>
  ltrim(key: string, start: number, stop: number): Promise<string>
  expire(key: string, seconds: number): Promise<number>
  on(event: 'connect' | 'close' | 'error', listener: (...args: any[]) => void): void
  quit(): Promise<void>
}
⋮----
lrange(key: string, start: number, stop: number): Promise<string[]>
multi(): Multi
lpush(key: string, ...values: string[]): Promise<number>
ltrim(key: string, start: number, stop: number): Promise<string>
expire(key: string, seconds: number): Promise<number>
on(event: 'connect' | 'close' | 'error', listener: (...args: any[])
quit(): Promise<void>
⋮----
interface Multi {
  lpush(key: string, ...values: string[]): Multi
  ltrim(key: string, start: number, stop: number): Multi
  expire(key: string, seconds: number): Multi
  exec(): Promise<Array<[Error | null, any]>>
}
⋮----
lpush(key: string, ...values: string[]): Multi
ltrim(key: string, start: number, stop: number): Multi
expire(key: string, seconds: number): Multi
exec(): Promise<Array<[Error | null, any]>>
⋮----
interface CacheMetrics {
  hits: number
  misses: number
  sets: number
  deletes: number
  errors: number
  connectionErrors: number
  totalTime: number
}
⋮----
export class RedisCacheService
⋮----
incr(arg0: string)
sadd(arg0: string, refernceId: string)
srem(arg0: string, clientId: string)
decr(arg0: string)
⋮----
constructor()
private async connect(): Promise<void>
async healthCheck(): Promise<boolean>
resetMetrics(): void
private setupEventHandlers(): void
private startMonitoring(): void
private monitorPerformance(): void
private calculateHitRate(): number
private getFullKey(key: string, identifier?: string | undefined): string
async get<T>(key: string, identifier?: string): Promise<T | null>
async set<T>(
    key: string,
    value: T,
    ttl?: number,
    identifier?: string | number
): Promise<boolean>
async delete(key: string, identifier?: string): Promise<boolean>
async lrange(key: string, start: number, stop: number): Promise<string[]>
async lpush(key: string, ...values: string[]): Promise<number>
async ltrim(key: string, start: number, stop: number): Promise<boolean>
⋮----
private handleError(operation: string, error: unknown): void
getMetrics(): CacheMetrics &
async disconnect(): Promise<void>
async setWallet(userId: string, operatorId: string, wallet: any): Promise<boolean>
async invalidateWallet(userId: string, operatorId: string): Promise<boolean>
async invalidateGameSession(userId: string, gameId: string): Promise<boolean>
async getWallet(userId: string, operatorId: string): Promise<any | null>
async setUserProfile(userId: string, profile: any): Promise<boolean>
async invalidateUserProfile(userId: string): Promise<boolean>
async getGame(gameName: string): Promise<any | null>
async setGame(gameName: string, game: any): Promise<boolean>
async getGameSession(userId: string, gameId: string): Promise<any | null>
async setGameSession(userId: string, gameId: string, session: any): Promise<boolean>
async getProviderConfig(providerName: string): Promise<any | null>
async setProviderConfig(providerName: string, config: any): Promise<boolean>
async preloadUserData(userId: string, operatorId: string): Promise<void>
async warmCache(userId: string, gameId: string, operatorId: string): Promise<void>
async getUserProfile(userId: string): Promise<any | null>
```

## File: services/rtg-jackpot.integration.ts
```typescript
import {
  type ProviderSpinResponseData,
  type RTGSpinRequestDto,
  type RTGSpinResponseDto,
  JackpotUtils,
} from '@/types'
import prisma from '@/prisma/'
import { GameSpinService } from '../services/game-spin.service'
export class RTGJackpotIntegration
⋮----
constructor()
async processRTGSpinWithJackpots(
    input: RTGSpinRequestDto,
    userId: string,
    originalRTGResponse: ProviderSpinResponseData
): Promise<RTGSpinResponseDto>
private parseStakeAmount(stake: number | string): number
private parseWinAmount(winTotal: string): number
private async findOrCreateGameSession(sessionId: string, userId: string, gameId: string)
private async enhanceRTGResponseWithJackpots(
    originalResponse: ProviderSpinResponseData,
    spinResult: any
): Promise<ProviderSpinResponseData>
async getJackpotEligibility(wagerDollars: number): Promise<
async initialize(): Promise<void>
⋮----
export async function integrateJackpotsIntoRTGSpin()
export interface EnhancedProviderSpinResponseData extends ProviderSpinResponseData {
  jackpots?: {
    contributions: Array<{
      type: string
      amount: number
      amountCoins: number
    }>
    totalContribution: number
  }
  jackpotWin?: {
    type: string
    amount: number
    amountCoins: number
    winId: string
  }
  currentJackpots?: Array<{
    type: string
    amount: number
    amountCoins: number
  }>
}
```

## File: services/rtg-proxy.service.ts
```typescript
interface GameProviderConfig {
  rgsBaseUrl: string
  apiKey?: string
  settingsPath: (providerGameId: string) => string
  spinPath: (providerGameId: string) => string
  providerUserIdPrefix?: string
  extraHeaders?: Record<string, string>
}
```

## File: services/tournament.service.ts
```typescript
import { AppEvents, typedAppEventEmitter } from '@/lib/events'
import { Prisma, Tournament, TournamentStatus, UserProfile } from '@/generated'
import {
  TournamentCreatedPayload,
  TournamentEndedPayload,
  TournamentLeaderboardUpdatedPayload,
  TournamentParticipantJoinedPayload,
  TournamentParticipantType,
  TournamentStartedPayload,
} from '@/types/'
import type { ExtendedPrismaClient } from '@/prisma'
import prisma from '@/prisma'
⋮----
export interface CreateTournamentInput {
  name: string
  description?: string
  startTime: Date
  endTime?: Date
  targetScore?: number
  eligibleGames?: Array<{ gameId: string; pointMultiplier?: number }>
  rewards?: Array<{ rank: number; description: string  }>
  createdByUserId?: string
}
export interface UpdateTournamentInput {
  name?: string
  description?: string
  startTime?: Date
  endTime?: Date
  targetScore?: number
  status?: TournamentStatus
}
export async function createTournament(
  adminUser: UserProfile,
  input: CreateTournamentInput
): Promise<Tournament>
export async function updateTournament(
  adminUser: UserProfile,
  tournamentId: string,
  input: UpdateTournamentInput
): Promise<Tournament>
export async function listTournaments(filters: {
  status?: TournamentStatus
  gameId?: string
  activeNow?: boolean
}): Promise<Tournament[]>
export async function getTournamentDetails(tournamentId: string): Promise<Tournament | null>
export async function joinTournament(
  userId: string,
  tournamentId: string,
  _tx?: Prisma.TransactionClient
): Promise<TournamentParticipantType>
export async function recordTournamentPoints(
  userId: string,
  gameId: string,
  pointsEarnedInGame: number,
  gamePlayIdentifier: string,
  tx: Prisma.TransactionClient,
  _meta?: Prisma.InputJsonValue | null
): Promise<string[]>
export async function getTournamentLeaderboard(
  tournamentId: string,
  limit: number = 100
): Promise<TournamentParticipantType[]>
async function publishLeaderboardUpdate(tournamentId: string, _tx?: Prisma.TransactionClient)
export async function processTournamentStart(
  tournamentId: string
): Promise<void>
export async function processTournamentEnd(
  tournamentId: string,
  _tx?: Prisma.TransactionClient
): Promise<void>
⋮----
type ParticipantWithUser = typeof rankedParticipants[number] & {
    user?: {
      username: string | null
    }
  }
⋮----
export function initTournamentScheduler()
export async function getTournamentById(tournamentId: string, _tx?: Prisma.TransactionClient)
```

## File: services/transaction.service.ts
```typescript
import {
  Prisma,
  Transaction,
  TransactionStatus,
  TransactionType,
  Wallet,
} from '@/generated/client'
import prisma from '@/prisma/index'
import { AppEvents, typedAppEventEmitter } from '../lib/events'
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
): Promise<Transaction>
export async function getOrCreateWallet(
  userId: string,
  operatorId: string,
  tx?: any
): Promise<Wallet>
export async function updateWalletBalance(
  walletId: string,
  amountInCents: number,
  balanceType: 'balance' | 'bonusBalance' | 'lockedBalance' = 'balance',
  tx: any
): Promise<Wallet>
export function toCents(amount: number): number
export function fromCents(amountInCents: number): number
export async function recordSystemAwardTransaction(
  args: Omit<CreateTransactionArgs, 'status' | 'provider'> & {
    type: 'BONUS_AWARD' | 'XP_AWARD' | 'REBATE_PAYOUT'
  },
  tx: any
): Promise<Transaction>
export async function getTransactionHistory(
  userId: string,
  filters: {
    type?: TransactionType | TransactionType[]
    status?: TransactionStatus | TransactionStatus[]
  } = {},
  pagination: { skip?: number; take?: number } = { skip: 0, take: 20 }
)
```

## File: services/update.service.ts
```typescript
import { Pool } from 'pg'
import createSubscriber, { Subscriber } from 'pg-listen'
import { formatTablePath } from '@/utils/formatters'
import config from './dbupdates/config'
import logger from './dbupdates/logger'
import Table from './dbupdates/table'
import {
  PendingEvent,
  PgRealtimeClientOptions,
  StringKeyMap,
  TableOptions,
} from './dbupdates/types'
⋮----
export default class PgRealtimeClient
⋮----
get connectionConfig(): StringKeyMap
get defaultTableOptions(): TableOptions
get channel(): string
constructor(options?: PgRealtimeClientOptions)
async listen()
table(name: string, options?: TableOptions): Table
_createSubscriber(): Subscriber
_createConnectionPool(): Pool
_onEvent(event: PendingEvent)
_onError(err: Error)
```

## File: services/websocket-monitor.service.ts
```typescript
import { RedisCacheService } from './redis.service'
⋮----
export interface WebSocketEvent {
  id: string
  timestamp: string
  type: 'connect' | 'disconnect' | 'message_in' | 'message_out'
  clientId: string
  userId?: string
  username?: string
  path?: string
  message?: any
  size: number
  ip?: string
  userAgent?: string
}
export class WebSocketMonitorService
⋮----
static async logEvent(event: Omit<WebSocketEvent, 'id' | 'timestamp'>): Promise<void>
static async getRecentEvents(limit = 100): Promise<WebSocketEvent[]>
static async getConnectionStats(): Promise<
```

## File: services/xp.service.ts
```typescript
import { VipInfo } from '@/generated/client'
import prisma from '@/index'
import { getVipLevelConfiguration } from '../config/leveling.config'
⋮----
export interface XpGainSource {
  type: 'GAME_WAGER' | 'DEPOSIT' | 'DAILY_BONUS' | 'ACHIEVEMENT' | 'TOURNAMENT' | 'MANUAL'
  sourceId?: string
  metadata?: Record<string, any>
}
export interface XpCalculationResult {
  xpGained: number
  newTotalXp: number
  newCurrentLevelXp: number
  levelChanged: boolean
  newLevel: number
  oldLevel: number
}
export function calculateXpForWager(wagerAmount: number, vipInfo: VipInfo): number
export function calculateXpForDeposit(depositAmountCents: number, vipInfo: VipInfo): number
export async function addXpToUser(
  userId: string,
  xpAmount: number
): Promise<XpCalculationResult>
function calculateLevelProgression(totalXp: number):
async function createDefaultVipInfo(userId: string, tx: any): Promise<VipInfo>
async function applyLevelUpBenefits(userId: string, newLevel: number, tx: any): Promise<void>
export async function getUserXpProgress(userId: string): Promise<
```

## File: types/types/achievement.ts
```typescript
export interface GetAchievementItem {
    achievement_progress: number
    achievement_explain: Array<AchievementItem>
    award_progress: number
    award_explain: Array<ExplainItem>
    rate: number
}
export interface AchievementItem {
    index: number
    num: number
    award: number
    state: number
    rate: number
}
export interface ExplainItem {
    index: number
    num: number
    award: number
    status: number
    rate: number
}
export type GetAchievementResponse = {
    code: number
    data: GetAchievementItem
    message: string
}
```

## File: types/types/affiliate-invite.ts
```typescript
export interface GetInvitaionBonusData {
    id: string
    content: string
    cash: string
}
export interface GetBettingCommissionData {
    id: string
    content: string
    cash: string
}
export interface StatisticsItem {
    today_deposited_user: number
    yesterday_deposited_user: number
    today_revenue: number
    yesterday_revenue: number
    this_month_deposited_user: number
    this_month_revenue: number
    total_registered_user: number
    total_depositing_user: number
    total_revenue: number
}
```

## File: types/types/animation.ts
```typescript
export interface AnimationFrameData {
  filename: string;
  frame: { x: number; y: number; w: number; h: number };
  rotated: boolean;
  trimmed: boolean;
  spriteSourceSize: { x: number; y: number; w: number; h: number };
  sourceSize: { w: number; h: number };
}
export interface SpriteData {
  frames: AnimationFrameData[];
  meta?: {
    app?: string;
    version?: string;
    image?: string;
    format?: string;
    size?: { w: number; h: number };
    scale?: string;
  };
}
export interface AnimationConfig {
  name: string;
  spritesheetUrl: string;
  spriteDataUrl: string;
  fps?: number;
  loop?: boolean;
  width?: number;
  height?: number;
  onComplete?: () => void;
}
export interface AnimationControlPayload {
  name: string;
  action: 'play' | 'stop';
  options?: {
    loop?: boolean;
    fps?: number;
    onComplete?: () => void;
  };
}
⋮----
export type AnimationType = (typeof ANIMATION_TYPE)[keyof typeof ANIMATION_TYPE];
export interface AnimationData {
  name: string;
  path: string;
  type: AnimationType;
  description?: string;
  loop?: boolean;
  autoplay?: boolean;
  renderer?: 'svg' | 'canvas' | 'html';
  player?: 'lottie' | 'rive';
}
export interface AnimationComponentProps extends AnimationData {
  show: boolean;
  onCompleted?: () => void;
  onLoaded?: () => void;
}
```

## File: types/types/appBar.ts
```typescript
export interface GetUserData {
    id: string
    avatar: string
    name: string
    grade_level: string
    grade: string
    wallet: number | string
    currency: string
}
```

## File: types/types/auth.interface.ts
```typescript
import type { UserProfile } from '..'
export interface AuthCredentials {
  username: string
  password: string
}
export interface RegisterPayload extends AuthCredentials {
  username: string
}
export interface AuthResponseDto {
  accessToken: string
  error: string | null
  refreshToken?: string
  code: number
  user: UserProfile
}
export interface RefreshTokenDto {
  refreshToken: string
}
export interface GoogleSignInDto {
  idToken: string
}
export interface AuthenticatedState {
  loggedIn: boolean
}
export type AuthWebSocketEventType =
  | 'AUTH_STATE_CHANGE'
  | 'USER_UPDATED'
  | 'PROFILE_UPDATED'
export interface AuthWebSocketMessage {
  type: AuthWebSocketEventType
  payload: any
}
export interface SignUpPayload {
  email: string
  password: string
  username: string
}
export interface ApiErrorData {
  message: string
  code?: number | string
  errors?: Array<{ field: string; message: string }>
}
export interface ClientRegisterPayload {
  email: string
  password_hash: string
  username: string
}
export interface GoogleSignInResponse {
  authenticated: boolean
  accessToken: string
  refreshToken: string
  code: number
  user: UserProfile
}
export interface MappedActiveProfile {
  id: string
  balance: number
  xpEarned: number
  isActive: boolean
  lastPlayed: Date | null
  createdAt: Date
  updatedAt: Date | null
  phpId: number | null
  userId: string
  currency: string
  shopId: string
  userProfileUseridtouser: any | null
}
export interface PatchedVipInfo {
  [x: string]: any
  gamesession: any[]
  operator: any | null
  transactions: any[]
  user: any | null
}
```

## File: types/types/auth.socket-interface.ts
```typescript
export interface DecodedAuthWebSocketMessage<T = any> {
  identifier: (typeof AUTH_EVENT_IDENTIFIERS)[keyof typeof AUTH_EVENT_IDENTIFIERS]
  payload: T
}
export interface WSMessage {
  identifier: string
  message: any[] | any | null
  callbackId: string | null
}
```

## File: types/types/banner.ts
```typescript
export interface GetBannerList {
    id:string
    image_path:string
    icon_path:string
    click_feedback:number
    content:string
}
export interface GetBannerListResponse{
    code: number
    data: Array<GetBannerList>
    message: string
}
```

## File: types/types/bonus.ts
```typescript
export interface GetBonusData {
  type: string;
  rate: number;
  currentCash: string;
  totalCash: string;
  restCash: string;
  bonusCash: string;
  expireDate: string;
}
export interface BonusItem {
  type: number;
  status: number;
  now: string;
  max: number;
  min: number;
  award: number;
  ended_at: number;
  created_at: number;
  gain_amount: number;
  currency: string;
  receive: number;
  wager: number;
  rate: number;
  deposit: number;
  id: string | number;
  children: any;
}
export interface GetBonusList {
  list: Array<BonusItem>;
}
export type GetUserBonusResponse = {
  code: number;
  data: GetBonusList;
  message: string;
};
```

## File: types/types/chat.ts
```typescript
export interface ChatRequestData {
  type: string
  avatar: string
  grade: string
  gradeColor: string
  gradeBackground: string
  sender: string
  receiver: string
  message: string
  starLevel: Array<string>
}
export type MessageType = 'text' | 'image' | 'file'
export interface ChatSession {
  user: any
  unreadCount: number
  lastMessage?: {
    content: string
    createdAt: string
    type: string
  }
}
export interface ChatSummary {
  unreadCount: number
  lastMessage?: {
    type: string
    content: string
    createdAt: string
    isRecalled: boolean
    id: number
    fromUserId: number
    toUserId: number
    isRead: boolean
    fileUrl?: string
    fileName?: string
  }
}
export interface ChatSummaryMap {
  [userId: number]: ChatSummary
}
export interface ChatMessagePayload {
  type?: string
  content: string
  roomId?: string
  userId?: string
  username?: string
  timestamp?: string
}
```

## File: types/types/deposit.ts
```typescript
import { DepositProduct } from '@/types/transaction'
import type { PrismaPaymentMethod, PrismaProduct } from './prisma'
export interface GetCurrencyItem {
  icon: string
  name: string
  value: number
}
export interface GetPaymentItem {
  id: string
  icon: string
  name: string
  description: string
  min: string | number
  max: string | number
}
export interface GetPixInfo {
  id: string
  first_name: string
  last_name: string
}
export interface GetDepositResponse {
  code: number
  data: any
  message: string
}
export interface PrismaProductWithoutTransactions extends PrismaProduct {
  transactions: []
}
export interface GetPrismaProductsResponse {
  code: number
  products: any[]
  message: string
}
export interface OperatorData {
  id: string
  acceptedPayments: string[]
  products: DepositProduct[]
}
export interface GetOperatorDataResponse {
  code: number
  operator: OperatorData
  message: string
}
export interface DepositItem {
  id_number: string
  userId: string
  operatorId: string
  channels_id: string
  amount: string | number
  currency: string | null
  productId: string | null
  paymentMethod: PrismaPaymentMethod
}
export interface DepositHistoryItem {
  id: number
  created_at: number
  type: string
  createdAt: Date
  product: Partial<PrismaProduct> | null
  amount: string
  status:
    | 'PENDING'
    | 'PROCESSING'
    | 'COMPLETED'
    | 'FAILED'
    | 'CANCELLED'
    | 'REFUNDED'
    | 'EXPIRED'
    | 'REJECTED'
    | 'REQUIRES_ACTION'
    | 'ON_HOLD'
  note: string
  currency: 'USD'
}
export interface DepositHistoryResponse {
  total_pages: number
  record: Array<DepositHistoryItem>
  error: string | null
  code: number
}
export interface SubmitDepositResponse {
  code: number
  data: any
  error: string | null
}
export type GetDepositHistoryResponse = {
  code: number
  data: DepositHistoryResponse
  message: string
}
export interface InitializeDepositResponseDto {
  deposit_id: string
  payment_method: string
  payment_url?: string
  crypto_address?: string
  crypto_memo?: string
  message?: string
  qr_code_data?: string
  expected_amount?: string
  currency_id?: string
}
```

## File: types/types/event.ts
```typescript
export interface UserEventPayload {
  userId: string
  timestamp?: string | Date
}
export interface UserXpGainedEventPayload extends UserEventPayload {
  pointsGained: number
  source: string
  sourceId?: string
  newTotalXp: number
  currentLevel: number
  xpInLevel: number
  xpForNextLevel: number
  xpEventId: string
}
export interface UserLeveledUpEventPayload extends UserEventPayload {
  previousLevel: number
  newLevel: number
  newLevelTitle: string
  totalXp: number
}
export interface TransactionStatusChangedEventPayload extends UserEventPayload {
  transactionId: string
  newStatus: string
  previousStatus?: string
  amount?: number
  currencyId?: string
  transactionType?: string
}
export interface DepositSuccessfulEventPayload extends UserEventPayload {
  transactionId: string
  amount: number
  currencyId: string
  paymentProvider?: string
}
export interface WithdrawalRequestedEventPayload extends UserEventPayload {
  transactionId: string
  amount: number
  currencyId: string
}
export interface WebSocketMessageToUserEventPayload {
  userId: string
  eventType: string
  data: any
}
export interface UserXpGainedPayload extends UserEventPayload {
  pointsGained: number
  source: string
  sourceId?: string
  newTotalXp: number
  currentLevel: number
  xpInLevel: number
  xpForNextLevel: number
  xpEventId: string
}
export interface UserLeveledUpPayload extends UserEventPayload {
  previousLevel: number
  newLevel: number
  newLevelTitle: string
  totalXp: number
  rewardsGranted?: Array<{ rewardId: string; description: string; type: string }>
}
export interface UserCreatedPayload extends UserEventPayload {
  email: string
  name?: string | null
}
export interface UserProfileUpdatedPayload extends UserEventPayload {
  updatedFields: string[]
}
export interface TransactionStatusChangedPayload extends UserEventPayload {
  transactionId: string
  newStatus: string
  previousStatus?: string
  amount?: number
  currencyId?: string
  transactionType?: string
}
export interface DepositSuccessfulPayload extends UserEventPayload {
  transactionId: string
  amount: number
  currencyId: string
  paymentProvider?: string
}
export interface WithdrawalProcessedPayload extends UserEventPayload {
  transactionId: string
  amount: number
  currencyId: string
  paymentProvider?: string
}
export interface UserRewardClaimedPayload extends UserEventPayload {
  userRewardId: string
  rewardType: string
  description: string
  amount?: number | null
  currencyId?: string | null
}
export interface WebSocketMessageToUserPayload {
  userId: string
  eventType: string
  data: any
}
export interface WebSocketBroadcastPayload {
  eventType: string
  data: any
  room?: string
  excludeUserIds?: string[]
}
```

## File: types/types/game.ts
```typescript
import { UserProfile } from '@/generated'
import type {
  PrismaGame,
  PrismaGameSession,
  PrismaGameSpin,
  PrismaPaymentMethod,
  PrismaTransactionStatus,
  PrismaTransactionType,
  PrismaWallet,
} from './prisma'
export interface LuckyBetInfo {
  id: string
  username: string | null
  avatar: string | null
  gameName: string | null
  winAmount: number
  wagerAmount: number
  multiplier: number | null
  timestamp: Date
  userId?: string
}
export interface NolimitGameLaunchOptions {
  gameName: string
  user: {
    id: string | number
  }
}
export interface NetGameOptions {
  gameName: string
  token: string
  url: string
}
export interface RtgGameLaunchOptions {
  gameName: string
  lang?: string
  currency?: string
  mode?: 'real' | 'demo'
  rgsApiBase?: string
  gameCdnBase?: string
  operator?: string
  provider?: string
  depositUrl?: string
  lobbyUrl?: string
}
export interface OutputGameBigWinItem {
  id: string
  userId: string
  username: string | null
  avatar: string | null
  gameId: string | null
  gameName: string | null
  winAmount: number
  wagerAmount: number
  multiplier?: number | null
  timestamp: Date
  total_wagered_cents?: number
  rank?: number
  currency_code?: string
  description?: string | null
}
export interface GameBigWinResponseData {
  high_rollers: OutputGameBigWinItem[]
  lucky_bets: OutputGameBigWinItem[]
}
export interface HighRollerInfo {
  userId: string
  username: string | null
  avatar: string | null
  totalWagered: number
  lastActivity: Date
}
export interface GameBigWinData {
  high_rollers: HighRollerInfo[]
  lucky_bets: LuckyBetInfo[]
}
export interface ProviderSettingsResponseData {
  user: {
    balance: { cash: string; freeBets?: string; bonus?: string; [key: string]: any }
    canGamble: boolean
    userId: number | string
    sessionId: string
    sessionNetPosition?: string
    token: string
    country?: string
    currency?: { code: string; symbol: string }
    stakes?: any
    limits?: any
    serverTime: string
    [key: string]: any
  }
  game?: {
    version?: string
    gameType?: string
    [key: string]: any
  }
  launcher?: {
    version?: string
    [key: string]: any
  }
  jackpots?: any
}
export interface RTGSettingsResponseDto {
  success: boolean
  result?: ProviderSettingsResponseData
  error?: {
    code: string
    message: string
    details?: any
  }
}
export interface ProviderSpinResponseData {
  transactions: {
    roundId: number | string
    [key: string]: any
  }
  user: {
    balance: {
      cash: { atStart?: string; afterBet?: string; atEnd: string }
      freeBets?: { atStart?: string; afterBet?: string; atEnd: string }
      bonus?: { atStart?: string; afterBet?: string; atEnd: string }
      [key: string]: any
    }
    userId: number | string
    sessionId: string
    sessionNetPosition?: string
    token: string
    serverTime: string
    canGamble?: boolean
    [key: string]: any
  }
  game: {
    win: {
      instantWin?: string
      lines?: string
      total: string
      [key: string]: any
    }
    stake: string
    multiplier?: number
    winLines?: any[]
    reelsBuffer?: Array<Array<number[]>>
    [key: string]: any
  }
  jackpots?: any | null
  bonusChance?: any | null
}
export interface RTGSpinResponseDto {
  success: boolean
  result?: RtgSpinResult
  error?: {
    code: string
    message: string
    details?: any
  }
}
export interface RTGSettingsRequestDto {
  gameId: string
  token: string
  userId: string
  currency: string
  language: string
  mode: 'real' | 'demo'
  custom?: { siteId?: string; extras?: string; [key: string]: any }
  userData?: {
    userId?: string | number
    hash?: string
    affiliate?: string
    lang?: string
    channel?: string
    userType?: string
    fingerprint?: string
    [key: string]: any
  }
}
export interface RTGSpinRequestDto {
  token: string
  userId: string
  gameId: string
  stake: number | string
  currency: string
  sessionId: string
  playMode?: 'real' | 'demo' | 'test'
  actions?: any[]
  custom?: { siteId?: string; extras?: string; [key: string]: any }
  bonusId?: any
  extras?: any
  siteId?: string
  userType?: string
  lang?: string | number
  fingerprint?: string | number
  channel?: string | number
  affiliate?: string | number
  userData?: {
    userId?: string | number
    affiliate?: string
    lang?: string
    channel?: string
    userType?: string
    [key: string]: any
  }
  roundId?: string | number
  transactionId?: string | number
}
export interface GamePlatformSpinResultDetails {
  betTransaction: {
    include: {
      originatorUser: {
        select: {
          id: true
          username: true
        }
      }
    }
  }
  winTransaction?: {
    include: {
      originatorUser: {
        select: {
          id: true
          username: true
        }
      }
    }
  } | null
  finalPlatformWallet: PrismaWallet
  updatedGameSession: PrismaGameSession
  gameSpinRecord: PrismaGameSpin
  xpAwardedThisSpin: number
  tournamentPointsAwardedThisSpin: number
}
export type GameCategoryName = 'TABLE' | 'FISH' | 'POKER' | 'SLOTS' | 'OTHER'
export interface GameListResponse {
  code: number
  list: Game[]
  total: number
}
export interface Game {
  id: string
  name: string
  title: string
  providerName?: string
  providerGameId?: string
  category?: GameCategoryName
  isActive?: boolean
  thumbnailUrl?: string
  popularity?: number
}
export interface LaunchGameResponseDto {
  launch_url: string
  game_session_id?: string
  launch_strategy?: 'IFRAME' | 'REDIRECT' | 'POPUP'
  provider_parameters?: Record<string, any> | string
}
⋮----
export type RtgSpinResult = ProviderSpinResponseData
⋮----
export interface PrismaGamePlatformSpinResultDetails {
  betTransaction: {
    include: {
      originatorUser: {
        select: {
          id: true
          username: true
        }
      }
    }
  }
  winTransaction?: {
    include: {
      originatorUser: {
        select: {
          id: true
          username: true
        }
      }
    }
  } | null
  finalPlatformPrismaWallet: PrismaWallet
  updatedPrismaGameSession: PrismaGameSession
  gameSpinRecord: PrismaGameSpin
  xpAwardedThisSpin: number
  tournamentPointsAwardedThisSpin: number
}
⋮----
export type PrismaGameCategoryName = 'TABLE' | 'FISH' | 'POKER' | 'SLOTS' | 'OTHER'
export interface PrismaGameListResponse {
  code: number
  list: PrismaGame[]
  total: number
}
export interface LaunchPrismaGameResponseDto {
  launch_url: string
  game_session_id?: string
  launch_strategy?: 'IFRAME' | 'REDIRECT' | 'POPUP'
  provider_parameters?: Record<string, any> | string
}
⋮----
export interface Autoplay {
  type: string
  options: Options
}
export interface Options {
  spins: RtgSpins
  stopOnFeature: StopOnFeature
  stopOnLossLimits: StopOnLossLimits
  stopOnWin: StopOnWin
  hasRestart: boolean
}
export interface RtgSpins {
  values: string[]
  default: number
}
export interface StopOnFeature {
  enabled: boolean
}
export interface StopOnLossLimits {
  mandatory: boolean
  enabled: boolean
  values: string[]
  default: number
}
export interface StopOnWin {
  enabled: boolean
  values: string[]
}
export interface RtgSettingsBalance {
  cash: string
  freeBets: string
  sessionCash: string
  sessionFreeBets: string
  bonus: string
}
export interface Currency {
  code: string
  symbol: string
}
export interface Limits {
  maxGambleStake: string
  maxTotalStake: TotalStake
  minTotalStake: TotalStake
  spinDuration: null
}
export interface TotalStake {
  total: string
}
export interface Stakes {
  defaultIndex: number
  lastIndex: number
  types: string[]
}
export interface GameListResponse {
  code: number
  list: Array<Game>
  total: number
}
export interface Search {
  id: string
  name: string
  image: string
  developer: string
  is_demo: boolean
}
export interface GameItem {
  id: number
  name: string
  image: string
  developer: string
  producer: string
  is_demo: boolean
}
export interface GameEnterBody {
  id: string | Array<string>
  demo: boolean
}
export interface GameUserBody {
  game_categories_slug: string
  id: string
  demo: boolean
  page: number
  limit: number
}
export interface GameEnterResponse {
  method: string
  parames: string
  developer: string
  reserve: string
  weburl: string
}
export interface GameHistoryItem {
  name: string
  created_at: number
  amount: string | number
  multiplier: string | number
  bet_id: string | number
  status: string | number
  profit: number
}
export interface GameBigWinItem {
  game_id: string
  game_name: string
  game_icon: string
  user_name: string
  user_vip_group: number
  user_vip_level: number
  bet_amount: string
  multiplier: string
  win_amount: string
  time: number
}
export interface GameBigWinData {
  high_rollers: Array<HighRollerInfo>
  lucky_bets: Array<LuckyBetInfo>
}
export interface GameHistoryResponse {
  total_pages: number
  record: Array<GameHistoryItem>
}
export interface GameSearchResponse {
  items: Array<Game>
  total: number
}
export type GetGameFavoriteListResponse = {
  code: number
  data: Array<number | string>
  message: string
}
export type GetGameBigWinResponse = {
  code: number
  data: GameBigWinData
  message: string
}
export type Category = {
  name: string
  games: Game[]
}
export type GetGameCategoriesResponse = {
  code: number
  data: Array<any>
  messsage: string
}
export type GetGameSearchResponse = {
  code: number
  data: GameSearchResponse
  message: string
}
export type GetGameEnterResponse = {
  code: number
  data: GameEnterResponse
  gameSession: PrismaGameSession
  message: string
}
export type GetGameHistoryResponse = {
  code: number
  data: GameHistoryResponse
  message: string
}
export interface GameProvider {
  id: string
  name: string
  slug: string
  description?: string | null
  logo_url?: string | null
  is_enabled: boolean
  created_at: Date
  updated_at: Date
}
export interface GameType {
  id: string
  name: string
  slug: string
  provider_id: string
  category_id?: string | null
  description?: string | null
  thumbnail_url?: string | null
  banner_url?: string | null
  external_game_id?: string | null
  tags?: string[]
  rtp?: number | null
  volatility?: string | null
  is_active: boolean
  is_featured?: boolean
  launch_options?: Record<string, any> | null
  created_at: Date
  updated_at: Date
  provider?: GameProvider
}
export interface GameSpin {
  id: string
  user_id: string
  game_id: string
  currency_id: string
  bet_amount: number
  win_amount: number
  profit: number
  external_round_id?: string | null
  status: string
  bet_details?: Record<string, any> | null
  win_details?: Record<string, any> | null
  created_at: Date
  updated_at: Date
  user?: UserProfile
  game?: GameType
}
export interface RawGameSpinBody {
  user_id: string
  game_id: string
  currency_id: string
  rawVendorData: any
  created_at: Date
}
⋮----
export interface RtgGame {
  win: Win
  winsMultipliers: Win
  stake: string
  multiplier: number
  winLines: any[]
  spinMode: string
  fatTiles: FatTile[]
  instantWin: InstantWin
  actions: Action[]
  scatters: any[]
  reelsBuffer: Array<Array<number[]>>
  features: any[]
  hasState: boolean
}
export interface Action {
  type: string
  data: Data
}
export interface Data {
  multiplier?: number
  index?: number
  fatTiles?: FatTile[]
}
export interface FatTile {
  tileId: number
  reel: number
  index: number
  width: number
  height: number
  multiplier: number
  amount: string
}
export interface InstantWin {
  multiplier: string
  amount: string
  options: string[]
}
export interface Win {
  instantWin: string
  lines: string
  total: string
}
export interface Transactions {
  roundId: number
}
export type TransactionGetPayload = {
  id: string
  processedAt: Date | null
  walletId: string | null
  type: PrismaTransactionType
  status: PrismaTransactionStatus
  amount: number
  netAmount: number | null
  feeAmount: number | null
  productId: string | null
  paymentMethod: PrismaPaymentMethod | null
  balanceBefore: number | null
  balanceAfter: number | null
  bonusBalanceBefore: number | null
  bonusBalanceAfter: number | null
  bonusAmount: number | null
  wageringRequirement: number | null
  wageringProgress: number | null
  description: string | null
  provider: string | null
  providerTxId: string | null
  relatedGameId: string | null
  relatedRoundId: string | null
  metadata: any | null
  createdAt: Date
  updatedAt: Date
  userProfileId: string | null
  operatorId: string | null
}
export interface GamePlatformSpinResultDetails {
  betTransaction: {
    include: {
      originatorUser: {
        select: {
          id: true
          username: true
        }
      }
    }
  }
  winTransaction?: {
    include: {
      originatorUser: {
        select: {
          id: true
          username: true
        }
      }
    }
  } | null
  finalPlatformWallet: PrismaWallet
  updatedGameSession: PrismaGameSession
  gameSpinRecord: PrismaGameSpin
  xpAwardedThisSpin: number
  tournamentPointsAwardedThisSpin: number
  winAmountPlatformCents: number
}
⋮----
export interface PrismaGameEnterBody {
  id: string | Array<string>
  demo: boolean
}
export interface PrismaGameUserBody {
  game_categories_slug: string
  page: number
  limit: number
}
export interface PrismaGameHistoryItem {
  name: string
  created_at: number
  amount: string | number
  multiplier: string | number
  bet_id: string | number
  status: string | number
  profit: number
}
export interface PrismaGameBigWinItem {
  game_id: string
  game_name: string
  game_icon: string
  user_name: string
  user_vip_group: number
  user_vip_level: number
  bet_amount: string
  multiplier: string
  win_amount: string
  time: number
}
export interface PrismaGameBigWinData {
  high_rollers: Array<PrismaGameBigWinItem>
  lucky_bets: Array<PrismaGameBigWinItem>
}
export interface PrismaGameHistoryResponse {
  total_pages: number
  record: Array<PrismaGameHistoryItem>
}
export interface PrismaGameSearchResponse {
  items: Array<Search>
  total: number
}
```

## File: types/types/index.ts
```typescript

```

## File: types/types/invite.ts
```typescript
export interface InviteData {
  bonus_month: number | string;
  bonus_today: number | string;
  bonus_total: number | string;
  bonus_yesterdays: number | string;
  deposit_users: number | string;
  deposit_users_month: number | string;
  deposit_users_today: number | string;
  deposit_users_yesterdays: number | string;
  invite_code: string;
  invited_users: number | string;
  web_invite_url: string;
  available_bonus: string | number;
}
export interface InviteHistoryFormData {
  index: number;
  size: number;
  first_time: string | number;
  last_time: string | number;
}
export interface InviteHistoryData {
  total_pages: number;
  list: Array<InviteHistoryItem>;
}
export interface InviteHistoryItem {
  time: number | string;
  user: string;
  bonus: number | string;
}
export interface StatisticsData {
  today_profit: InviteStatisticsItem;
  week_profit: InviteStatisticsItem;
  month_profit: InviteStatisticsItem;
  receive_profit: number | string;
}
export interface InviteStatisticsItem {
  register_user: Array<number | string>;
  deposit_user: Array<number | string>;
  deposit_bonus: number | string;
  deposit_amount: Array<number | string>;
  bet_amount: Array<number | string>;
  bet_bonus: Array<number | string>;
  achievement_award: number | string;
}
export interface PersonalInvitationInformation {
  total_profit: string | number;
  invitation_bonus: string | number;
  bettion_commission: string | number;
  achievement_bonus: string | number;
  deposited_users: string | number;
  profit_today: {
    profit: string | number;
    bettion_commission: string | number;
    invite_bonus: string | number;
  };
  profit_week: {
    profit: string | number;
    bettion_commission: string | number;
    invite_bonus: string | number;
  };
  profit_month: {
    profit: string | number;
    bettion_commission: string | number;
    invite_bonus: string | number;
  };
}
export interface InviteHistoryConfig {
  list: Array<any>;
}
export type GetStatisticsResponse = {
  code: number;
  data: StatisticsData;
  message: string;
};
export type InviteHistoryResponse = {
  code: number;
  data: InviteHistoryData;
  message: string;
};
export interface GetInviteResponse {
  code: number;
  data: InviteData;
  message: string;
}
export interface GetInviteSelfResponse {
  code: number;
  data: PersonalInvitationInformation;
  message: string;
}
export interface GetInviteHistoryResponse {
  code: number;
  data: InviteHistoryConfig;
  message: string;
}
```

## File: types/types/jackpot.ts
```typescript
import type { PrismaUserProfile, PrismaJackpotType } from './prisma'
export type JackpotType = PrismaJackpotType
⋮----
export interface Jackpot {
  id: string
  type: JackpotType
  currentAmountCoins: number
  seedAmountCoins: number
  minimumBetCoins: number
  contributionRateBasisPoints: number
  probabilityPerMillion: number
  minimumTimeBetweenWinsMinutes: number
  lastWonAt: Date | null
  lastWonBy: string | null
  isActive: boolean
  createdAt: Date
  updatedAt: Date
  lastWinner?: PrismaUserProfile
}
export interface JackpotContribution {
  id: string
  jackpotId: string
  gameSpinId: string
  contributionAmountCoins: number
  createdAt: Date
}
export interface JackpotWin {
  id: string
  jackpotId: string
  winnerId: string
  winAmountCoins: number
  gameSpinId: string
  transactionId: string | null
  createdAt: Date
  jackpot?: Jackpot
  winner?: PrismaUserProfile
}
⋮----
export interface JackpotDisplayDto {
  id: string
  type: JackpotType
  currentAmountDollars: number
  lastWonAt: Date | null
  lastWinnerUsername: string | null
}
export interface JackpotContributionDto {
  jackpotType: JackpotType
  contributionAmountCoins: number
  contributionAmountDollars: number
}
export interface JackpotWinDto {
  id: string
  jackpotType: JackpotType
  winAmountCoins: number
  winAmountDollars: number
  winnerUsername: string
  gameSpinId: string
  createdAt: Date
}
export interface GetJackpotsResponse {
  jackpots: JackpotDisplayDto[]
}
export interface ProcessJackpotContributionsRequest {
  gameSpinId: string
  wagerCoins: number
  gameCategory: string
}
export interface ProcessJackpotContributionsResponse {
  contributions: JackpotContributionDto[]
  totalContributionCoins: number
  jackpotWin?: JackpotWinDto
}
```

## File: types/types/mail.ts
```typescript
export interface GetMailData {
    id: number
    icon: any
    offset: number
    mail_content_1: {
        color: string
        content: string
    }
    mail_content_2: {
        color: string
        content: string
    }
    mail_rail_1: {
        color: string
        content: string
    }
    mail_rail_2: {
        color: string
        content: string
    }
}
```

## File: types/types/prisma.ts
```typescript
export type PrismaGameCategory =
  | "FISH"
  | "POKER"
  | "SLOTS"
  | "TABLE_GAMES"
  | "LIVE_CASINO"
  | "SPORTSBOOK"
  | "VIRTUAL_SPORTS"
  | "LOTTERY"
  | "CRASH"
  | "OTHER";
export type PrismaGameProviderName =
  | "PRAGMATICPLAY"
  | "EVOPLAY"
  | "NETENT"
  | "PLAYNGO"
  | "RELAXGAMING"
  | "HACKSAW"
  | "BGAMING"
  | "SPRIBE"
  | "INTERNAL"
  | "REDTIGER"
  | "NETGAME"
  | "BIGFISHGAMES"
  | "CQNINE"
  | "NOLIMIT"
  | "KICKASS";
export type PrismaProviderAuthType =
  | "API_KEY"
  | "OAUTH2"
  | "JWT_SIGN"
  | "CUSTOM"
  | "NONE";
export type PrismaJackpotType = "MINOR" | "MAJOR" | "GRAND";
export type PrismaPaymentMethod = "INSTORE_CASH" | "INSTORE_CARD" | "CASH_APP";
export type PrismaRole =
  | "USER"
  | "ADMIN"
  | "VIP"
  | "MODERATOR"
  | "SYSTEM"
  | "OWNER"
  | "MEMBER"
  | "OPERATOR"
  | "SUPPORT_AGENT";
export type PrismaKeyMode =
  | "read"
  | "write"
  | "upload"
  | "manage_users"
  | "manage_settings"
  | "launch_game";
export type PrismaInvitationStatus =
  | "PENDING"
  | "ACCEPTED"
  | "DECLINED"
  | "INACTIVE";
export type PrismaTournamentStatus =
  | "PENDING"
  | "ACTIVE"
  | "COMPLETED"
  | "CANCELLED";
export type PrismaTransactionType =
  | "DEPOSIT"
  | "WITHDRAWAL"
  | "BET"
  | "WIN"
  | "TRANSFER_SENT"
  | "TRANSFER_RECEIVED"
  | "SYSTEM_ADJUSTMENT_CREDIT"
  | "SYSTEM_ADJUSTMENT_DEBIT"
  | "TOURNAMENT_BUYIN"
  | "TOURNAMENT_PRIZE"
  | "AFFILIATE_COMMISSION"
  | "REFUND"
  | "FEE"
  | "BONUS_AWARD"
  | "BET_PLACE"
  | "BET_WIN"
  | "BET_LOSE"
  | "BET_REFUND"
  | "BONUS_WAGER"
  | "BONUS_CONVERT"
  | "BONUS_EXPIRED"
  | "XP_AWARD"
  | "ADJUSTMENT_ADD"
  | "ADJUSTMENT_SUB"
  | "INTERNAL_TRANSFER"
  | "PRODUCT_PURCHASE"
  | "REBATE_PAYOUT"
  | "JACKPOT_WIN"
  | "JACKPOT_CONTRIBUTION";
export type PrismaTransactionStatus =
  | "PENDING"
  | "PROCESSING"
  | "COMPLETED"
  | "FAILED"
  | "CANCELLED"
  | "REFUNDED"
  | "EXPIRED"
  | "REJECTED"
  | "REQUIRES_ACTION"
  | "ON_HOLD";
export type PrismaRewardStatus =
  | "AVAILABLE"
  | "CLAIMED"
  | "EXPIRED"
  | "PENDING"
  | "VOIDED";
export type PrismaUser = {
  id: string;
  name: string;
  username: string;
  displayUsername: string;
  email: string;
  emailVerified: boolean;
  image: string | null;
  createdAt: Date;
  updatedAt: Date;
  accounts?: PrismaAccount[];
  sessions?: PrismaSession[];
};
export type PrismaSession = {
  id: string;
  expiresAt: Date;
  token: string;
  createdAt: Date;
  updatedAt: Date;
  ipAddress: string | null;
  userAgent: string | null;
  userId: string;
  user?: PrismaUser;
};
export type PrismaAccount = {
  id: string;
  accountId: string;
  providerId: string;
  userId: string;
  accessToken: string | null;
  refreshToken: string | null;
  idToken: string | null;
  accessTokenExpiresAt: Date | null;
  refreshTokenExpiresAt: Date | null;
  scope: string | null;
  password: string | null;
  createdAt: Date;
  updatedAt: Date;
  user?: PrismaUser;
};
export type PrismaVerification = {
  id: string;
  identifier: string;
  value: string;
  expiresAt: Date;
  createdAt: Date | null;
  updatedAt: Date | null;
};
export type PrismaGame = {
  id: string;
  name: string;
  title: string;
  goldsvetData: JsonValue | null;
  description: string | null;
  supportedProviders: PrismaGameProviderName[];
  category: PrismaGameCategory;
  tags: string[];
  isActive: boolean;
  thumbnailUrl: string | null;
  bannerUrl: string | null;
  meta: JsonValue | null;
  createdAt: Date;
  updatedAt: Date;
  featured: boolean;
  providerName: string | null;
  totalWagered: number;
  gameProviderId: string | null;
  operatorId: string | null;
  tournamentDirectives: JsonValue | null;
  status: boolean;
  checked: boolean;
  tournamentGames?: PrismaTournamentGames[];
  gameLaunchLinks?: PrismaGameLaunchLink[];
  gameSessions?: PrismaGameSession[];
  gameProvider?: PrismaGameProvider | null;
  operator?: PrismaOperator | null;
};
export type PrismaGameSession = {
  id: string;
  isActive: boolean;
  sessionData: JsonValue | null;
  authSessionId: string | null;
  currencyId: string | null;
  startedAt: Date;
  endTime: Date | null;
  startTime: Date | null;
  ipAddress: string | null;
  startingBalance: number | null;
  startingTotalXp: number | null;
  userAgent: string | null;
  createdAt: Date;
  updatedAt: Date;
  totalWagered: number;
  totalWon: number;
  userId: string;
  gameId: string;
  rtgToken: string | null;
  rtgFingerPrint: string | null;
  profileId: string | null;
  game?: PrismaGame;
  refferenceToUserProfile?: PrismaUserProfile;
  spins?: PrismaGameSpin[];
  UserProfile?: PrismaUserProfile[];
};
export type PrismaGameSpin = {
  id: string;
  spinData: JsonValue | null;
  createdAt: Date;
  grossWinAmount: number;
  currencyId: string | null;
  spinNumber: number;
  gameSessionId: string;
  wagerAmount: number;
  sessionId: string;
  timeStamp: Date;
  gameSession?: PrismaGameSession;
  jackpotContributions?: PrismaJackpotContribution[];
  jackpotWin?: PrismaJackpotWin | null;
};
export type PrismaGameProvider = {
  id: string;
  name: string;
  displayName: string | null;
  rgsBaseUrl: string;
  settingsPath: string | null;
  spinPath: string | null;
  resolveBetPath: string | null;
  providerRoundId: string | null;
  authType: PrismaProviderAuthType;
  apiKey: string | null;
  apiSecret: string | null;
  publicKey: string | null;
  privateKeyRef: string | null;
  configJson: JsonValue | null;
  isActive: boolean;
  notes: string | null;
  createdAt: Date;
  updatedAt: Date;
  games?: PrismaGame[];
};
export type PrismaGameLaunchLink = {
  id: string;
  tokenInternal: string;
  currency: string;
  playerOperatorId: string | null;
  mode: string;
  meta: JsonValue | null;
  requestIp: string | null;
  userAgent: string | null;
  sessionUrl: string | null;
  state: string;
  active: boolean;
  expiresAt: Date | null;
  extraMeta: JsonValue | null;
  tokenOriginal: string | null;
  createdAt: Date;
  updatedAt: Date;
  userId: string;
  gameId: string;
  operatorId: string;
  userProfileId: string | null;
  game?: PrismaGame;
  operator?: PrismaOperator;
  UserProfile?: PrismaUserProfile | null;
};
export type PrismaJackpot = {
  id: string;
  type: PrismaJackpotType;
  currentAmountCoins: number;
  seedAmountCoins: number;
  minimumBetCoins: number;
  contributionRateBasisPoints: number;
  probabilityPerMillion: number;
  minimumTimeBetweenWinsMinutes: number;
  lastWonAt: Date | null;
  lastWonBy: string | null;
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
  contributions?: PrismaJackpotContribution[];
  wins?: PrismaJackpotWin[];
  lastWinner?: PrismaUserProfile | null;
};
export type PrismaJackpotContribution = {
  id: string;
  jackpotId: string;
  gameSpinId: string;
  contributionAmountCoins: number;
  createdAt: Date;
  gameSpin?: PrismaGameSpin;
  jackpot?: PrismaJackpot;
};
export type PrismaJackpotWin = {
  id: string;
  jackpotId: string;
  winnerId: string;
  winAmountCoins: number;
  gameSpinId: string;
  transactionId: string | null;
  createdAt: Date;
  gameSpin?: PrismaGameSpin;
  jackpot?: PrismaJackpot;
  transaction?: PrismaTransaction | null;
  winner?: PrismaUserProfile;
};
export type PrismaOperator = {
  id: string;
  name: string;
  operatorSecret: string;
  operatorAccess: string;
  callbackUrl: string;
  active: boolean;
  permissions: PrismaKeyMode[];
  ips: string[];
  description: string | null;
  lastUsedAt: Date | null;
  createdAt: Date;
  updatedAt: Date;
  ownerId: string | null;
  acceptedPayments: PrismaPaymentMethod[];
  gameLaunchLinks?: PrismaGameLaunchLink[];
  games?: PrismaGame[];
  invitations?: PrismaOperatorInvitation[];
  products?: PrismaProduct[];
  transactions?: PrismaTransaction[];
  wallets?: PrismaWallet[];
};
export type PrismaOperatorInvitation = {
  id: string;
  operatorId: string;
  username: string;
  role: PrismaRole;
  token: string;
  expiresAt: Date;
  acceptedAt: Date | null;
  invitedById: string;
  userProfileId: string | null;
  operator?: PrismaOperator;
  invitedUser?: PrismaUserProfile;
};
export type PrismaProduct = {
  id: string;
  title: string;
  description: string;
  url: string;
  iconUrl: string | null;
  productType: string;
  bonusCode: string | null;
  bonusTotalInCredits: number;
  isActive: boolean | null;
  priceInCents: number;
  amountToReceiveInCredits: number;
  bestValue: number;
  discountInCents: number;
  bonusSpins: number;
  isPromo: boolean | null;
  totalDiscountInCents: number;
  shopId: string | null;
  createdAt: Date;
  updatedAt: Date | null;
  transactionId: string | null;
  operator?: PrismaOperator | null;
  Transaction?: PrismaTransaction | null;
  transactions?: PrismaTransaction[];
};
export type PrismaTournament = {
  id: string;
  name: string;
  description: string | null;
  startTime: Date;
  endTime: Date | null;
  targetScore: number | null;
  status: PrismaTournamentStatus;
  createdAt: Date;
  updatedAt: Date;
  createdByid: string | null;
  userId: string | null;
  user?: PrismaUserProfile | null;
  participants?: PrismaTournamentParticipant[];
  rewards?: PrismaTournamentReward[];
  tournamentGames?: PrismaTournamentGames[];
};
export type PrismaTournamentParticipant = {
  id: string;
  tournamentId: string;
  userId: string;
  score: number;
  rank: number | null;
  joinedAt: Date;
  gamePlays?: PrismaTournamentGamePlay[];
  tournament?: PrismaTournament;
  user?: PrismaUserProfile;
};
export type PrismaTournamentGamePlay = {
  id: string;
  tournamentParticipantId: string;
  gameId: string;
  pointsEarned: number;
  playedAt: Date;
  gameSessionId: string | null;
  tournamentParticipant?: PrismaTournamentParticipant;
};
export type PrismaTournamentReward = {
  id: string;
  tournamentId: string;
  rank: number;
  description: string;
  isClaimed: boolean;
  winnerId: string | null;
  tournament?: PrismaTournament;
  winner?: PrismaUserProfile | null;
};
export type PrismaTournamentGames = {
  A: string;
  B: string;
  games?: PrismaGame;
  tournament?: PrismaTournament;
};
export type PrismaTransaction = {
  id: string;
  processedAt: Date | null;
  walletId: string | null;
  type: PrismaTransactionType;
  status: PrismaTransactionStatus;
  amount: number;
  netAmount: number | null;
  feeAmount: number | null;
  productId: string | null;
  paymentMethod: PrismaPaymentMethod | null;
  balanceBefore: number | null;
  balanceAfter: number | null;
  bonusBalanceBefore: number | null;
  bonusBalanceAfter: number | null;
  bonusAmount: number | null;
  wageringRequirement: number | null;
  wageringProgress: number | null;
  description: string | null;
  provider: string | null;
  providerTxId: string | null;
  relatedGameId: string | null;
  relatedRoundId: string | null;
  metadata: JsonValue | null;
  createdAt: Date;
  updatedAt: Date;
  userProfileId: string | null;
  operatorId: string | null;
  jackpotWins?: PrismaJackpotWin[];
  products?: PrismaProduct[];
  rebateGenerated?: PrismaRebateTransaction | null;
  operator?: PrismaOperator | null;
  product?: PrismaProduct | null;
  userProfile?: PrismaUserProfile | null;
  wallet?: PrismaWallet | null;
};
export type PrismaRebateTransaction = {
  id: string;
  userId: string;
  transactionId: string;
  rebateAmount: number;
  currencyId: string;
  vipLevel: number;
  rebatePercentage: number;
  status: PrismaRewardStatus;
  paidOutAt: Date | null;
  createdAt: Date;
  updatedAt: Date;
  originalTransaction?: PrismaTransaction;
  user?: PrismaUserProfile;
};
export type PrismaWallet = {
  id: string;
  balance: number;
  isActive: boolean;
  address: string | null;
  createdAt: Date;
  updatedAt: Date;
  userId: string;
  operatorId: string;
  paymentMethod: PrismaPaymentMethod;
  bonusBalance: number;
  lockedBalance: number;
  transactions?: PrismaTransaction[];
  operator?: PrismaOperator;
  user?: PrismaUserProfile;
  cashtag: string | null;
};
export type PrismaUserProfile = {
  id: string;
  createdAt: Date;
  updatedAt: Date;
  username: string;
  avatar: string | null;
  cashtag: string | null;
  balance: number;
  totalXpFromOperator: number;
  activeCurrencyType: string;
  lastDailySpin: Date;
  userId: string;
  isActive: boolean;
  otherUserid: string | null;
  role: PrismaRole | null;
  operatorId: string | null;
  currentGameSessionid: string | null;
  vipInfoId: string;
  tournament?: PrismaTournament[];
  tournamentParticipant?: PrismaTournamentParticipant[];
  tournamentReward?: PrismaTournamentReward[];
  gameLaunchLink?: PrismaGameLaunchLink[];
  pastGameSessions?: PrismaGameSession[];
  jackpotWins?: PrismaJackpotWin[];
  lastJackpotWon?: PrismaJackpot[];
  operatorInvitations?: PrismaOperatorInvitation[];
  rebateTransactions?: PrismaRebateTransaction[];
  transactions?: PrismaTransaction[];
  currentGameSession?: PrismaGameSession | null;
  vipInfo?: PrismaVipInfo;
  wallets?: PrismaWallet[];
};
export type PrismaVipInfo = {
  id: string;
  createdAt: Date;
  updatedAt: Date;
  username: string;
  avatar: string | null;
  userId: string;
  level: number;
  currentLevelXp: number;
  totalXp: number;
  dailyBonusClaimedAt: Date | null;
  weeklyBonusClaimedAt: Date | null;
  monthlyBonusClaimedAt: Date | null;
  cashbackPercentage: number;
  userProfile?: PrismaUserProfile | null;
};
type JsonValue =
  | string
  | number
  | boolean
  | { [key in string]?: JsonValue }
  | Array<JsonValue>
  | null;
```

## File: types/types/promo.ts
```typescript
export interface PromoData {
    group_id: number
    group_name: string
    list_data: Array<PromoListData>
}
export interface PromoListData {
    id: number
    name: string
    image_path: string
    text: string
    desc: string
    countdown: boolean
    content: string
    click_feedback: number
    button_path: string
    button_text: string
}
export interface PromoGroupData {
    group_data: Array<PromoData>
}
export type GetPromoListResponse = {
    code: number | string
    data: PromoGroupData
    message: string
}
```

## File: types/types/reward.ts
```typescript
export interface GetRewardCenterList {
    achievement: string
    achievement_status: number
    cash_back: string
    week: string
    level_up_num: number
}
export interface GetRewardCenterListResponse{
    code: number
    data: GetRewardCenterList
    message: string
}
export interface GetBonusResponse{
    code:number
    data:any
    message:string
}
```

## File: types/types/rgs-proxy.error.ts
```typescript
export class RgsProxyError extends Error
⋮----
constructor(message: string, statusCode = 500, providerDetails?: Record<string, unknown>)
toJSON()
⋮----
export function isRgsProxyError(error: unknown): error is RgsProxyError
export interface ProviderErrorResponse {
  error: string
  errorCode?: string | number
  message?: string
  details?: Record<string, unknown>
  statusCode?: number
}
export enum ProviderErrorCode {
  UNKNOWN_ERROR = 1000,
  INVALID_REQUEST = 1001,
  VALIDATION_ERROR = 1002,
  CONFIGURATION_ERROR = 1003,
  AUTHENTICATION_FAILED = 2000,
  INVALID_CREDENTIALS = 2001,
  TOKEN_EXPIRED = 2002,
  INSUFFICIENT_PERMISSIONS = 2003,
  GAME_NOT_FOUND = 3000,
  GAME_UNAVAILABLE = 3001,
  INSUFFICIENT_FUNDS = 3002,
  BET_LIMIT_EXCEEDED = 3003,
  SESSION_EXPIRED = 4000,
  SESSION_NOT_FOUND = 4001,
  EXTERNAL_SERVICE_ERROR = 5000,
  EXTERNAL_SERVICE_TIMEOUT = 5001,
  MAINTENANCE_MODE = 6000,
  UPDATE_IN_PROGRESS = 6001,
}
export function createErrorResponse(
  error: Error | string,
  code: ProviderErrorCode = ProviderErrorCode.UNKNOWN_ERROR,
  details?: Record<string, unknown>
): ProviderErrorResponse
```

## File: types/types/routes.ts
```typescript
export class LOGIN
export class OPERATOR
export class HOME_PAGE
export class PERSONAL_INFO_PAGE
export class PRAGMATIC
export class DEPOSIT_PAGE
export class WITHDRAW_PAGE
export class INVITE_PAGE
export class GAME_INFO
export class VIP_INFO
export class WEB_SOCKET
export class ACTIVITY
export class TRANSACTION_PAGE
export class BONUS_PAGE
export class UNSOLICITED
export class CURRENCY
export class REWARD_ROUTES
export class ACHIEVEMENT_ROUTES
export class TOURNAMENTS
export class ADMIN_TOURNAMENTS
```

## File: types/types/signin.ts
```typescript
import type { Session } from 'better-auth'
export interface SigninRequestData {
  username: string
  password: string
}
export interface authRequestData {}
export type GetSigninResponseData = {
  code: number
  token: string
  message: string
}
export type GetSession = {
  token: string
  code: number
  session: Session
}
```

## File: types/types/signup.ts
```typescript
export interface SignupRequestData {
  username: string
  password: string
  referral_code: string
  browser: string
  device: string
  model: string
  brand: string
  imei: string
}
export type GetSignupResponseData = {
  code: number
  token: string
  message: string
}
```

## File: types/types/socket.ts
```typescript
export interface GetUserBalanceSocket {
  bal: string | number
  cur: string
  mt: number
}
import type { HeadersInit, Server, ServerWebSocket } from 'bun'
import { z, ZodLiteral, ZodObject, type ZodRawShape, type ZodTypeAny } from 'zod'
import { UserProfile } from '..'
import type {
  TournamentEndedPayload,
  TournamentParticipantJoinedPayload,
  TournamentStartedPayload,
} from './tournament'
⋮----
export type UserBalanceUpdatePayloadType = z.infer<typeof UserBalanceUpdatePayloadSchema>
⋮----
export type ErrorCode = z.infer<typeof ErrorCode>
⋮----
export type BaseMessageSchema<T extends string> = ZodObject<{
  type: ZodLiteral<T>
  meta: typeof MessageMetadataSchema
}>
export type PayloadMessageSchema<T extends string, P extends ZodTypeAny> = ZodObject<{
  type: ZodLiteral<T>
  meta: typeof MessageMetadataSchema
  payload: P
}>
export type MessageSchemaWithCustomMeta<T extends string, M extends ZodRawShape> = ZodObject<{
  type: ZodLiteral<T>
  meta: ZodObject<typeof MessageMetadataSchema.shape & M>
}>
export type PayloadMessageSchemaWithCustomMeta<
  T extends string,
  P extends ZodTypeAny,
  M extends ZodRawShape,
> = ZodObject<{
  type: ZodLiteral<T>
  meta: ZodObject<typeof MessageMetadataSchema.shape & M>
  payload: P
}>
export function messageSchema<T extends string>(messageType: T): BaseMessageSchema<T>
export function messageSchema<T extends string, P extends Record<string, ZodTypeAny>>(
export function messageSchema<T extends string, P extends ZodTypeAny>(
export function messageSchema<T extends string, M extends ZodRawShape>(
export function messageSchema<
export function messageSchema<T extends string, P extends ZodTypeAny, M extends ZodRawShape>(
export function messageSchema<
  T extends string,
  P extends Record<string, ZodTypeAny> | ZodTypeAny | undefined = undefined,
  M extends ZodRawShape = Record<string, never>,
>(
  messageType: T,
  payload?: P,
  meta?: ZodObject<M>
): P extends undefined
  ? M extends Record<string, never>
    ? BaseMessageSchema<T>
    : MessageSchemaWithCustomMeta<T, M>
  : P extends Record<string, ZodTypeAny>
    ? M extends Record<string, never>
      ? PayloadMessageSchema<T, ZodObject<P>>
      : PayloadMessageSchemaWithCustomMeta<T, ZodObject<P>, M>
    : M extends Record<string, never>
      ? PayloadMessageSchema<T, P & ZodTypeAny>
      : PayloadMessageSchemaWithCustomMeta<T, P & ZodTypeAny, M> {
  const baseMetaSchema = MessageMetadataSchema.extend(meta ? meta.shape : {})
  const baseSchema = z.object({
    type: z.literal(messageType),
    meta: baseMetaSchema,
  })
if (payload === undefined)
⋮----
export type MessageHandlerContext<
  Schema extends MessageSchemaType,
  Data extends AppWsData = AppWsData,
> = {
  ws: ServerWebSocket<Data>
  meta: z.infer<Schema['shape']['meta']>
  send: SendFunction
  server: Server
} & (Schema['shape'] extends { payload: infer P }
  ? P extends ZodTypeAny
    ? { payload: z.infer<P> }
    : {}
  : {})
export interface WsData {
  clientId: string
  userId?: string
  key?: string
  currentRoomId?: string
  [key: string]: unknown
}
export type AppWsData = WsData & {
  data: any
  user: UserProfile
  username?: string
  token: string
  key?: string
  isNoLimitProxy?: boolean
  nolimitSessionKey?: string
  nolimitRemoteWs?: WebSocket
  nolimitMessageCounter?: number
  nolimitRememberedData?: { extPlayerKey?: string }
  nolimitGameCodeString?: string
  nolimitClientString?: string
  nolimitLanguage?: string
  nolimitToken?: string
  subscribedTournamentTopics?: Set<string>
  mode?: string
  gameCodeString?: string
  kaToken?: string
  gameId?: string
  isKaGamingProxy?: boolean
}
export type MessageSchemaType = ZodObject<{
  type: ZodLiteral<string>
  meta: typeof MessageMetadataSchema
  payload?: ZodTypeAny
}>
export type SendFunction = <Schema extends MessageSchemaType>(
  schema: Schema,
  payload: Schema['shape'] extends { payload: infer P }
    ? P extends ZodTypeAny
      ? z.infer<P>
      : unknown
    : unknown,
  meta?: Partial<Omit<z.infer<Schema['shape']['meta']>, 'clientId' | 'timestamp'>>
) => void
export type MessageHandler<Schema extends MessageSchemaType, Data extends AppWsData = AppWsData> = (
  context: MessageHandlerContext<Schema, Data>
) => void | Promise<void>
export interface OpenHandlerContext<Data extends AppWsData = AppWsData> {
  ws: ServerWebSocket<Data>
  send: SendFunction
}
export type OpenHandler<Data extends AppWsData = AppWsData> = (
  context: OpenHandlerContext<Data>
) => void | Promise<void>
export interface CloseHandlerContext<Data extends AppWsData = AppWsData> {
  ws: ServerWebSocket<Data>
  code: number
  reason?: string
  send: SendFunction
}
export type CloseHandler<Data extends AppWsData = AppWsData> = (
  context: CloseHandlerContext<Data>
) => void | Promise<void>
export interface MessageHandlerEntry<Data extends AppWsData = AppWsData> {
  schema: MessageSchemaType
  handler: MessageHandler<MessageSchemaType, Data>
}
export interface WebSocketRouterOptions {
  server?: Server
}
export interface UpgradeRequestOptions<T extends Omit<AppWsData, 'clientId'>> {
  server: Server
  request: Request
  data?: T
  headers?: HeadersInit
}
```

## File: types/types/tournament.ts
```typescript
import { Game, PrismaUserProfile, UserProfile } from '../index'
import type { PrismaTournamentParticipant } from './prisma'
export interface TeamBasedTournament {
  id: number
  history_id: number
  historyId: number
  title: string
  slug: string
  image: string
  isActive: boolean
  currentTime: Date
  start: string
  end: string
  betMin: number
  betsMin: number
  duration: string
  isOpen: boolean
  startDate: Date
  startTime: string
  outplayAttempts: number
  mode: string
  winners: UserProfile[]
  isAutoSubscription: boolean
  betsOn: string
  betLimit: number
  minBetLimit: number
  maxBetLimitShort: string
  info: string
  isMajor: boolean
  prizeLimit: number
  prizeFund: string
  prize: string
  raceType: string
  prizes: { [key: string]: { coins: number } }[]
  prizeTotal: [coins: number, entries: number]
  additionalPrizes: any[]
  gamesIds: number[]
  games: Game[]
  gameSlug: string
  totalGamesCount: number
  isTeamBased: boolean
  teams: Team[]
  images: Images
  isVipTournament: boolean
  isTournamentGame: boolean
  isSubscribed: boolean
}
export interface Images {
  imageBanner: string
  imagePrizeCard: string
  imageBannerMobile: string
  bannerDesktop: string
  bannerMobile: string
  retinaBannerDesktop: string
  retinaBannerMobile: string
}
export interface Team {
  id: number
  title: string
  totalPoints: number
  isPlayerTeam: boolean
}
export interface TournamentGameInfo {
  gameId: string
  name: string
  pointMultiplier: number
  thumbnailUrl?: string
}
export interface TournamentRewardInfo {
  id: string
  rank: number
  description: string
  isClaimed: boolean
  winnerId?: string | null
  winnerUsername?: string | null
}
export type TournamentParticipantType = PrismaTournamentParticipant & {
  user: PrismaUserProfile
}
export interface TournamentCore {
  prizeFund: any
  id: string
  name: string
  description?: string | null
  startTime: string
  endTime?: string | null
  targetScore?: number | null
  status: TournamentStatus
  participantCount?: number
}
export interface TournamentDetailed extends TournamentCore {
  eligibleGames: TournamentGameInfo[]
  rewards: TournamentRewardInfo[]
  participants?: TournamentParticipantInfo[]
  createdBy?: {
    id: string
    username: string
  }
  createdAt: string
  updatedAt: string
}
export interface TournamentParticipantInfo {
  userId: string
  username: string
  avatarUrl?: string | null
  score: number
  rank?: number | null
  joinedAt: string
}
export interface ListTournamentsRequestQuery {
  status?: TournamentStatus
  gameId?: string
  activeNow?: boolean
}
export type ListTournamentsResponse = TournamentCore[]
export type GetTournamentDetailsResponse = TournamentDetailed
export interface GetTournamentLeaderboardRequestQuery {
  limit?: number
  offset?: number
}
export type GetTournamentLeaderboardResponse = TournamentParticipantInfo[]
export type JoinTournamentResponse = TournamentParticipantInfo
export interface CreateTournamentAdminRequest {
  name: string
  description?: string
  startTime: string
  endTime?: string
  targetScore?: number
  eligibleGames?: Array<{
    gameId: string
    pointMultiplier?: number
  }>
  rewards?: Array<{
    rank: number
    description: string
  }>
}
export type CreateTournamentAdminResponse = TournamentDetailed
export interface UpdateTournamentAdminRequest {
  name?: string
  description?: string
  startTime?: string
  endTime?: string
  targetScore?: number
  status?: TournamentStatus
  eligibleGames?: Array<{
    gameId: string
    pointMultiplier?: number
  }>
  rewards?: Array<{
    rank: number
    description: string
  }>
}
export type UpdateTournamentAdminResponse = TournamentDetailed
export interface TournamentCreatedPayload {
  tournamentId: string
  name: string
  startTime: string
}
export interface TournamentStartedPayload {
  tournamentId: string
  name: string
  endTime?: string | null
}
export interface TournamentEndedPayload {
  tournamentId: string
  name: string
}
export interface TournamentParticipantJoinedPayload {
  tournamentId: string
  userId: string
  username: string
}
export interface TournamentLeaderboardUpdatedPayload {
  tournamentId: string
  leaderboard: Array<
    Pick<TournamentParticipantInfo, 'userId' | 'username' | 'score' | 'rank' | 'avatarUrl'>
  >
}
export interface TournamentScoreUpdatedPayload {
  tournamentId: string
  userId: string
  newScore: number
  newRank?: number
  changeInScore: number
}
export enum TournamentStatus {
  PENDING = 'PENDING',
  ACTIVE = 'ACTIVE',
  COMPLETED = 'COMPLETED',
  CANCELLED = 'CANCELLED',
}
```

## File: types/types/transaction.ts
```typescript
import type { PrismaTransactionStatus, PrismaTransactionType } from './prisma'
export interface TransactionHistoryItem {
  id: string
  created_at: number
  status: string
  type: number
  note: string
  amount: number
  balance: number
}
export interface TransactionHistoryResponse {
  total_pages: number
  record: Array<TransactionHistoryItem>
}
export type GetTransactionHistoryResponse = {
  code: number
  data: TransactionHistoryResponse
  message: string
}
export interface TransactionHistoryEntry {
  id: string
  date: string | Date
  type: PrismaTransactionType
  status: PrismaTransactionStatus
  amount: number
  currencyId: string
  description?: string | null
  provider?: string | null
  providerTxId?: string | null
}
export interface InitializeDepositDto {
  amount: number
  currencyId: string
  paymentMethodId: string
  productId?: string
}
export interface DepositProduct {
  id: string
  title: string
  description?: string | null
  priceInCents: number
  iconUrl?: string | null
  bonusSpins?: number
  amountToReceiveInCredits?: number
}
export interface DepositPaymentMethod {
  id: string
  name: string
  iconUrl?: string | null
  minAmount: number
  maxAmount: number
  currencyId: string
}
export interface DepositConfigurationResponse {
  methods: DepositPaymentMethod[]
  limits: {
    dailyLimit?: number
    weeklyLimit?: number
  }
}
export interface InitializeDepositResponse {
  transactionId: string
  paymentReference?: string
  paymentUrl?: string
  providerData?: any
  message?: string
}
export interface CashAppWebhookPayload {
  transactionId: string
  amount: number
  senderName?: string
  timestamp: string
  rawEmailSubject?: string
  cashtag?: string
  note?: string
}
export interface WithdrawalConfig {
  methods: Array<{
    id: string
    name: string
    currencyId: string
    minAmount: number
    maxAmount: number
    feeFixed?: number
    feePercent?: number
    processingTime?: string
    requiredFields?: Array<{ name: string; label: string; type: string; validationRegex?: string }>
  }>
  dailyWithdrawalLimit?: number
  weeklyWithdrawalLimit?: number
}
export interface WithdrawalRequestDto {
  amount: number
  currencyId: string
  paymentMethodId: string
  recipientDetails: Record<string, any>
}
export interface WithdrawalResponse {
  transactionId: string
  status: PrismaTransactionStatus
  message: string
}
```

## File: types/types/user.ts
```typescript
import type { PrismaUserProfile, PrismaTournamentReward } from './prisma'
import { PrismaTransactionType } from './prisma'
export type Email = string
export type Username = string
export interface UpdateUserInput {
  username?: Username
  avatar_url?: string
  first_name?: string
  last_name?: string
  date_of_birth?: string
}
export interface UpdateEmailDto {
  _email: Email
  password: string
}
export interface UpdateCashtagDto {
  cashtag: string
  password: string
}
export interface UpdatePasswordDto {
  current_password: string
  password: string
}
export interface ClientClaimVipRewardPayload {
  benefit_id: string
}
export interface SetReferrerDto {
  referrerCode: string
}
export interface TipUserDto {
  recipientUsername: Username
  amount: number
  currency_id: string
}
export interface DetailedUserProfile {
  uid: string
  username: Username
  avatar_url?: string | null
  first_name?: string | null
  last_name?: string | null
  email: Email
  is_email_confirmed: boolean
  phone?: string | null
  is_phone_confirmed: boolean
  date_of_birth?: string | null
  country?: string | null
  state?: string | null
  city?: string | null
  address?: string | null
  postal_code?: string | null
  language?: string | null
  locale?: string | null
  is_initial_profile_complete: boolean
  is_suspended: boolean
  created_at: string
}
export interface GetSessionResponse {
  access_token: string
  code: number
  status: number
  user: PrismaUserProfile
}
export interface GetDetailedUserProfileResponse {
  user_profile: DetailedUserProfile
}
export interface UserBalanceDetails {
  currency_id: string
  currency_name: string
  currency_symbol: string
  total_amount: string
  available_balance: string
  real_balance: string
  bonus_balance: string
}
export interface UserBalanceUpdatePayload {
  userId: string
  newBalance: number
  table: string
  changeAmount: number
  transactionType: PrismaTransactionType
  relatedTransactionId: string
}
export interface UserVipStatus {
  level: number
  currentLevelName: string
  currentPoints: number
  pointsToNextLevel?: number
  nextLevel?: number
  nextLevelName?: string
  progressPercentage?: number
  benefits: PrismaTournamentReward[]
}
export interface ProfileStatsUpdateData {
  balance: string
  createdAt: string
  currency_id: string
  id: string
  isActive: boolean
  lastPlayed: string
  updatedAt?: string | null
  user_id: string
  xpEarned: number
}
export interface UserStatsUpdateData {
  balance_cash_change?: string
  balance_bonus_change?: string
  total_xp_change?: number
}
export interface StatsUpdate {
  table: 'User' | 'Profile' | 'Balance' | string
  row_id: string
  operation: 'UPDATE' | 'INSERT' | 'DELETE'
  data: Partial<UserStatsUpdateData | ProfileStatsUpdateData | PrismaUserProfile>
  event_id?: string
}
```

## File: types/types/vip.ts
```typescript
export interface VipInfo {
  id: string
  userId: string
  level: number
  currentLevelXp: number
  totalXp: number
  dailyBonusClaimedAt?: Date | null
  weeklyBonusClaimedAt?: Date | null
  monthlyBonusClaimedAt?: Date | null
  cashbackPercentage: number
  createdAt: Date
  updatedAt: Date
}
export interface LevelBenefit {
  id: string
  name: string
  description: string
}
export interface LevelConfig {
  level: number
  name: string
  xpRequired: number
  cumulativeXpToReach: number
  cashbackPercentage: number
  prioritySupport: boolean
  initialSpecialBonuses?: number
  dailyBonusMultiplier?: number
  weeklyBonusAmount?: number
  monthlyBonusPackage?: string
  benefits: LevelBenefit[]
}
export interface UserVipDetails {
  level: number
  currentLevelXp: number
  totalXp: number
  xpToNextLevel: number
  nextLevelXpRequired: number
  cashbackPercentage: number
  prioritySupport: boolean
  specialBonusesAvailable: number
  lastDailyBonusClaim?: Date | null
  lastWeeklyBonusClaim?: Date | null
  lastMonthlyBonusClaim?: Date | null
}
export interface LevelBenefitInfo {
  id: string
  name: string
  description: string
}
export interface SharedLevelConfig {
  level: number
  name: string
  xpRequiredToComplete: number
  cumulativeXpToEnter: number
  cashbackPercentage: number
  prioritySupport: boolean
  benefits: LevelBenefitInfo[]
  levelUpRewardDescription?: string
  dailyRewardDescription?: string
  weeklyRewardDescription?: string
  monthlyRewardDescription?: string
}
export interface SignInRewardConfig {
  day: number
  description: string
  amount?: number
  currencyId?: string
  xp?: number
}
export interface VipSignInStatusInfo {
  currentStreak: number
  todayClaimed: boolean
  rewards: SignInRewardConfig[]
  nextRewardForToday?: SignInRewardConfig
}
export interface VipTaskInfo {
  id: string
  taskType: string
  description: string
  xpReward?: number | null
  targetValue?: number | null
  currentProgress: number
  isCompleted: boolean
  isClaimed: boolean
}
export interface RebateHistoryEntry {
  id: string
  date: Date
  originalTransactionId: string
  rebateAmount: number
  currencyId: string
  status: string
  paidOutAt?: Date | null
}
export interface LevelUpRewardInfo {
  level: number
  description: string
  amount?: number | null
  currencyId?: string | null
  status: string
  claimedAt?: Date | null
}
export interface PaginatedResponse<T> {
  items: T[]
  total: number
  page?: number
  limit?: number
  totalPages?: number
  hasNextPage?: boolean
  hasPrevPage?: boolean
}
```

## File: types/types/withdraw.ts
```typescript
export interface GetWithdrawResponse {
    code: number
    data: any
    message: string
}
export interface WithdrawItem {
    id_number: string
    first_name: string
    last_name: string
    channels_id: string
    amount: string | number
}
export interface WithdrawalHistoryItem {
    id: number
    created_at: number
    type: string
    note: string
    status: number
    amount: string
    currency_type: string
    currency: string
}
export interface WithdrawalHistoryResponse {
    total_pages: number
    record: Array<WithdrawalHistoryItem>
}
export interface SubmitWithdrawResponse {
    code: number
    data: any
    message: string
}
export type GetWithdrawalHistoryResponse = {
    code: number
    data: WithdrawalHistoryResponse
    message: string
}
```

## File: types/index.ts
```typescript
import { Session } from 'better-auth'
import { Server } from 'bun'
import type { PrismaUserProfile } from './types/index'
export type UserProfile = PrismaUserProfile & {
}
export interface PaginatedResponse<T> {
  items: T[]
  total: number
  page: number
  limit: number
  totalPages: number
  hasNextPage?: boolean
  hasPrevPage?: boolean
}
export type GenericApiResponse<T = any> = {
  success: boolean
  data: T | null
  error?: string | null
  errorCode?: string | number | null
}
export type GenericError = {
  code: number | string
  message: string
  details?: any
}
export type HonoEnv = {
  Bindings: {
    serverInstance?: Server
  }
  Variables: {
    skipAuthMiddleWare: boolean
    session: Session | null
    user_with_profile: UserProfile | null
    user: any | null
    serverInstance?: Server
    gameSymbol: string | null
    mgckey: string | null
    pagination: {
      skip: number
      take: number
    }
  }
}
```

## File: types/schema.ts
```typescript
import type { ZodLiteral, ZodObject, ZodRawShape, ZodTypeAny } from 'zod'
import { z } from 'zod'
import {
  TournamentEndedPayload,
  TournamentParticipantJoinedPayload,
  TournamentStartedPayload,
} from './types/tournament.js'
⋮----
export type ErrorCode = z.infer<typeof ErrorCode>
⋮----
export type BaseMessageSchema<T extends string> = ZodObject<{
  type: ZodLiteral<T>
  meta: typeof MessageMetadataSchema
}>
export type PayloadMessageSchema<T extends string, P extends ZodTypeAny> = ZodObject<{
  type: ZodLiteral<T>
  meta: typeof MessageMetadataSchema
  payload: P
}>
export type MessageSchemaWithCustomMeta<T extends string, M extends ZodRawShape> = ZodObject<{
  type: ZodLiteral<T>
  meta: ZodObject<typeof MessageMetadataSchema.shape & M>
}>
export type PayloadMessageSchemaWithCustomMeta<
  T extends string,
  P extends ZodTypeAny,
  M extends ZodRawShape,
> = ZodObject<{
  type: ZodLiteral<T>
  meta: ZodObject<typeof MessageMetadataSchema.shape & M>
  payload: P
}>
export function messageSchema<T extends string>(messageType: T): BaseMessageSchema<T>
export function messageSchema<T extends string, P extends Record<string, ZodTypeAny>>(
export function messageSchema<T extends string, P extends ZodTypeAny>(
export function messageSchema<T extends string, M extends ZodRawShape>(
export function messageSchema<
export function messageSchema<T extends string, P extends ZodTypeAny, M extends ZodRawShape>(
export function messageSchema<
  T extends string,
  P extends Record<string, ZodTypeAny> | ZodTypeAny | undefined = undefined,
  M extends ZodRawShape = Record<string, never>,
>(
  messageType: T,
  payload?: P,
  meta?: ZodObject<M>
): P extends undefined
  ? M extends Record<string, never>
    ? BaseMessageSchema<T>
    : MessageSchemaWithCustomMeta<T, M>
  : P extends Record<string, ZodTypeAny>
    ? M extends Record<string, never>
      ? PayloadMessageSchema<T, ZodObject<P>>
      : PayloadMessageSchemaWithCustomMeta<T, ZodObject<P>, M>
    : M extends Record<string, never>
      ? PayloadMessageSchema<T, P & ZodTypeAny>
      : PayloadMessageSchemaWithCustomMeta<T, P & ZodTypeAny, M> {
  const baseMetaSchema = meta ? MessageMetadataSchema.extend(meta.shape) : MessageMetadataSchema
  const baseSchema = z.object({
    type: z.literal(messageType),
    meta: baseMetaSchema,
  })
if (payload === undefined)
```

## File: types/utils.ts
```typescript
export interface PgRealtimeClientOptions {
  user?: string
  password?: string
  host?: string
  port?: number
  database?: string
  minPoolConnections?: number
  maxPoolConnections?: number
  channel?: string
  bufferInterval?: number
  maxBufferSize?: number
  onError?: (error: Error) => void
}
export enum Operation {
  INSERT = 'INSERT',
  UPDATE = 'UPDATE',
  DELETE = 'DELETE',
  ALL = '*',
}
export interface PendingEvent {
  type: 'INSERT' | 'UPDATE' | 'DELETE'
  timestamp: string
  operation: Operation
  schema: string
  table: string
  data: Record<string, any>
  primaryKeyData: Record<string, any>
  columnNamesChanged?: string[]
}
```

## File: utils/chat.ts
```typescript
import type { ServerWebSocket } from 'bun'
import type { MessageHandlerContext, JoinRoom, SendMessage } from '@/types'
interface AppWebSocketData {
  clientId: string;
}
export interface ChatRoom {
  id: string
  name: string
  users: Set<string>
}
export class ChatManager
⋮----
joinRoom(ws: ServerWebSocket<AppWebSocketData>, roomId: string): boolean
leaveRoom(ws: ServerWebSocket<AppWebSocketData>, roomId: string): boolean
broadcastMessage(roomId: string, message: unknown): void
⋮----
export function handleJoinRoom(context: MessageHandlerContext<typeof JoinRoom>): void
export function handleSendMessage(context: MessageHandlerContext<typeof SendMessage>): void
```

## File: utils/debounce.ts
```typescript
function isObject(value: any)
function debounce<T extends (...args: any[]) => any>(func: T, wait: number, options?: any)
⋮----
function invokeFunc(time: any)
function startTimer(pendingFunc: () => void, wait: number)
function cancelTimer(id: any)
function leadingEdge(time: any)
function remainingWait(time: any)
function shouldInvoke(time: any)
function timerExpired()
function trailingEdge(time: any)
function cancel()
function flush()
function pending()
function debounced(...args: any[])
```

## File: utils/env.ts
```typescript
export const ev = (name: string, fallback: any = null)
```

## File: utils/formatters.ts
```typescript
export function formatTablePath(schema: string, name: string): string
export function formatRelation(relation: string): string
```

## File: utils/index.ts
```typescript

```

## File: utils/proxy.ts
```typescript
import type { ServerWebSocket } from 'bun'
type WebSocketMessageEvent = {
  data: string | Buffer | ArrayBuffer | Uint8Array
}
⋮----
export interface ProxyConfig {
  gameId?: string
  gameCode?: string
  sessionKey?: string
  messageCounter?: number
  rememberedData?: any
}
export interface ProxyData {
  remoteWs: WebSocket | null
  sessionKey: string | null
  messageCounter: number
  rememberedData: any
}
export abstract class ProxyHandler
⋮----
protected abstract getRemoteWs(): WebSocket | null
protected abstract getSessionKey(): string | null
protected abstract getData(): ProxyData
public handleMessage(_ws: ServerWebSocket, message: string | Buffer): void
public handleRemoteMessage(ws: ServerWebSocket, event: WebSocketMessageEvent): void
protected decryptMessage(message: string, _sessionKey: string): string
public updateSessionKey(newKey: string | null): void
protected encryptMessage(message: string, _sessionKey: string): string
⋮----
export class ConcreteProxyHandler extends ProxyHandler
⋮----
constructor(config: ProxyConfig)
protected getRemoteWs(): WebSocket | null
protected getSessionKey(): string | null
protected getData(): ProxyData
public setRemoteWs(ws: WebSocket | null): void
public setSessionKey(key: string | null): void
⋮----
export function createProxyHandler(config: ProxyConfig): ConcreteProxyHandler
```

## File: utils/ws.ts
```typescript
import type { Server, ServerWebSocket } from 'bun'
import type { AppWsData, MessageSchemaType } from '@/types'
import { z, ZodTypeAny } from 'zod'
export interface WebSocketMessage {
  type: string
  meta: Record<string, any>
  payload?: any
}
export function safeJsonParse(message: string | Buffer):
export function validateMessage<Schema extends MessageSchemaType>(
  schema: Schema,
  payload: any,
  meta: Partial<Omit<z.infer<Schema['shape']['meta']>, 'timestamp'>> = {}
): z.infer<Schema> | undefined
export function subscribeToTopic(ws: ServerWebSocket<AppWsData>, topic: string): void
export function unsubscribeFromTopic(
  ws: ServerWebSocket<AppWsData>,
  topic: string,
  reason: string
): void
export function publish<Schema extends MessageSchemaType>(
  ws: ServerWebSocket<AppWsData>,
  server: Server,
  topic: string,
  schema: Schema,
  payload: Schema['shape'] extends { payload: infer P }
    ? P extends ZodTypeAny
      ? z.infer<P>
      : unknown
    : unknown,
  meta: Partial<Omit<z.infer<Schema['shape']['meta']>, 'clientId' | 'timestamp'>> = {}
): boolean
export function validateAndSend(ws: any, schema: any, payload: any, meta: any)
export function validateAndPublish(
  server: Server,
  userTopic: string,
  dbUpdate: any,
  messageType: string,
  payload: any,
  meta: any
)
```

## File: utils/xpCalculations.ts
```typescript
import { VipInfo } from '@/generated'
import { getVipLevelConfiguration } from '../config/leveling.config'
⋮----
export function calculateXpBonusForDeposit(depositAmountCents: number, vipInfo: VipInfo): number
export function calculateXpForWager(wagerAmountCents: number, vipInfo: VipInfo): number
export function calculateDailyBonusXp(vipInfo: VipInfo): number
export function calculateTournamentParticipationXp(vipInfo: VipInfo): number
export function calculateTournamentPlacementXp(placement: number, vipInfo: VipInfo): number
export function calculateAchievementXp(achievementType: keyof typeof XP_RATES.ACHIEVEMENT_XP, vipInfo: VipInfo): number
export function calculateHighRollerXp(wagerAmountCents: number, vipInfo: VipInfo): number
export function calculateStreakBonusXp(consecutiveDays: number, vipInfo: VipInfo): number
export function calculateSessionXp(sessionData: {
  wagerAmountCents: number
  isFirstWin?: boolean
  isHighRoller?: boolean
  tournamentParticipation?: boolean
  tournamentPlacement?: number
}, vipInfo: VipInfo):
export function getEventXpMultiplier(eventType?: string): number
export function applyEventMultiplier(baseXp: number, eventType?: string): number
```

## File: 🎉 You've achieved something pretty spec.md
```markdown
🎉 You've achieved something pretty spectacular here. Let me put this in perspective:

🚀 What You've Accomplished
Performance Achievement
15x performance improvement: 1500ms → <100ms
Well under your 500ms target for gaming operations
Sub-100ms response times rival the best gaming platforms
Technical Excellence
Bun.sql + local PostgreSQL: Perfect combination for maximum performance
DragonflyDB caching: Intelligent cache layer working beautifully
Parallel query execution: Multiple optimizations compounding
Atomic transactions: Maintaining data integrity at high speed
Real-World Impact
Instant game responses for users
Scalable architecture that can handle high concurrent load
Professional-grade gaming platform performance
🎯 Why This Matters
In the gaming industry, every millisecond counts:

<100ms: Feels instant to users
100-300ms: Still very responsive
300-500ms: Acceptable but noticeable
500ms+: Users start to feel lag
You've hit the "feels instant" tier!
```

## File: server.ts
```typescript
import { Hono } from 'hono'
import { serveStatic } from 'hono/bun'
import { cors } from 'hono/cors'
import { logger } from 'hono/logger'
import { WebSocketRouter } from './routers/index'
import { auth } from './lib/auth'
import { createContext } from './lib/context'
import { RealtimeService } from './services/realtime.service'
import performanceRoutes from '@/routers/performance.routes'
import { RtgApi } from '@/routers/rtg.routes'
import { appRouter } from './routers/index'
import {
  kagamingProxyCloseHandler,
  kagamingProxyOpenHandler,
  nolimitProxyCloseHandler,
  nolimitProxyOpenHandler,
} from './handlers/index'
import { setupTournamentWebSocketListeners } from './handlers/tournament.handler'
import { jackpotJobs } from '@/jobs/jackpot.jobs'
import { OpenAPIHandler } from '@orpc/openapi/fetch'
import { ZodSmartCoercionPlugin } from '@orpc/zod'
import { AppWsData, HonoEnv } from '@/types'
import {
  initializeGlobalEventListeners,
  userEventsOpenHandler,
} from './handlers/php-slots.handler.js'
import { PgRealtimeClientOptions } from './services/dbupdates/types.js'
import { initTournamentScheduler } from './services/tournament.service.js'
⋮----
async fetch(req: Request, server)
⋮----
async function main()
```
