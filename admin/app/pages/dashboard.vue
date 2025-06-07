<template>
  <UContainer class="py-8">
    <div class="space-y-8">
      <!-- <UCard> -->
      <!-- <template #header>
          <h2 class="text-lg font-semibold leading-tight">Server Statistics</h2>
        </template> -->
      <div v-if="isStatsLoading" class="text-center text-gray-500">Loading statistics...</div>
      <div v-else-if="stats" class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <UCard>
          <div class="text-center">
            <p class="text-3xl font-bold text-primary">
              {{ stats.totalConnections }}
            </p>
            <p class="text-sm text-gray-500 dark:text-gray-400">Active Connections</p>
          </div>
        </UCard>
        <UCard>
          <div class="text-center">
            <p class="text-3xl font-bold text-primary">
              {{ stats.userConnections }}
            </p>
            <p class="text-sm text-gray-500 dark:text-gray-400">User Sessions</p>
          </div>
        </UCard>
        <UCard>
          <div class="text-center">
            <p class="text-3xl font-bold text-primary">
              {{ stats.gameConnections }}
            </p>
            <p class="text-sm text-gray-500 dark:text-gray-400">Game Sessions</p>
          </div>
        </UCard>
        <UCard>
          <div class="text-center">
            <p class="text-3xl font-bold text-primary">
              {{ games?.length || 0 }}
            </p>
            <p class="text-sm text-gray-500 dark:text-gray-400">NG Games</p>
          </div>
        </UCard>
      </div>
      <!-- </UCard> -->

      <div class="grid grid-cols-1 gap-8 lg:grid-cols-2">
        <UCard :ui="{ body: { padding: 'sm:p-4' } }">
          <template #header>
            <h3 class="font-semibold">Game Window 1</h3>
          </template>
          <iframe ref="gameWindow1" class="w-full h-96 rounded-md bg-white" :src="gameWindow1Url" />
          <template #footer>
            <div class="flex flex-col space-y-2">
              <UButton block size="lg" :disabled="!selectedGame" @click="launchInWindow(1)">
                {{
                  selectedGame
                    ? `Launch ${selectedGame.name} in Window 1`
                    : 'Select a game to launch'
                }}
              </UButton>
              <UButton
                v-if="gameWindow1Url !== 'about:blank'"
                block
                color="#172e26"
                variant="soft"
                icon="i-heroicons-arrow-path"
                @click="restartGame(1)"
              >
                Restart Game
              </UButton>
            </div>
          </template>
        </UCard>
        <UCard :ui="{ body: { padding: 'sm:p-4' } }">
          <template #header>
            <h3 class="font-semibold">Game Window 2</h3>
          </template>
          <iframe ref="gameWindow2" class="w-full h-96 rounded-md bg-white" :src="gameWindow2Url" />
          <template #footer>
            <div class="flex flex-col space-y-2">
              <UButton block size="lg" :disabled="!selectedGame" @click="launchInWindow(2)">
                {{
                  selectedGame
                    ? `Launch ${selectedGame.name} in Window 2`
                    : 'Select a game to launch'
                }}
              </UButton>
              <UButton
                v-if="gameWindow2Url !== 'about:blank'"
                block
                color="#172e26"
                variant="soft"
                icon="i-heroicons-arrow-path"
                @click="restartGame(2)"
              >
                Restart Game
              </UButton>
            </div>
          </template>
        </UCard>
      </div>

      <UCard>
        <template #header>
          <h3 class="font-semibold">Last Spin Result Data</h3>
        </template>
        <div class="text-xs text-gray-500 dark:text-gray-400 mb-2">
          {{ debugInfo.timestamp }}
        </div>
        <pre class="bg-gray-900 text-white p-4 rounded-md text-xs overflow-auto max-h-64">{{
          debugInfo.content
        }}</pre>
      </UCard>

      <UCard>
        <template #header>
          <h3 class="font-semibold">NG Games - Select a game to preview and launch</h3>
        </template>
        <div v-if="selectedGame" class="p-3 mb-4 rounded-md bg-gray-100 dark:bg-gray-800">
          <p><strong>Selected:</strong> {{ selectedGame.name }}</p>
          <p class="text-sm text-gray-500 dark:text-gray-400">
            Target RTP: {{ selectedGame.targetRtp || selectedGame.rtp || '95.0%' }} | Actual RTP:
            {{ selectedGame.actualRtp || '0.00%' }} | Active Players:
            {{ selectedGame.activePlayers }}
          </p>
        </div>
        <div v-if="isGamesLoading" class="text-center text-gray-500">Loading NG games...</div>
        <div v-else class="max-h-96 overflow-y-auto space-y-2 pr-2">
          <div
            v-for="game in games"
            :key="game.id"
            class="p-4 rounded-md cursor-pointer transition-all"
            :class="[
              selectedGame?.id === game.id
                ? 'ring-2 ring-primary bg-primary/10'
                : 'bg-gray-100 dark:bg-gray-800 hover:bg-gray-200 dark:hover:bg-gray-700',
            ]"
            @click="selectGame(game)"
          >
            <p class="font-bold text-lg">
              {{ game.name }}
            </p>
            <div class="grid grid-cols-2 md:grid-cols-3 gap-2 text-sm mt-2">
              <UBadge color="cyan" variant="subtle">
                Target RTP: {{ game.targetRtp || game.rtp || '95.0%' }}
              </UBadge>
              <UBadge :color="parseFloat(game.actualRtp) > 95 ? 'green' : 'red'" variant="subtle">
                Actual RTP: {{ game.actualRtp || '0.00%' }}
              </UBadge>
              <p><span class="font-semibold">Players:</span> {{ game.activePlayers }}</p>
              <p>
                <span class="font-semibold">Total In:</span> ${{
                  (game.statIn || 0).toLocaleString()
                }}
              </p>
              <p>
                <span class="font-semibold">Total Out:</span> ${{
                  (game.statOut || 0).toLocaleString()
                }}
              </p>
              <p>
                <span class="font-semibold">Spins:</span>
                {{ (game.totalSpins || 0).toLocaleString() }}
              </p>
            </div>
          </div>
        </div>
      </UCard>
    </div>
  </UContainer>
