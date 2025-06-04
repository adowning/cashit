<script setup lang="ts">
  import { ref, onMounted } from 'vue'
  import { useMotion } from '@vueuse/motion'
  import { PrismaUserProfile, UserProfile } from 'shared'
  import { X } from 'lucide-vue-next'
  import AuroraText from '@/components/common/AuroraText.vue'
  import { useUserStore } from '@/stores/user.store'

  //   defineProps(['list', 'currentUser'])
  defineProps<{
    isOpen: boolean
    currentUser: UserProfile
  }>()

  const emit = defineEmits<{
    close: []
  }>()
  const userStore = useUserStore()
  const closePressed = ref(false)
  const list = ref<PrismaUserProfile[]>([])

  function close() {
    closePressed.value = true
    emit('close')
  }
  const target = ref<HTMLElement>()
  // Get the variant from target motion instance.
  const { apply } = useMotion(target, {
    initial: {
      scale: 0.6,
      opacity: 1,
    },
    enter: {
      opacity: 1,
      scale: 1,
    },
  })

  const customEvent = async () => {
    // Animate to a temporary variant.
    await apply({
      scale: 1.2,
      transition: {
        type: 'spring',
        stiffness: 200,
        damping: 10,
        mass: 0.4,
      },
    })

    // Revert back to enter state
    await apply('enter')
  }
  customEvent()

  const mounted = ref(false)
  onMounted(async () => {
    const { success, data, error } = await userStore.fetchAllUserProfiles()
    if (success && data) {
      data.items.sort((a: any, b: any) => b.balance - a.balance)
      list.value = data.items
    }
    mounted.value = true
  })
</script>

