<template>
  <div
    class="p-1 rounded-xl shadow-2xl text-center relative overflow-hidden"
    style="
      background-size: 120% 100%;
      background-repeat: no-repeat;
      background-position: center;
      background-image: url('/images/tournaments/team-race-banner-mob.png');
    "
  >
    <div
      class="absolute -top-10 -left-10 w-40 h-40 bg-purple-500/30 rounded-full filter blur-2xl opacity-70"
    ></div>
    <div
      class="absolute -bottom-10 -right-10 w-40 h-40 bg-sky-500/30 rounded-full filter blur-2xl opacity-70"
    ></div>

    <div class="relative z-10 pt-3 flex justify-center flex-col items-center">
      <h3
        class="flex pt-2 text-sm max-w-30 font-semibold uppercase tracking-wider text-purple-300 mb-1"
      >
        {{ tournament.name }}
      </h3>
      <h2 class="text-2xl md:text-4xl font-bold text-white mb-2 leading-tight">
        RACE TOGETHER,<br />WIN TOGETHER!
      </h2>

      <div class="flex justify-center items-center my-4 space-x-4">
        <!-- <img
          :src="tournament.imageLeft"
          alt="Lucky Rollers"
          class="w-20 h-28 md:w-28 md:h-40 object-cover rounded-lg shadow-md transform -rotate-6 hover:rotate-0 transition-transform duration-300"
        /> -->
        <div class="text-center">
          <!-- <p class="text-xs text-yellow-300 uppercase">Prize Pool</p> -->
          <!-- <p class="text-4xl md:text-5xl font-extrabold text-yellow-400 tracking-tight my-1">
            {{ tournament.prizePool }}
          </p> -->
          <div class="text-2xl md:text-3xl font-bold text-white my-2 min-h-[50px]"></div>
          <p class="text-sm text-gray-300">Starts</p>
          <p class="text-lg font-semibold text-white">{{ tournament.startDate }}</p>
        </div>
        <!-- <img
          :src="tournament.imageRight"
          alt="Game Changers"
          class="w-20 h-28 md:w-28 md:h-40 object-cover rounded-lg shadow-md transform rotate-6 hover:rotate-0 transition-transform duration-300"
        /> -->
      </div>
    </div>
  </div>
</template>

<script setup>
  import { defineProps } from 'vue'

  const props = defineProps({
    tournament: {
      type: Object,
      required: true,
      default: () => ({
        name: 'Team Races',
        title1: 'RACE TOGETHER,',
        title2: 'WIN TOGETHER!',
        prizePool: '350,000',
        startDate: '29 May 2025, 09:00 AM',
        imageLeft: 'https://placehold.co/150x200/10b981/000000?text=Lucky+Rollers&font=Inter',
        imageRight: 'https://placehold.co/150x200/ef4444/000000?text=Game+Changers&font=Inter',
      }),
    },
  })
</script>
