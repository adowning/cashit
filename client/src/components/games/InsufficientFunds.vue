<script setup lang="ts">
  import { router } from '@/router'
  import { ref } from 'vue'

  const depositStore = useTransactionStore()
  defineProps<{
    isOpen: boolean
    // currentUser: UserProfile
  }>()
  const closePressed = ref(false)

  const emit = defineEmits<{
    close: []
  }>()
  // const show = ref(true)
  const $bus = useEventManager()
  const authStore = useAuthStore()
  const { currentUser } = storeToRefs(authStore)

  async function dialogAction(type: string) {
    console.log('tick')
    // show.value = false
    if (type == 'lobby') {
      router.push('/')
    }
    if (type == 'shop') {
      router.push('/').then(() => {
        depositStore.toggleShopOpen()
      })
    }
    // $bus.emit(eventTypes.show_convert_dialog, true)

    // $bus.$emit(eventTypes.show_bars, true)
  }
  function close() {
    closePressed.value = true
    emit('close')
  }
</script>

<template>
  <!-- <VBottomSheet v-model="convertSheet"> -->
  <!-- <XDialog v-model="flux.dialog" title="Lorem Ipsum"> -->
  <!-- <div :show="show" @click="show = false"> -->
  <MazBackdrop v-model="show" @click="show = false">
    <div class="wrapper" @click.stop>
      <div class="animate__animated animate__bounceIn">
        <div
          ref="target"
          class="flex flex-col items-center justify-start overflow-y-hidden"
          style="
            /* background-image: url('/images/no_crystals.avif'); */
            width: 100%;
            border-image-slice: 5;
            border-image-repeat: round;
            border-image-width: 22px;
          "
        >
          <!-- <img
            src="/images/close.avif"
            style="position: absolute; right: 20px; top: 10px; width: 40px; z-index: 999"
            @click="close()"
          /> -->
          <img
            :src="`${
              closePressed ? '/images/common/close-pressed.png' : '/images/common/close.png'
            }`"
            style="position: absolute; right: 20px; top: 10px; width: 40px; z-index: 999"
          />
          <div
            class="m-auto"
            style="
              background-image: url('/images/games/coins_background.png');
              width: 100vw;
              background-size: cover;
              border-image-slice: 5;
              border-image-repeat: round;
              border-image-width: 22px;
              padding: 35px;
              z-index: 99;

              background-repeat: no-repeat;
              background-size: 100% 95%;
            "
          ></div>
        </div>
      </div>
    </div>
    <!-- </div> -->
  </MazBackdrop>
</template>
<style scoped>
  .wrapper {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100%;
  }
</style>
