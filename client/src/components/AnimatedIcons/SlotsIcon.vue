<script setup lang="ts">
  import { ref } from 'vue'
  import * as RawSlotsJsonData from '@/assets/anim/part1.json' //
  import SlotsSpritesheetUrl from '@/assets/anim/part1.png' //
  import SpriteAnimation from '../common/SpriteAnimation.vue' // Adjust path
  import type { SpriteData, AnimationFrameData } from 'shared/dist.vue'
  import { transformRawSpriteJsonToSpriteData } from '../common/transformSpriteData'

  const backing = ref('standard') //

  function doBattles() {
    console.log('SlotsIcon clicked')
    // Example: useAppStore().setFilterBar('slots')
  }

  const slotsIconSpriteData: SpriteData = transformRawSpriteJsonToSpriteData(
    RawSlotsJsonData,
    'part1.png'
  )
  const actualFrameWidth = slotsIconSpriteData.frames[0]?.sourceSize.w || 94 // Fallback to known 94
  const actualFrameHeight = slotsIconSpriteData.frames[0]?.sourceSize.h || 94 // Fallback to known 94
</script>

<template>
  <div
    style="margin: auto; margin-bottom: 10px"
    class="flex grow-1 flex-col justify-between"
    @click="doBattles()"
  >
    <div
      :style="{
        backgroundImage: `url(${backing === 'standard' ? '/images/button-on.png' : '/images/button-dead.png'})`,
        backgroundSize: 'contain',
        backgroundRepeat: 'no-repeat',
        zIndex: '13',
        width: '100px',
        height: '70px',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        position: 'relative',
      }"
    >
      <SpriteAnimation
        animationName="slots-icon"
        :spritesheetUrl="SlotsSpritesheetUrl"
        :spriteData="slotsIconSpriteData"
        :fps="20"
        :autoplay="true"
        :loop="true"
        :width="actualFrameWidth"
        :height="actualFrameHeight - 5"
        style="transform: scale(0.6) translateY(1px) translateX(-15px); z-index: 12"
      />
      <img
        src="/images/bottom/menu1-1.png"
        width="50"
        height="30"
        style="
          position: absolute;
          top: 22px;
          left: 12px;
          top: 50%;
          left: 40%;
          transform: translate(-50%, -20%) translateY(calc(15px / 0.6));
          z-index: 13;
          pointer-events: none;
        "
      />
    </div>
  </div>
</template>

<style scoped>
  /* Copied from AllIcon.txt, assuming it's shared or similar styling is needed */
  .shake {
    animation: shake 0.82s cubic-bezier(0.36, 0.07, 0.19, 0.97) both;
    transform: translate3d(0, 0, 0);
  }

  @keyframes shake {
    10%,
    90% {
      transform: translate3d(-1px, 0, 0);
    }
    20%,
    80% {
      transform: translate3d(2px, 0, 0);
    }
    30%,
    50%,
    70% {
      transform: translate3d(-4px, 0, 0);
    }
    40%,
    60% {
      transform: translate3d(4px, 0, 0);
    }
  }
</style>
