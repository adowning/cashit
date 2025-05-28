import { createStore, defineItemType, defineModule, definePlugin, createModule } from '@rstore/vue'
import { PrismaTournament, PrismaTransaction, UserProfile, VipInfo } from 'shared'
import { orpc } from '@/utils/orpc.client'


declare module '@rstore/vue' {
  export interface CustomModelMeta {
    path: string
      totalPage?: number
}
}
export default definePlugin({
  name: 'orpc',
  //   scopeId: 'main-backend',
  setup({ hook }) {
    hook('fetchMany', async (payload) => {
    
    const orpcClient = orpc.getClient()
      orpcClient.

      // This will only be called for models with the scopeId 'main-backend'
    })
  },
})

interface UserProfileModel extends UserProfile {}
const userModel = defineItemType<UserProfileModel>().model({
  name: 'users',
  meta: {
    path: 'users',
  },
  fields: {
    createdAt: {
      parse: (value) => new Date(value),
      serialize: (value) => value.toISOString(),
    },
    isActive: {
      parse: (value) => Boolean(value),
      serialize: (value) => Number(value),
    },
  },
  relations: {
    transcations: {
      to: {
        transcations: {
          on: 'userProfileId', // Post.userId
          eq: 'id', // User.id
        },
      },
      many: true,
    },
  },
  // other properties...
})




export const useAuth = defineModule(() => {
  const store = useStore()

  const { state, resolve, onResolve, defineMutation } = createModule(store, {
    name: 'auth',
    state: {
      // Create some state here
      currentUserKey: null as string | null,
      isAuthenticated: false as boolean ,
        accessToken: null as string | null,
        refreshToken: null as string | null,
        user: null as UserProfileModel | null,

    },
  })

  return resolve({
    // Expose things here
    state,  onResolve, defineMutation 
  })
})
// interface TransactionModel extends PrismaTransaction {}
// const transactionModel = defineItemType<Tra  nsactionModel>().model({
//   name: 'transactions',
//   // other properties...
// })
// interface TournamentModel extends PrismaTournament {}
// const tournamentModel = defineItemType<TournamentModel>().model({
//   name: 'tournamects',
//   // other properties...
// })
// interface VipModel extends VipInfo {}
// const vipModel = defineItemType<VipModel>().model({
//   name: 'vipinfos',
//   // other properties...
// })
// const store = await createStore({
//   models: [userModel, transactionModel, tournamentModel, vipModel],
//   plugins: [],
// })
