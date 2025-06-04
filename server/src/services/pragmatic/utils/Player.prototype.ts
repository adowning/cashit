// class PragPlayer {
//   currentApi: null
//   lastPattern: null
//   totalBet: number
//   txnID: null
//   constructor() {
//     this.currentApi = null
//     this.lastPattern = null
//     this.totalBet = 0
//     this.txnID = null
//   }

//   HandleInit(param) {
//     this.currentApi = apiManager.InitApi(this, param)
//     this.lastPattern = this.currentApi
//   }

//   public async HandleSpin(param, user) {
//     const prevGameMode = machine.currentGame

//     if (this.totalBet > 0) {
//       this.txnID = new MD5()
//         .update(agentCode + userCode + gameCode + Math.floor(Math.random() * 1000000) + Date.now())
//         .digest('hex')

//       if (param.pur || param.fsp) {
//         if (purchaseCallPattern.totalBet && purchaseCallPattern.totalBet != virtualBet) {
//           const call = await app.db.Call.findOne({
//             where: {
//               agentCode: agentCode,
//               userCode: userCode,
//               gameCode: gameCode,
//               type: 2,
//               callStatus: 'CALL_WAITING',
//             },
//           })
//           call = { id: call.id, type: 2, status: 2 }
//           await call.update({ summedMoney: 0, callStatus: 'CALL_FAIL' })
//           purchaseCallPattern = {}
//           callHistId = -1
//           callStatus = 'NOCALL'
//         }
//         if (Object.keys(purchaseCallPattern).length) {
//           const call = await app.db.Call.findOne({
//             where: {
//               agentCode: agentCode,
//               userCode: userCode,
//               gameCode: gameCode,
//               type: 2,
//               callStatus: 'CALL_WAITING',
//             },
//           })
//           call = { id: call.id, type: 2, status: 1 }
//           viewCache = purchaseCallPattern
//           purchaseCallPattern = {}
//           callHistId = call.id
//           callStatus = 'CALL_START'
//         } else {
//           let missedMoney = (totalDebit * user.targetRtp) / 100 - totalCredit
//           logger.info(
//             `[               ] (${userCode}, ${gameCode})       : ${Math.floor(missedMoney)}`
//           )
//           if (missedMoney <= 0) {
//             logger.info(
//               `[                                      ] (${userCode}, ${gameCode})           ${rtpConfig.BuyBonusDefaultMulti}                    `
//             )
//             missedMoney = virtualBet * rtpConfig.BuyBonusDefaultMulti
//           } else if (missedMoney > virtualBet * rtpConfig.BuyBonusDefaultMulti * 3) {
//             logger.info(
//               `[                                      ] (${userCode}, ${gameCode})                          * 3 = ${rtpConfig.BuyBonusDefaultMulti * 3}                    `
//             )
//             missedMoney = virtualBet * rtpConfig.BuyBonusDefaultMulti * 3
//           }
//           viewCache = loadNextBuyPattern(missedMoney)
//           callHistId = -1
//           callStatus = 'NOCALL'
//         }
//       } else {
//         if (callPattern.totalBet && callPattern.totalBet != virtualBet) {
//           const call = await app.db.Call.findOne({ where: { id: callHistId } })
//           call = { id: call.id, type: 1, status: 2 }
//           await call.update({ summedMoney: 0, callStatus: 'CALL_FAIL' })
//           callPattern = {}
//           callHistId = -1
//           callStatus = 'NOCALL'
//         }
//         if (Object.keys(callPattern).length && callHistId > 0) {
//           viewCache = callPattern
//           const call = await app.db.Call.findOne({ where: { id: callHistId } })
//           if (call) {
//             call = { id: call.id, type: 1, status: 1 }
//             callStatus = 'CALL_START'
//             callPattern = {}
//           } else {
//             logger.info(
//               `                                              >>>>>>>>>> ${agentCode}, ${userCode}, ${gameCode}`
//             )
//             callHistId = -1
//             callPattern = {}
//           }
//         } else {
//           viewCache = loadNextPattern(user)
//           callStatus = 'NOCALL'
//         }
//       }

//       while (!viewCache) {
//         //
//         logHist(
//           `[                ] length == 0, HandleSpin                ,                                                            .`
//         )
//         await CheckPatternEnough(this, user, param)
//         viewCache = loadNextPattern(user)
//       }
//       if (viewCache.win != 0) {
//         let aa = 0
//       }
//       viewHistory.push({
//         balance: balance - this.totalBet + viewCache.win, // TODO
//         win: viewCache.win,
//         type: viewCache.type,
//         isCall: viewCache.isCall,
//       })
//       viewHistory.length > 300 ? viewHistory.shift() : 0
//     }

//     balance -= this.totalBet
//     machine.SpinFromPattern(this, param)

//     this.currentApi = apiManager.GameApi(this, prevGameMode, param)
//     this.lastPattern = this.currentApi
//   }
// }
