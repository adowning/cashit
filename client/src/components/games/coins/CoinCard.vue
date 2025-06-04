<template>
  <div
    :class="`relative flex flex-row items-center p-2 pt-1 m-2 rounded-2xl ${offer.primaryBgClass} border-2 ${offer.borderColorClass} w-full md:w-1/3 max-w-xs transform hover:scale-105 transition-transform duration-300 card-glow`"
  >
    <div
      v-if="offer.isBestValue"
      class="absolute -top-4 left-1/2 transform -translate-x-1/2 px-6 py-1.5 bg-green-400 text-black font-bold text-sm rounded-full shadow-lg flex items-center space-x-2 border-2 border-white"
    >
      <div class="w-2.5 h-2.5 bg-white rounded-full"></div>
      <span>BEST VALUE</span>
      <div class="w-2.5 h-2.5 bg-white rounded-full"></div>
    </div>

    <img
      :src="offer.imageSrc"
      :alt="offer.imageAlt"
      class="w-40 h-32 object-contain mb-4 rounded-lg shadow-md"
    />

    <h3 class="text-2xl font-bold text-yellow-300 mb-1 tracking-wide">{{ offer.coins }}</h3>
    <p v-if="offer.bonus" class="text-sm text-green-300 font-semibold mb-3">{{ offer.bonus }}</p>
    <p class="text-3xl font-bold text-white mb-6">{{ offer.price }}</p>

    <button
      :class="`w-full py-3 px-6 ${offer.buttonBgClass} text-black font-bold text-lg rounded-lg shadow-md hover:shadow-xl transition-all duration-200 transform hover:translate-y-[-2px]`"
    >
      {{ offer.buttonText }}
    </button>
  </div>
</template>

<script setup lang="ts">
  import { defineProps } from 'vue'
  import type { CoinOffer } from './types'

  const props = defineProps<{
    offer: CoinOffer
  }>()
</script>