<template>
  <!-- Modal Overlay -->
  <transition name="fade" mode="out-in">
    <div
      v-if="isOpen && mounted"
      class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm"
      @click.self="emit('close')"
    >
      <!-- Modal Content -->
      <div
        class="flex flex-col items-center justify-start overflow-y-hidden max-w-md w-full mt-6 h-[90vh]"
        style="
          background-image: url('/images/leaderboard/600x900-popup.avif');
          background-repeat: no-repeat;
          overflow: hidden;
          background-size: 100% 100%;
          background-position-y: top;
        "
        @click.stop
      >
        <!-- <transition name="fade"> -->
        <div
          v-if="list && list.length > 0 && mounted"
          class="w-100 flex flex-col items-start justify-start"
          style="max-width: 100%"
        >
          <div class="w-full flex justify-between items-center">
            <div class="flex-1"></div>
            <div class="mt-6 mb-2 text-4xl flex w-full justify-center items-center">
              <AuroraText> BETA BATTLE </AuroraText>
            </div>
            <div class="flex-1 flex justify-end">
              <button
                @click="close()"
                class="absolute top-12 right-0 p-2 rounded-full text-white transition-colors hover:bg-white/10 z-20"
                aria-label="Close leaderboard"
              >
                <img
                  :src="`${
                    closePressed ? '/images/common/close-pressed.png' : '/images/common/close.png'
                  }`"
                  style="width: 45px; height: 45px"
                />
                <!-- <X class="h-5 w-5" /> -->
              </button>
            </div>
          </div>
          <div class="w-full flex justify-center" style="">
            <div
              v-if="list[2]"
              class="flex"
              :style="`background-image: url('/images/avatars/${list[2].avatar}'); background-repeat: no-repeat;
        background-size: 70% 48%;
        border-radius: 22px;
        background-position-x: 10px;
          background-position-y: 32px; `"
            >
              <img
                src="/images/leaderboard/leader2.avif"
                style="position: relative; height: 100px; top: 0px; bottom: 0px; left: 0px"
              />
            </div>
            <div
              v-if="list[1]"
              class="flex"
              style="transform: scale(1.3)"
              :style="`background-image: url('/images/avatars/${list[1].avatar}');
        background-repeat: no-repeat;
          background-size: 50% 45%;
          border-radius: 22px;
          clip: rect(1px, 10em, 3rem, 2ch);
           background-position-x: 20px;
          background-position-y: 30px; `"
            >
              <img src="/images/leaderboard/leader1.avif" style="height: 100px" />
            </div>
            <div
              v-if="list[3]"
              class="flex"
              style="transform: scale(1.3)"
              :style="`background-image: url('/images/avatars/${list[3].avatar}');
        background-repeat: no-repeat;
        background-size: 55% 40%;
        clip: rect(10em, 10em, 3rem, 2em);
        border-radius: 20% 20% 20% 20%;
        background-position-x: 10px;
          background-position-y: 32px; `"
            >
              <img
                src="/images/leaderboard/leader3.avif"
                style="
                  position: relative;
                  padding-top: 20px;
                  height: 100px;
                  bottom: 0px;
                  left: 0px;
                  transform: scale(0.9) translateY(-12px);
                "
              />
            </div>
          </div>
          <div class="scroll-wrapper relative">
            <!-- Fade overlay that stays at the top -->
            <div class="fade-overlay"></div>
            <div
              class="mt-0 flex pt-1 flex-col w-full px-8 scroll-container"
              style="height: 42vh; overflow-y: scroll; margin-inline: auto"
            >
              <div
                v-for="(user, i) of list"
                ref="productbar"
                :key="user.id"
                class="product my-1 justify-start pl-2 pt-0 w-full align-baseline flex inline-block"
                :style="` background-image: url(${
                  user.username !== currentUser.username
                    ? '/images/leaderboard/leaderrow.avif'
                    : '/images/leaderboard/leaderbar-user.avif'
                });
          border-radius: 12px;background-repeat: no-repeat; 
          background-size:  100% 100%; background-position-y: center;background-position-x: start;`"
              >
                <div
                  class="align-middle flex inline-block flex-row justify-start gap-1 pr-1"
                  style="min-width: 90%; line-height: 1.5; text-align: middle"
                >
                  <div class="flex justify-start inline-block align-middle">
                    <div
                      style="
                        background-image: url('/images/leaderboard/leaderboard-flag.avif');
                        background-repeat: no-repeat;
                        background-size: cover;
                        height: 100%;
                        width: 30px;
                        padding: 6px;
                        font-family: bungeecolor;
                        font-size: 22px;
                        font-weight: 800;
                      "
                    >
                      <!-- <img src="/images/leaderboard/leaderboard-flag.avif" style=" height: 40px;  " class="mt-0 pt-0 pt-0"> -->
                      {{ i }}
                    </div>
                    <div v-if="i < 3">
                      <img
                        src="/images/leaderboard/trophy1.avif"
                        style="width: 25px; height: 25px"
                        class="mt-2 min-h-[25px] min-w-[25px]"
                      />
                    </div>
                    <div v-else>
                      <div style="width: 5px; height: 25px" class="" />
                    </div>
                    <div>
                      <img
                        :src="`/images/avatars/${user.avatar}`"
                        round
                        style="
                          width: 40px;
                          min-width: 40px;
                          min-height: 40px;
                          max-width: 40px;
                          max-height: 40px;
                        "
                        class="rounded-full m-1"
                      />
                    </div>
                  </div>

                  <div class="not-glow flex grow justify-start pt-2 align-baseline inline-block">
                    {{ user.username.substring(0, 12) }}
                  </div>
                  <div
                    class="flex flex-row w-full justify-end mr-1 ml-5 py-3 grow inline-block align-middle"
                  >
                    <img
                      src="/images/leaderboard/coinicon.avif"
                      style="width: 25px; height: 25px"
                      class="flex inline-block align-middle"
                    />
                    <div style="font-size: 22px" class="inline-block align-middle">
                      {{ (user.balance * 100) / 100 }}
                      <!-- <van-rolling-text class="my-rolling-text" :target-num="(user.coins * 100) / 100" /> -->
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="flex m-auto w-full">
              <img
                src="/images/leaderboard/leaderboard-prizes.avif"
                style="margin: auto; margin-bottom: 18px; width: 90%"
                class="mt-0 py-0"
              />
            </div>
          </div>
          <!-- </transition> -->
        </div>
      </div>
    </div>
  </transition>
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

  .my-rolling-text {
    /* --van-rolling-text-background: #1989fa; */
    --van-rolling-text-color: white;
    --van-rolling-text-font-size: 12px;
    --van-rolling-text-gap: 0px;
    --van-rolling-text-item-border-radius: 5px;
    --van-rolling-text-item-width: 7px;
  }

  .glow {
    font-size: 30px;
    font-weight: 700;
    color: #fff;
    text-align: center;
    animation: 'glow';
    /* text-shadow:  #FC0 1px 0 10px; */
    text-shadow:
      2px 2px 10px #c74dff,
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

  .scroll-wrapper {
    position: relative;
  }

  .fade-overlay {
    position: absolute;
    top: -2px;
    left: 0;
    right: 0;
    width: 85%;
    margin: auto;
    height: 20px; /* Adjust fade distance */
    background: linear-gradient(
      to bottom,
      rgba(8, 11, 42, 1) 10%,
      rgba(8, 11, 42, 0.9) 10%,
      rgba(8, 11, 42, 0.7) 30%,
      rgba(8, 11, 42, 0.4) 50%,
      rgba(8, 11, 42, 0.2) 60%,
      transparent 100%
    );
    pointer-events: none;
    z-index: 10;
  }

  .scroll-container {
    position: relative;
  }

  @-webkit-keyframes glow {
    from {
      text-shadow:
        0 0 10px #fff,
        0 0 20px #fff,
        0 0 30px #e60073,
        0 0 40px #e60073,
        0 0 50px #e60073,
        0 0 60px #e60073,
        0 0 70px #e60073;
    }

    to {
      text-shadow:
        0 0 20px #fff,
        0 0 30px #ff4da6,
        0 0 40px #ff4da6,
        0 0 50px #ff4da6,
        0 0 60px #ff4da6,
        0 0 70px #ff4da6,
        0 0 80px #ff4da6;
    }
  }
</style>
