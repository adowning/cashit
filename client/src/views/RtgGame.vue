<template>
  <div v-if="error === false" style="width: 100vw; height: 100vh">
    <GameLoader :options="gameLaunchOptions" />
  </div>
  <div v-else>
    <p>Game name is missing in the URL.</p>
  </div>
</template>

<script setup lang="ts">
  // import RtgGameLoader from '@/components/games/RtgGameLoader.vue' // Adjust path if needed
  import { reactive } from 'vue'
  import { useRouteQuery } from '@vueuse/router'

  const error = ref(false)
  // Define the type for the mode explicitly if you want to be able to change it
  type GameMode = 'real' | 'demo'

  // const route = useRoute()
  const gameName = useRouteQuery('gameName') // or with a default value
  console.log(gameName.value)
  if (!gameName.value) error.value = true
  // Correctly typed gameOptions
  const gameLaunchOptions = reactive<RtgGameLaunchOptions>({
    gameName: gameName.value as string, // Or dynamically set this
    lang: 'en',
    currency: 'USD',
    mode: 'real',
    rgsApiBase: '/rtg/games/rtg/platform', // Example: This should point to YOUR server
    operator: 'demo', // As configured in your RTG setup
    provider: 'kronos', // Or whatever RTG uses for your setup
    lobbyUrl: '/lobby',
    depositUrl: '/account/deposit',
  })

  // Or, if you always want it to be 'real' or 'demo' directly:
  // const gameOptions = reactive({
  //   gameId: "777Strike",
  //   lang: "en",
  //   currency: "USD",
  //   mode: 'real', // This literal is directly assignable
  //   // ...
  // });
</script>
