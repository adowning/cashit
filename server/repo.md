This file is a merged representation of a subset of the codebase, containing files not matching ignore patterns, combined into a single document by Repomix.
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

## Notes
- Some files may have been excluded based on .gitignore rules and Repomix's configuration
- Binary files are not included in this packed representation. Please refer to the Repository Structure section for a complete list of file paths, including binary files
- Files matching these patterns are excluded: *.json, ./public, ./prisma, ./cashapp/, node_modules/, ./dist, ./docker, ./performance-logs
- Files matching patterns in .gitignore are excluded
- Files matching default ignore patterns are excluded
- Code comments have been removed from supported file types
- Empty lines have been removed from all files
- Content has been compressed - code blocks are separated by ⋮---- delimiter
- Files are sorted by Git change count (files with more changes are at the bottom)

# Directory Structure
```
src/
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
.env.example
.gitignore
```

# Files

## File: src/config/json/rtg-settings.result.json
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

## File: src/config/json/rtg-spin-lose.result.json
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

## File: src/config/leveling.config.ts
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

## File: src/config/prisma.config.ts
```typescript
import path from 'node:path'
```

## File: src/handlers/chat.handler.ts
```typescript
import { publish } from '@/utils'
import { JoinRoom, MessageHandlerContext, NewMessage, SendMessage, UserJoined } from 'shared'
export function handleJoinRoom(context: MessageHandlerContext<typeof JoinRoom>)
export function handleSendMessage(context: MessageHandlerContext<typeof SendMessage>)
```

## File: src/handlers/heartbeat.handler.ts
```typescript
import { MessageHandlerContext, Ping, Pong } from 'shared'
export function handlePing(context: MessageHandlerContext<typeof Ping>)
```

## File: src/handlers/index.ts
```typescript

```

## File: src/handlers/kagaming-proxy.handler.ts
```typescript
import { BufferSource, ServerWebSocket } from 'bun'
import { CloseHandlerContext, OpenHandlerContext, UserProfile, WsData } from 'shared'
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

## File: src/handlers/nolimit-proxy.handler.ts
```typescript
import { WsData, OpenHandlerContext, CloseHandlerContext, UserProfile, AppWsData } from 'shared'
import { ServerWebSocket } from 'bun'
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

## File: src/handlers/php-slots.handler.ts
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
} from 'shared'
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

## File: src/handlers/tournament.handler.ts
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
} from '../../../shared/dist'
⋮----
function formatWebSocketMessage<T>(type: string, payload: T)
export function setupTournamentWebSocketListeners(server: Server)
```

## File: src/jobs/cashapp-watcher.job.ts
```typescript
import { runCashAppPaymentCheckJob } from '@/services/cashapp-payment-processing.service'
⋮----
export class CashAppWatcherJobs
⋮----
private constructor()
public static getInstance(): CashAppWatcherJobs
async startJobs(): Promise<void>
stopJobs(): void
getJobStatus():
```

## File: src/jobs/jackpot.jobs.ts
```typescript
import prisma from '../../prisma/'
import { JackpotService } from '../services/jackpot.service.js'
import { JACKPOT_CONFIG, JackpotUtils } from 'shared'
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

## File: src/lib/auth.ts
```typescript
import { betterAuth } from 'better-auth'
import { prismaAdapter } from 'better-auth/adapters/prisma'
import { username, bearer, createAuthMiddleware } from 'better-auth/plugins'
import prisma from '../../prisma'
```

