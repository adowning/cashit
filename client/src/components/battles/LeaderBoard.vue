<script setup lang="ts">
  import { useMotion } from '@vueuse/motion'
  import { UserProfile } from 'shared'
  //   defineProps(['list', 'currentUser'])
  defineProps<{
    list?: any[]
    currentUser: UserProfile
  }>()

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
  onMounted(() => {
    mounted.value = true
  })
</script>

<template>
  <div
    v-if="list !== undefined && mounted"
    class="flex flex-col items-center justify-start overflow-y-hidden"
    style="
      background-image: url('/images/leaderboard/600x900-popup.avif');
      width: 100%;
      background-repeat: no-repeat;
      overflow: hidden;
      background-size: 100% 100%;
      background-position-y: top;
    "
  >
    <!-- <transition name="fade"> -->
    <div
      v-if="list.length > 0 && mounted"
      class="w-100 flex flex-col items-start justify-start"
      style="max-width: 100%"
    >
      <div class="w-100 flex">
        <div class="glow w-100 mt-4 flex justify-center">BETA BATTLE</div>
        <!-- <div class="flex grow-1"></div> -->
        <!-- <FancyButton type="close" class="flex grow-0
     w-100 mr-3 glow   items-center justify-end" @click="closePopup" /> -->
      </div>
      <div class="w-100 flex justify-center" style="">
        <div
          class="flex"
          :style="`background-image: url('/avatars/avatar-${list[2].avatar}.avif'); background-repeat: no-repeat; 
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
          class="flex"
          style="transform: scale(1.3)"
          :style="`background-image: url('/avatars/avatar-${list[1].avatar}.avif'); 
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
          class="flex"
          style="transform: scale(1.3)"
          :style="`background-image: url('/avatars/avatar-${list[3].avatar}.avif'); 
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
      <div class="mt-0 flex flex-col" style="height: 38vh; overflow-y: scroll; margin-inline: auto">
        <div
          v-for="(user, i) of list"
          ref="productbar"
          :key="user.id"
          class="product my-1 justify-start py-1 pl-2 pt-0"
          :style="` background-image: url(${
            user.username !== currentUser.username
              ? '/images/leaderboard/leaderrow.avif'
              : '/images/leaderboard/leaderbar-user.avif'
          });
          border-radius: 12px; width: 100%;background-repeat: no-repeat; 
          background-size:  100% 100%; background-position-y: center;background-position-x: start;`"
        >
          <div class="flex flex-row justify-start gap-1" style="height: 46px; min-width: 100%">
            <div
              style="
                background-image: url('/images/leaderboard/leaderboard-flag.avif');
                background-repeat: no-repeat;
                background-size: cover;
                height: 100%;
                width: 30px;
                padding: 6px;
                font-family: bungeecolor;
                font-size: 18px;
              "
            >
              <!-- <img src="/images/leaderboard/leaderboard-flag.avif" style=" height: 40px;  " class="mt-0 pt-0 pt-0"> -->
              {{ i }}
            </div>
            <div v-if="i < 3">
              <img
                src="/images/leaderboard/trophy1.avif"
                style="width: 25px; height: 25px"
                class="ml-1 mt-2"
              />
            </div>
            <div v-else>
              <div style="width: 25px; height: 25px" class="ml-1 mt-2" />
            </div>
            <div>
              <img
                :src="`/avatars/avatar-${user.avatar}.avif`"
                round
                style="width: 32px"
                class="mt-2"
              />
            </div>
            <div style="width: 100px; text-align: left" class="not-glow mr-5 mt-2">
              {{ user.username }}
            </div>
            <div>
              <img
                src="/images/leaderboard/coinicon.avif"
                style="width: 25px; height: 25px"
                class="mt-2"
              />
            </div>
            <div style="font-size: 18px" class="mr-2 mt-2 py-0">
              {{ (user.coins * 100) / 100 }}
              <!-- <van-rolling-text class="my-rolling-text" :target-num="(user.coins * 100) / 100" /> -->
            </div>
          </div>
        </div>
      </div>

      <div class="flex">
        <img
          src="/images/leaderboard/leaderboard-prizes.avif"
          style="margin: auto; margin-bottom: 28px; width: 90%"
          class="mt-5 py-0"
        />
      </div>
    </div>
    <!-- </transition> -->
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
