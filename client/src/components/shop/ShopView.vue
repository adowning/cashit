<script setup lang="ts">
  import { onMounted } from 'vue'
  import { DepositScreenName } from '@/stores/transaction.store'
  // import { getApiClient } from '@/sdk/apiClient';
  import { useAuthStore } from '@/stores/auth.store'
  import { useTransactionStore } from '@/stores/transaction.store'
  import type { PrismaProduct as Product } from 'shared/dist'

  // import { eventTypes, useEventsBus } from '@/hooks/events'
  // import { useUserStore } from '@/store/user.store'
  // import type { Product, Shop } from '@/api/v1/client'
  // import type { ShopDetailed } from '@/store/shop.store'
  const eventBus = useEventManager()
  const api = useApiClient()
  const activeName = ref('selectProduct')
  eventBus.on('activeName', (val) => {
    activeName.value = val
    if (val === 'none') close()
  })
  const target = ref()
  const authStore = useAuthStore()
  const depositStore = useTransactionStore()
  const {
    currentUser, // isLoading: authLoading, // If you need to show auth-specific loading in App.vue
    // error: authError, // Auth store errors
  } = storeToRefs(authStore)
  const { dispatchOperatorData, depositScreenName } = depositStore
  // const { dispatchUserTransactionHistory } = depositStore

  // const shop = store.shop
  // const products = store.products
  const closePressed = ref(false)
  const products = ref()
  const pendingTransaction = ref()
  export interface ProductWithSelected extends Product {
    selected: false
  }
  // onMounted(async () => {
  //   //console.log(currentUser.value)
  //   if (currentUser.value === undefined)
  //     return
  //   // currentUser.value = await authStore.fetchUserInfo()
  //   recipient.value = currentUser.value
  //   _cashtag.value = currentUser.value.cashtag as string
  //   recipients.value.push(currentUser.value)
  // })
  const selectedProduct = ref<ProductWithSelected>({
    id: '0  ',
    amountToReceiveInCredits: 0,
    description: '',
    productType: '',
    shopId: '1',
    bonusSpins: 0,
    selected: false,
    title: '',
    url: '',
    priceInCents: 0,
    isPromo: false,
    // createdAt: new Date(),
    bonusCode: '',
    bonusTotalInCredits: 0,
    discountInCents: 0,
    totalDiscountInCents: 0,
    transactions: [],
    bestValue: 0,
    createdAt: new Date(),
    updatedAt: null,
    operator: null,
    iconUrl: '',
    isActive: false,
    transactionId: '',
  })
  // const { isLoading, clients, currentPage, totalPages, getPage } = useClients();

  // $bus.$on(eventTypes.shopSelectProduct, (product: any) => {
  //   //console.log('shopSelectProduct ', product)
  //   selectedProduct.value = product.value
  // })
  // eventBus.on(eventTypes.shopSelectPayment, (payment: string) => {
  //   //console.log('shopSelectPayment ', payment)
  //   paymentMethod.value = payment
  // })
  // $bus.$on(eventTypes.closeShop, () => {
  //   close()
  // })
  // function selectRecipient(val: any) {
  //   recipients.value.forEach((product) => {
  //     product.selected = false
  //   })
  //   recipient.value.id = val.id
  //   //console.log(recipient.value)
  // }
  // const currentUser.value = ref<WUser>()
  // async function close() {
  //     //console.log('tick')
  //     // target!.value!.classList.add(`animate__animated`, 'animate__bounceOut');
  //     eventBus.emit(show_shop, false)
  //     // delay(300)
  //     eventBus.emit(show_bars, true)
  //     // await delay(1000)
  //     // target!.value!.classList.remove(`animate__animated`, 'animate__bounceOut');
  // }
  // const delay = (ms: number) => new Promise((resolve) => setTimeout(resolve, ms))

  async function close() {
    await depositStore.dispatchUserTransactionHistory()

    // console.log('adding fadeout anim and refreshing user')
    target.value?.classList.add(`animate__animated`, 'animate__fadeOut')
    depositStore.shopOpen = false

    // await refreshState()
    setTimeout(() => {
      // console.log('firing shop close')
      eventBus.emit('shopOpen', false)
    }, 500)
  }

  async function cancelBalanceTransactions() {
    await depositStore.dispatchCancelPending()
    // // //console.log(canceled)
    // await loaduser()
    // $bus.$emit(eventTypes.transaction_updated, [])
    // // //console.log(canceled)
    // // eslint-disable-next-line ts/ban-ts-comment
    // @ts-ignore
    // if (typeof canceled === 'number') {
    // balancetransactionsCanceled.value = true;
    activeName.value = 'selectProduct'
    // setTimeout(() => {
    //   // hasPendingBalanceTransaction.value = false
    //   // balancetransactionsCanceled.value = false
    //   close();
    // }, 2000);
    // }
  }
  onMounted(async () => {
    // window.addEventListener('resize', updateScreenWidth)
    // Fetch initial deposit configuration
    await depositStore.dispatchUserTransactionHistory()
    await dispatchOperatorData()
    // await authStore.refreshUser()
    console.log(depositStore.getOperatorData)
    console.log(depositStore.getProducts)
    products.value = depositStore.getOperatorData?.products
    console.log(depositStore.depositHistoryItem)
    for (const item of depositStore.depositHistoryItem.record) {
      console.log(item)
      if (item.status === 'PENDING') {
        activeName.value = 'pendingTransaction'
        pendingTransaction.value = item
      }
    }
  })
  onUnmounted(() => {
    depositStore.shopOpen = false
  })
