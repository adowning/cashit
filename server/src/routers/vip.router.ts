import { InferRouterOutputs } from '@orpc/server'
import { VipInfo } from 'shared/dist'
import type { ExtendedPrismaClient } from '../../prisma' // Import Prisma namespace for input types
import prisma from '../../prisma/index' // Your extended Prisma client
import { protectedProcedure } from '../lib/orpc'

const _prisma: ExtendedPrismaClient = prisma

export const vipRouter = {
  getMyVipInfo: protectedProcedure.handler(async ({ context }): Promise<VipInfo> => {
    const vipInfo = await _prisma.vipInfo.findUnique({
      where: { userId: context.session.user.id },
    })
    // console.log(vipInfo)
    if (!vipInfo) {
      throw new Error('vipInfo not found for authenticated user.')
    }
    return vipInfo
  }),
}
export type Outputs = InferRouterOutputs<typeof vipRouter>
