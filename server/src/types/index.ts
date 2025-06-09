export * from './types/index' // This exports all types from your ./types folder
import { Session } from 'better-auth'
import { Server } from 'bun'

// Import the User type (and others) defined within the shared package itself.
// This User type should be based on your Prisma schema, as found in ./types/prisma.ts

// import type { PrismaUserProfile , PrismaSettings, PrismaVipInfo } from './types/index'
import type { PrismaUserProfile } from './types/index'

// Remove the direct import from the server's generated files:
// import type { UserPrismaProfile as PrismaUserPrismaProfile } from '../../server/prisma/generated';

// Define UserPrismaProfile using the User type from shared/src/types/prisma.ts
// The 'User' type in 'ai/shared/src/types/prisma.ts' already includes
// optional profile, settings, and vipInfo relations.
export type UserProfile = PrismaUserProfile & {
  // You can still augment SharedUserType here if there are additional properties
  // or if you want to ensure certain optional properties from SharedUserType are non-optional here.
  // However, looking at your current 'ai/shared/src/types/prisma.ts',
  // UserPrismaProfile might just be an alias for SharedUserType if no further modifications are needed.
  // For example, if SharedUserType already has:
  //   profile?: PrismaProfile | null;
  //   settings?: PrismaSettings | null;
  //   vipInfo?: PrismaVipInfo | null;
  // Then the explicit & { profile: PrismaProfile | null; ... } below might be redundant,
  // unless you want to make them non-optional or add new fields.
  // Assuming PrismaProfile, PrismaSettings, PrismaVipInfo are already correctly typed in SharedUserType:
  // profile: PrismaProfile | null // This is likely already optional in SharedUserType
  // settings: PrismaSettings | null // This is likely already optional in SharedUserType
  // vipInfo: PrismaVipInfo | null // This is likely already optional in SharedUserType
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
    serverInstance?: Server // Make serverInstance known to Hono's Env
  }
  Variables: {
    skipAuthMiddleWare: boolean
    session: Session | null
    user_with_profile: UserProfile | null
    user: any | null
    serverInstance?: Server // Make serverInstance known for c.set/c.get
    gameSymbol: string | null
    mgckey: string | null
    pagination: {
      skip: number
      take: number
    }
  }
}
