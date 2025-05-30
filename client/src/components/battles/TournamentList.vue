<template>
  <div>
    <h2 class="text-xl font-semibold mb-1 text-gray-300 flex items-center">
      <span
        v-if="title === 'RIGHT NOW'"
        class="mr-2 h-3 w-3 bg-green-500 rounded-full animate-pulse"
      ></span>
      <span v-else-if="title === 'UP NEXT'" class="mr-2 h-3 w-3 bg-yellow-500 rounded-full"></span>
      <span v-else-if="title === 'LATER'" class="mr-2 h-3 w-3 bg-sky-500 rounded-full"></span>
      {{ title }}
    </h2>
    <div v-if="tournaments && tournaments.length > 0" class="space-y-4">
      <TournamentCard
        v-for="tournament in tournaments"
        :key="tournament.id"
        :tournament="tournament"
        :is-active-section="title === 'RIGHT NOW'"
        :is-finished="isFinished"
        @show-leaderboard="$emit('show-leaderboard', tournament)"
        @show-how-it-works="$emit('show-how-it-works', tournament)"
        @join-tournament="$emit('join-tournament', tournament.id)"
      />
    </div>
    <div v-else class="text-center py-8 text-gray-500">
      <p>No tournaments in this section right now.</p>
      <p v-if="title === 'RIGHT NOW'">Check back soon for active races!</p>
    </div>
  </div>
</template>

<script setup>
  import { defineProps, defineEmits } from 'vue'
  import TournamentCard from './TournamentCard.vue'

  const props = defineProps({
    title: String,
    tournaments: Array,
    isFinished: {
      type: Boolean,
      default: false,
    },
  })

  defineEmits(['show-leaderboard', 'show-how-it-works', 'join-tournament'])
</script>
