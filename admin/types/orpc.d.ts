import type { ORPCVueQueryUtils } from '@orpc/vue-query'

declare module '@vue/runtime-core' {
  interface ComponentCustomProperties {
    $orpc: ORPCVueQueryUtils
  }
}