## File: src/lib/context.ts
```typescript
import { Session } from 'better-auth'
import { BunRequest, ServerWebSocket } from 'bun'
import { UserProfile } from 'shared'
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

## File: src/lib/events.ts
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
} from 'shared'
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

## File: src/lib/orpc.ts
```typescript
import { ORPCError, os } from '@orpc/server'
import type { Context } from './context'
```

## File: src/routers/game.router.ts
```typescript
import {
  PrismaGameBigWinData as GameBigWinData,
  PrismaGameHistoryItem as GameHistoryItem,
  GameSpin,
  LaunchGameResponseDto,
  PaginatedResponse,
  PrismaGameProviderName,
  PrismaGameProvider as SharedGameProvider,
  PrismaGame as SharedPrismaGame,
} from 'shared/dist'
import z from 'zod/v4'
import prisma from '../../prisma/'
import { Prisma, GameCategory as PrismaGameCategoryEnum } from '../../prisma/generated/client'
import { protectedProcedure, publicProcedure } from '../lib/orpc'
⋮----
type GameWithProvider = SharedPrismaGame & {
  gameProvider?: SharedGameProvider | null;
};
const mapPrismaGameToSharedGame = (game: GameWithProvider): SharedPrismaGame =>
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
⋮----
async function processLuckyBets(rawLuckyBetsData: any[]): Promise<LuckyBetInfo[]>
```

## File: src/routers/index.ts
```typescript
import { protectedProcedure, publicProcedure } from '../lib/orpc'
import { vipRouter } from './vip.router'
⋮----
export type AppRouter = typeof appRouter
```

## File: src/routers/jackpot.router.ts
```typescript
import { JackpotUtils, type GetJackpotsResponse, type JackpotDisplayDto } from 'shared'
import z from 'zod/v4'
import { protectedProcedure, publicProcedure } from '../lib/orpc'
import { GameSpinService } from '../services/game-spin.service'
import { JackpotService } from '../services/jackpot.service'
```

## File: src/routers/netent.routes.ts
```typescript
export class NetentGame
⋮----
constructor(request: any)
async http_get(_callback_url: string)
async bridged(request: any): string
process_game(_internal_token: string, _betAmount: number, _winAmount: number, _data_origin: any)
game_event(request: any): string
curl_request(url: string, request: any): string
private get_internal_session(_token: string): any
private get_balance(_token: string): number
private parse_query(_http: string): any
private in_between(_start: string, _end: string, _str: string): string
private build_query(_data_origin: any): string
⋮----
// Implementation here
```

## File: src/routers/netgame.routes.ts
```typescript
import { Context, Hono } from 'hono'
interface DebounceEntry {
  lastCall: number
  timeout?: NodeJS.Timeout
}
class Debouncer
⋮----
isDebounced(key: string): boolean
markCall(key: string): void
⋮----
export class NGApi
⋮----
constructor(app)
private setupRoutes()
private async rtgSettings(c: Context)
private async rtgSpin(c: Context)
private async rtgSpinWithPerformance(c: Context)
private async rtgSpinOptimized(c: Context)
private async rtgSpinCached(c: Context)
```

## File: src/routers/performance.routes.ts
```typescript
import { cacheService } from '@/services/redis.service'
import { Hono } from 'hono'
import { performanceMonitor } from '../services/performance-monitor.service'
```

## File: src/routers/php.routes.ts
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

## File: src/routers/rtg.routes.ts
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

## File: src/routers/socket.router.ts
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
} from 'shared'
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

## File: src/routers/tournament.router.ts
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
} from 'shared/dist'
import z from 'zod/v4'
import prisma from '../../prisma/index'
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

## File: src/routers/transaction.ts
```typescript
import { type } from '@orpc/server'
import { Product, TransactionType } from 'prisma/generated'
import {
  DepositHistoryItem,
  DepositHistoryResponse,
  DepositProduct,
  GetOperatorDataResponse,
  OperatorData,
} from 'shared'
import z from 'zod/v4'
import type { ExtendedPrismaClient } from '../../prisma'
import prisma from '../../prisma/index'
import { protectedProcedure } from '../lib/orpc'
⋮----
// currency: tx.currency,
```

## File: src/routers/user.router.ts
```typescript
import { protectedProcedure } from '@/lib/orpc'
import { Prisma } from 'prisma/generated'
import {
  PaginatedResponse as PaginatedResponseType,
  PrismaUserProfile as PrismaUserProfileType,
} from 'shared/dist'
import z from 'zod/v4'
import type { ExtendedPrismaClient } from '../../prisma'
import prisma from '../../prisma/index'
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

## File: src/routers/vip.router.ts
```typescript
import { InferRouterOutputs } from '@orpc/server'
import { VipInfo } from 'shared/dist'
import type { ExtendedPrismaClient } from '../../prisma'
import prisma from '../../prisma/index'
import { protectedProcedure } from '../lib/orpc'
⋮----
export type Outputs = InferRouterOutputs<typeof vipRouter>
```

## File: src/routers/websocket-monitor.router.ts
```typescript
import { Elysia } from 'elysia'
import { WebSocketMonitorService } from '@/services/websocket-monitor.service'
import { z } from 'zod'
```

## File: src/services/dbupdates/config.ts
```typescript

```

## File: src/services/dbupdates/logger.ts
```typescript
import config from './config'
class Logger
⋮----
info(...args: any[])
warn(...args: any[])
error(...args: any[])
```

## File: src/services/dbupdates/table.ts
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

## File: src/services/dbupdates/types.ts
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

## File: src/services/dbupdates/version.ts
```typescript

```

## File: src/services/cashapp-payment-processing.service.ts
```typescript
import prisma from '../../prisma'
import { AppEvents, typedAppEventEmitter } from '../lib/events'
import { TransactionStatus, TransactionType, UserProfile } from '../../prisma/generated/client'
import { ReceivedCashAppPayment, fetchReceivedVendorPayments } from './cashapp.integration'
⋮----
async function findUserForPayment(payment: ReceivedCashAppPayment): Promise<UserProfile | null>
async function processSingleCashAppPayment(payment: ReceivedCashAppPayment): Promise<void>
export async function runCashAppPaymentCheckJob(): Promise<void>
```

## File: src/services/cashapp.integration.ts
```typescript
import { CashAppClient } from 'server/cashapp/lib/cashapp'
⋮----
import path from 'path'
⋮----
export interface VendorDetails {
  customerId: string
  cashtag?: string
  profileToken?: string
}
export interface ReceivedCashAppPayment {
  paymentToken: string
  senderId?: string
  senderCashtag?: string
  amount: {
    amountInCents: number
    currencyCode: string
  }
  note?: string
  createdAt: Date
}
export async function setupAndVerifyVendorCashAppSession(): Promise<VendorDetails | null>
export async function getPersistedVendorDetails(): Promise<VendorDetails | null>
export async function getAuthenticatedVendorClient(): Promise<CashAppClient>
async function getVendorCashAppClient(): Promise<CashAppClient>
export async function fetchReceivedVendorPayments(
  vendorInternalCustomerId: string
): Promise<ReceivedCashAppPayment[]>
export async function initializeVendorSessionInteractive()
```

