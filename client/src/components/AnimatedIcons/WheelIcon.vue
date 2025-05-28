<!-- eslint-disable @typescript-eslint/no-explicit-any -->
<script setup lang="ts">
  import { ref, onMounted } from 'vue'
  import * as RawWheelJsonData from '@/assets/anim/wheel.json' //
  import WheelSpritesheetUrl from '@/assets/anim/wheel.png' //
  import SpriteAnimation from '../common/SpriteAnimation.vue' // Adjust path
  import type { SpriteData } from 'shared/dist.vue'
  import { useEventManager } from '@/composables/EventManager' //
  import { transformRawSpriteJsonToSpriteData } from '../common/transformSpriteData'

  const eventBus = useEventManager() //
  const isMounted = ref(false) //
  const countdownActive = ref(false) //
  const authStore = useAuthStore()
  const { currentUser } = storeToRefs(authStore)
  // const sprite = ref() // No longer for VSprite
  const isSpiral = ref(false) //
  const complete = ref(true) // Based on original template logic for spin button
  const shakeIt = ref(false) //

  const wheelIconSpriteData: SpriteData = transformRawSpriteJsonToSpriteData(
    RawWheelJsonData,
    'wheel.png'
  )

  function warnDisabled() {
    //
    shakeIt.value = true
    setTimeout(() => {
      shakeIt.value = false
    }, 1500)
  }

  function doFreeSpin() {
    //
    console.log('doFreeSpin')
    if (complete.value === false) {
      // Assuming 'complete' means 'animation cycle complete and ready for new spin'
      warnDisabled()
    } else {
      eventBus.emit('wheelPageOpen', true)
      // Potentially trigger wheel animation if it's not autoplay loop
      // eventBus.emit('animation:play:wheel-main-animation');
    }
  }

  onMounted(() => {
    isMounted.value = true
  })

  // //console.log(WheelJson)
  const start_date = new Date(
    currentUser?.lastDailySpin ? currentUser.lastDailySpin.toString() : '2023-01-01T00:00:00.000Z'
  )
  const remaining_minutes = ref(0)
  const remaining_seconds_display = ref(0)
  const interval = ref()
  function countdownTimer(start_date: Date): void {
    // Calculate the end date, which is one hour after the start date
    const end_date = new Date(start_date.getTime() + 3600000) // One hour later

    // Calculate the difference between the end date and now
    const now = new Date()
    const time_difference = end_date.getTime() - now.getTime()

    // Convert the time difference to seconds
    const total_seconds = Math.floor(time_difference / 1000)

    // Calculate minutes and seconds
    // const minutes = Math.floor(total_seconds / 60)
    // const seconds = total_seconds % 60

    // Print the initial countdown
    // console.log(`Countdown: ${minutes} minutes and ${seconds} seconds`)

    // Start the countdown
    let remaining_seconds = total_seconds
    interval.value = setInterval(() => {
      // Calculate remaining minutes and seconds
      remaining_minutes.value = Math.floor(remaining_seconds / 60)
      remaining_seconds_display.value = remaining_seconds % 60

      // Print the remaining time
      // console.log(
      //   `Countdown: ${remaining_minutes.value} minutes and ${remaining_seconds_display.value} seconds`,
      // )

      // Decrease the remaining seconds by one
      remaining_seconds -= 1

      // Stop the countdown when it reaches zero
      if (remaining_seconds < 0) {
        clearInterval(interval.value)
        // console.log('Countdown finished!')
        complete.value = true
      }
    }, 1000)
    countdownActive.value = true
  }
  countdownTimer(start_date)
  // const countDown = useCountdown(Math.floor(time / 1000))
  // console.log(new Date(countDown.remaining.value))

  // countDown.start()
  // //console.log(countDown.current.value)
  // watch(countDown.remaining, (z) => {

  //   if (z <= 0) {
  //     complete.value = true
  //   }
  // })
  // const countDown = ref({
  //   remaining: time, // Initialize with the remaining time in seconds
  // })
  // const formatted = useDateFormat(
  //   new Date(new Date().getTime() + countDown.value.remaining),
  //   'HH:mm:ss',
  // )

  // setInterval(() => {
  //   if (!complete.value) {
  //     // console.log(countDown.value.remaining)
  //     countDown.value.remaining--
  //     formattedTime.value = formatTime(countDown.value.remaining)
  //     if (countDown.value.remaining <= 0) {
  //       complete.value = true
  //     }
  //   }
  // }, 1000)
  // watch(countDown, (newRemaining) => {
  //   // console.log(newRemaining)
  //   formattedTime.value = formatTime(newRemaining.remaining)

  //   if (newRemaining.remaining <= 0) {
  //     complete.value = true
  //   }
  // })

  // if (countDown.value.remaining === 0) {
  //   complete.value = true
  // }
  const wheel = shallowRef<any>()
  onMounted(() => {
    setTimeout(() => {
      isMounted.value = true
    }, 1000)
    setTimeout(() => {
      isSpiral.value = true
    }, 7000)
  })
</script>

<template>
  <div
    :id="`UserControlWheel-${currentUser?.id}`"
    class="nav-item user-wheel"
    :class="{ shake: shakeIt }"
    style="
      color: white;
      position: absolute;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      width: 100px;
      height: 90px;
      transform: translateY(8px);
    "
  >
    <div
      v-if="!isMounted && !countdownActive"
      id="wheelCountdown"
      style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 2"
      class="futex-cell flex justify-center text-black"
      @click="warnDisabled()"
    ></div>

    <div
      v-if="countdownActive && complete === false"
      style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 2"
      class="futex-cell flex justify-center text-white"
      @click="warnDisabled()"
    ></div>

    <SpriteAnimation
      v-if="isMounted"
      animationName="wheel-main-animation"
      :spritesheetUrl="WheelSpritesheetUrl"
      :spriteData="wheelIconSpriteData"
      :fps="20"
      :autoplay="true"
      :loop="true"
      :width="260"
      :height="180"
      style="z-index: 1; transform: scale(0.45) translateY(50px) translateX(50px)"
    />

    <div
      v-if="complete"
      class="flex justify-center text-white glow font-bold futex-cell"
      style="
        line-height: 0.7;
        width: 95px;
        position: absolute;
        bottom: -20px;
        padding-bottom: 0px;
        left: 30%;

        height: 20px;
        font-family: ubuntu;
        z-index: 9999;
        font-size: 19px;
        font-weight: 700;
        cursor: pointer;
        text-align: center;
      "
      @click="doFreeSpin()"
    >
      Spin
    </div>
  </div>
</template>

<style scoped>
  .shake {
    /* transform: translateY(14px); */
    color: orange;
    z-index: 999999;
    /* animation: shake 0.82s cubic-bezier(0.36, 0.07, 0.19, 0.97) both; */
    animation: shake 0.82s;
  }

  @keyframes shake {
    10%,
    90% {
      transform: translateX(-1px);
    }

    20%,
    80% {
      transform: translateX(2px);
    }

    30%,
    50%,
    70% {
      transform: translateX(-4px);
    }

    40%,
    60% {
      transform: translateX(4px);
    }
  }

  #spriteAnim {
    width: 399px;

    height: 200px;

    margin: 2em auto;

    background: transparent url('') 0 0 no-repeat;

    animation: spriteAnim 1s steps(12) infinite;
  }

  /* Animation keyframes */

  @keyframes spriteAnim {
    100% {
      background-position: 0 -2393px;
    }
  }
</style>