</script>

<template>
  <div
    ref="target"
    class="animate__animated animate__fadeIn"
    style="
      /* */
      border-radius: 20px;
      padding: 10px;
      width: 100vw;
      margin-top: 50px;
      height: 100vh;
      z-index: 99999999;
      overflow-y: scroll;
    "
  >
    <div
      class="fixed left-0 top-0 flex flex-col items-center justify-start overflow-y-hidden"
      style="
        width: 100vw;
        margin: auto;
        height: 90vh;
        background-repeat: no-repeat;
        border-image: url('/images/common/cell-2.png') 20 20 20 20 fill / 20px 20px 20px 20px;
        padding: 20px 20px 20px 20px;
        max-width: 480px;
        z-index: 99999999;

        background-repeat: no-repeat;
        background-size: 100% 100%;
      "
    >
      <div
        class="mt-3 flex w-full flex-row items-center justify-center"
        style="
          max-width: 480px;
          margin-top: 4px;
          margin-bottom: 0px;
          padding: 0px;
          background-color: transparent;
        "
      >
        <div class="pt-0 flex flex-row align-center justify-around w-full" style="font-size: 50px">
          <div class="flex w-1/3 mt-7 pl-2 float" v-if="activeName !== 'selectProduct'">
            <img
              src="/images/filterbar/side-arrow-prev.avif"
              style="height: 30px; z-index: 999"
              @click="
                depositScreenName === DepositScreenName.SELECT_PAYMENT
                  ? (depositScreenName = DepositScreenName.SELECT_PRODUCT)
                  : depositScreenName === DepositScreenName.CONFIRM
                    ? (depositScreenName = DepositScreenName.SELECT_PAYMENT)
                    : (depositScreenName = DepositScreenName.SELECT_PRODUCT)
              "
            />
          </div>
          <div v-else class="flex w-1/3"></div>

          <div class="flex w-1/3 mr-8">
            <AuroraText> DEPOSIT </AuroraText>
          </div>
          <div class="flex w-1/3"></div>
        </div>
        <div class="absolute right-0 top-1 flex">
          <img
            :src="`${closePressed ? '/images/common/close.png' : '/images/common/close.png'}`"
            style="z-index: 999; width: 40px; height: 40px; right: 0px; top: 0px"
            @click="close()"
          />
        </div>
      </div>
      <img
        src="/images/shop/store-banner.png"
        style="z-index: 899; width: 85vw; height: 100px; right: 0px; top: 0px"
      />
      <div
        v-if="currentUser !== undefined && products !== undefined && products.length > 0"
        class="min-h-100 w-100 flex flex-col items-center justify-center"
        style="max-width: 100%"
      >
        <div class="flex w-full items-center justify-stretch px-1" style="width: 100vw">
          <!-- <div class="top-13 absolute left-12 flex">
            <img
              v-if="activeName !== 'selectProduct'"
              src="/images/filterbar/side-arrow-prev.avif"
              style="height: 30px; z-index: 999"
              @click="
                activeName === 'selectPayment'
                  ? (activeName = 'selectProduct')
                  : activeName === 'shopConfirm'
                    ? (activeName = 'selectPayment')
                    : (activeName = 'selectProduct')
              "
            />
          </div> -->
          <div
            style="margin: auto; font-size: 36px"
            class="glow flex items-center justify-center py-5 pl-5"
          />
        </div>
        <div v-if="activeName === 'pendingTransaction'">
          <div
            class="glow text-small my-3 flex w-full items-start justify-start py-3 text-white"
            style="font-size: 18px"
          >
            <div class="margin-auto flex items-center justify-center">
              You already have a pending balance transaction. Would you like to cancel it?
            </div>
          </div>
          <div
            class="mx-16 mb-12 flex flex-row justify-center gap-3"
            style="margin-bottom: 150px; margin-top: 16px"
          >
            <div @click="close()">
              <GlassButton color="red"> No </GlassButton>
            </div>
            <div @click="cancelBalanceTransactions()">
              <GlassButton color="green"> Yes </GlassButton>
            </div>
          </div>
        </div>
        <div
          v-if="
            depositStore.depositScreenName == DepositScreenName.SELECT_PRODUCT &&
            depositStore.getProducts !== undefined
          "
        >
          <SelectProduct :current-user="currentUser" />
        </div>

        <div v-if="depositStore.depositScreenName == DepositScreenName.SELECT_PAYMENT">
          <SelectPayment :current-user="currentUser" />
        </div>

        <div v-if="activeName === 'enterStoreId'">
          <StoreId :current-user="currentUser" />
        </div>
        <div v-if="depositStore.depositScreenName == DepositScreenName.CONFIRM">
          <ShopConfirm :selected-product="selectedProduct" :current-user="currentUser" />
        </div>

        <!-- <div class="mx-12 flex flex-row justify-between"></div> -->
      </div>
      <div
        style="
          position: absolute;
          bottom: 19px;
          left: 15px;
          width: 92%;
          height: 115px;
          z-index: 20;
          /* margin-left: 8px; */
          /* margin-top: 40px; */
          background-position-y: top;
          background-size: 92vw 115px;
          background: url('/images/shop/gold-bottom2.avif');
        "
      />
    </div>
  </div>
</template>

<style scoped>
  .fade-enter-active,
  .fade-leave-active {
    transition: opacity 0.7s;
  }

  .fade-enter-from,
  .fade-leave-to {
    opacity: 0;
  }

  .Tabs__nav {
    background-color: transparent !important;
    color: transparent !important;
  }

  .glow {
    font-size: 30px;
    font-weight: 800;
    color: #fff;
    text-align: end;
    /* text-shadow:  #FC0 1px 0 10px; */
    text-shadow:
      0px 0px 10px #fff,
      0 0 20px #c74dff,
      0 0 30px #720fc4;
  }

  .not-glow {
    font-size: 18px;
    font-weight: 900;
    color: #fff;
    text-align: center;
    /* -webkit-animation: glow 1s ease-in-out infinite alternate;
    -moz-animation: glow 1s ease-in-out infinite alternate;
    animation: glow 1s ease-in-out infinite alternate; */
  }
</style>