## File: src/services/game-spin.service.ts
```typescript
import prisma from '../../prisma/'
import { JackpotService } from './jackpot.service'
import { type ProcessJackpotContributionsResponse, type JackpotWinDto } from 'shared'
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

## File: src/services/jackpot-async.service.ts
```typescript
import { SQL } from 'bun'
import { JACKPOT_CONFIG, JackpotUtils } from 'shared'
import { TransactionStatus } from '../../prisma/generated/client'
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

## File: src/services/jackpot.service.ts
```typescript
import {
  JACKPOT_CONFIG,
  JackpotUtils,
  type JackpotContributionDto,
  type JackpotWinDto,
  type ProcessJackpotContributionsRequest,
  type ProcessJackpotContributionsResponse,
} from 'shared'
import prisma from '../../prisma/'
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

## File: src/services/performance-monitor.service.ts
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

## File: src/services/realtime.service.ts
```typescript
import { validateAndPublish } from '@/utils'
import { createClient } from '@supabase/supabase-js'
import type { Server } from 'bun'
import type { UserBalanceUpdatePayloadType } from 'shared'
import { DatabaseUpdate } from 'shared'
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

## File: src/services/redis.service.ts
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

## File: src/services/rtg-jackpot.integration.ts
```typescript
import {
  type ProviderSpinResponseData,
  type RTGSpinRequestDto,
  type RTGSpinResponseDto,
  JackpotUtils,
} from 'shared'
import prisma from '../../prisma/'
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

## File: src/services/rtg-proxy.service.ts
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

## File: src/services/tournament.service.ts
```typescript
import { AppEvents, typedAppEventEmitter } from '@/lib/events'
import { Prisma, Tournament, TournamentStatus, UserProfile } from 'prisma/generated'
import {
  TournamentCreatedPayload,
  TournamentEndedPayload,
  TournamentLeaderboardUpdatedPayload,
  TournamentParticipantJoinedPayload,
  TournamentParticipantType,
  TournamentStartedPayload,
} from 'shared/dist'
import type { ExtendedPrismaClient } from '../../prisma'
import prisma from '../../prisma/index'
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

## File: src/services/transaction.service.ts
```typescript
import {
  Prisma,
  Transaction,
  TransactionStatus,
  TransactionType,
  Wallet,
} from 'prisma/generated/client'
import prisma from '../../prisma/index'
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

## File: src/services/update.service.ts
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

## File: src/services/websocket-monitor.service.ts
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

## File: src/services/xp.service.ts
```typescript
import { VipInfo } from '../../prisma/generated/client'
import prisma from '../../prisma/index'
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

## File: src/utils/chat.ts
```typescript
import type { ServerWebSocket } from 'bun'
import type { MessageHandlerContext, JoinRoom, SendMessage } from 'shared'
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

## File: src/utils/debounce.ts
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

## File: src/utils/env.ts
```typescript
export const ev = (name: string, fallback: any = null)
```

## File: src/utils/formatters.ts
```typescript
export function formatTablePath(schema: string, name: string): string
export function formatRelation(relation: string): string
```

## File: src/utils/index.ts
```typescript

```

## File: src/utils/proxy.ts
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

## File: src/utils/ws.ts
```typescript
import type { Server, ServerWebSocket } from 'bun'
import type { AppWsData, MessageSchemaType } from 'shared'
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

## File: src/utils/xpCalculations.ts
```typescript
import { VipInfo } from 'prisma/generated'
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

## File: src/🎉 You've achieved something pretty spec.md
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

## File: src/server.ts
```typescript
import { Scalar } from '@scalar/hono-api-reference'
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
import { AppWsData, HonoEnv } from 'shared'
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

## File: .env.example
```
DB_USER=
DB_PASSWORD=
DB_HOST=
DB_PORT=
DB_NAME=
DB_LISTEN_CHANNEL=

DATABASE_URL=

CORS_ORIGIN=
BETTER_AUTH_SECRET=
BETTER_AUTH_URL=
```

## File: .gitignore
```
# prod
dist/
/build
/out/

# dev
.yarn/
!.yarn/patches
!.yarn/plugins
!.yarn/releases
!.yarn/versions
.vscode/*
!.vscode/launch.json
!.vscode/*.code-snippets
.idea/workspace.xml
.idea/usage.statistics.xml
.idea/shelf
.wrangler
/.next/
.vercel

# deps
node_modules/
/node_modules
/.pnp
.pnp.*

# env
.env*
.env.production
!.env.example
.dev.vars

# logs
logs/
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*
lerna-debug.log*

# misc
.DS_Store
*.pem

# local db
*.db*

# typescript
*.tsbuildinfo
next-env.d.ts

prisma/generated/
```