</template>

<script setup lang="ts">
  import { ref, onMounted } from 'vue'
  import { useQuery } from '@tanstack/vue-query'

  // --- Reactive State ---
  const selectedGame = ref(null)
  const gameWindow1Url = ref('about:blank')
  const gameWindow2Url = ref('about:blank')

  const debugInfo = ref({
    timestamp: 'No data yet',
    content: 'Spin a game to see the server response data here...',
  })
  const { $orpc } = useNuxtApp()

  // --- Data Fetching with Vue Query ---
  const games = useQuery($orpc.game.getAllGames.queryOptions())

  const { data: stats, isLoading: isStatsLoading } = useQuery({
    queryKey: ['stats'],
    queryFn: () =>   games.json() //$fetch('/api/ws-stats'),
    refetchInterval: 30000, // Refetch every 30 seconds
  })

  // const { data: games, isLoading: isGamesLoading } = useQuery({
  //   queryKey: ['games'],
  //   queryFn: () => games.getAllGames(),// $fetch('/api/games/netgame'),
  //   refetchInterval: 10000, // Refetch every 10 seconds
  //   // Use the select option to transform/enhance the data on the client
  //   select: (fetchedGames) => {
  //     return fetchedGames.map((game) => ({
  //       ...game,
  //       // Mocking live data as in the original script
  //       actualRtp: `${(Math.random() * 5 + 92).toFixed(2)}%`,
  //       activePlayers: Math.floor(Math.random() * 50) + 1,
  //     }))
  //   },
  // })

  // --- Methods ---

  function selectGame(game) {
    selectedGame.value = game
  }

  function launchInWindow(windowNumber: 1 | 2) {
    if (!selectedGame.value) return

    if (windowNumber === 1) {
      gameWindow1Url.value = selectedGame.value.url
    } else {
      gameWindow2Url.value = selectedGame.value.url
    }
  }

  function restartGame(windowNumber: 1 | 2) {
    const url = windowNumber === 1 ? gameWindow1Url.value : gameWindow2Url.value
    if (url === 'about:blank') return

    const separator = url.includes('?') ? '&' : '?'
    const newUrl = url + separator + 't=' + Date.now()

    if (windowNumber === 1) {
      gameWindow1Url.value = newUrl
    } else {
      gameWindow2Url.value = newUrl
    }

    updateDebugWindow({
      action: 'GameRestart',
      window: windowNumber,
      game: selectedGame.value?.name,
      timestamp: new Date().toISOString(),
      url,
    })
  }

  function updateDebugWindow(data: object) {
    debugInfo.value = {
      timestamp: `Last update: ${new Date().toLocaleString()}`,
      content: JSON.stringify(data, null, 2),
    }
  }

  // --- Lifecycle Hooks ---

  onMounted(() => {
    // Intercept fetch requests (for debugging, as in original)
    // This part is a side-effect and remains largely the same
    const originalFetch = window.fetch
    window.fetch = function (...args: [RequestInfo | URL, RequestInit | undefined]) {
      return originalFetch.apply(this, args).then((response) => {
        const clonedResponse = response.clone()
        const url = typeof args[0] === 'string' ? args[0] : args[0].url

        if (url.includes('SpinRequest') || url.includes('game-api')) {
          // Made the API check more specific
          clonedResponse.text().then((text) => {
            try {
              const data = JSON.parse(text)
              updateDebugWindow(data)
            } catch (e) {
              // Do not log non-JSON responses to avoid clutter
            }
          })
        }
        return response
      })
    }
  })
</script>
