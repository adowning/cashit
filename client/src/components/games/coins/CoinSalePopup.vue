<template>
  <div
    class="fixed w-full inset-0 bg-black/80 flex items-center justify-center z-50 p-4 backdrop-blur-sm"
  >
    <div class="flex relative w-full p-2">
      <div
        class="p-6 md:p-8 w-full min-h-[200px] flex flex-col justify-center items-center"
        style="
          background-image: url('/images/leaderboard/600x900-popup.avif');
          background-repeat: no-repeat;
          overflow: hidden;
          background-size: 100% 100%;
          background-position-y: top;
        "
      >
        <!-- <button @click="emit('close')" class="absolute top-0 right-0" aria-label="Close">
          <CloseIcon class-name="w-7 h-7" />
        </button> -->

        <!-- Header Banner -->
        <div class="relative mb-6 md:mb-8 py-2 px-2 justify-center items-center">
          <!-- <div class="absolute -top-5 -left-8 hidden md:block">
            <img
              :src="MEGA_SALE_BANNER_CHEST_IMG_LEFT"
              alt="Treasure Chest"
              class="w-28 h-auto transform -rotate-12"
            />
          </div> -->
          <!-- <div class="absolute -top-5 -right-8 hidden md:block"> -->
          <!-- <img
              :src="MEGA_SALE_BANNER_CHEST_IMG_RIGHT"
              alt="Treasure Chest"
              class="w-28 h-auto transform rotate-12"
            /> -->
          <!-- </div> -->

          <!-- <div class="flex items-center justify-center space-x-2 md:space-x-4">
            <SparkleIcon class-name="text-yellow-300 w-6 h-6 md:w-8 md:h-8 opacity-80" />
            
            <SparkleIcon class-name="text-yellow-300 w-6 h-6 md:w-8 md:h-8 opacity-80" />
          </div> -->
          <AuroraText
            class="font-game-title text-3xl justify-center items-center md:text-5xl text-yellow-300 text-center tracking-wider"
          >
            OUT OF COINS
          </AuroraText>
          <!-- <div
            class="absolute bottom-0 left-1/2 transform -translate-x-1/2 translate-y-1/2 flex space-x-2 opacity-70"
          >
            <img
              v-for="i in 3"
              :key="`coin-sm-${i}`"
              :src="`${MEGA_SALE_BANNER_COIN_IMG}`"
              alt="Small Coin"
              class="w-6 h-6 md:w-8 md:h-8 rounded-full shadow-md"
            />
          </div> -->
        </div>

        <!-- Coin Offers Grid -->
        <!-- <div class="flex mt-6 flex-col md:flex-col justify-around items-stretch gap-2 md:gap-2">
          <CoinCard v-for="offer in props.offers" :key="offer.id" :offer="offer" />
        </div> -->
        <div class="flex mt-6 text-3xl flex-row md:flex-col justify-center gap-4 md:gap-4">
          <GlassButton @click="close()">Shop</GlassButton>
          <GlassButton @click="close()">Lobby</GlassButton>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { defineProps, defineEmits } from 'vue'
  import type { CoinOffer } from './types'
  import { router } from '@/router'
  // import CoinCard from './CoinCard.vue'
  // import CloseIcon from './icons/CloseIcon.vue'
  // import SparkleIcon from './icons/SparkleIcon.vue'
  // import {
  //   MEGA_SALE_BANNER_CHEST_IMG_LEFT,
  //   MEGA_SALE_BANNER_CHEST_IMG_RIGHT,
  //   MEGA_SALE_BANNER_COIN_IMG,
  // } from './constants'

  const props = defineProps<{
    offers: CoinOffer[]
  }>()

  const emit = defineEmits(['close', 'shop', 'lobby'])

  function close() {
    console.log('closing')
    emit('close')
    router.push('/home').then(() => {
      window.location.reload()
    })
  }
</script>
