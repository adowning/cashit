<template>
  <div v-if="!error" style="width: 100vw; height: 100vh">
    <NolimitGameLoader :options="gameLaunchOptions" />
  </div>
  <div v-else class="flex items-center justify-center h-screen">
    <p class="text-red-500 text-2xl">Game name is missing in the URL.</p>
  </div>
</template>

<script setup lang="ts">
  import { ref, reactive, onMounted } from 'vue'
  import NolimitGameLoader from '@/components/games/NolimitGameLoader.vue'
  import { useRouteQuery } from '@vueuse/router'
  import { useAuthStore } from '@/stores/auth.store'
  import { NolimitGameLaunchOptions } from 'shared'
  defineProps<{
    gameName: string
  }>()

  const error = ref(false)
  const authStore = useAuthStore()

  // Define the structure of the launch options

  const gameName = useRouteQuery('gameName', '') // Get gameName from URL query, e.g., /nolimit-game?gameName=Tombstone

  // Correctly typed, reactive game launch options
  const gameLaunchOptions = reactive<NolimitGameLaunchOptions>({
    gameName: '',
    user: {
      id: '',
    },
  })

  onMounted(() => {
    if (!gameName.value) {
      error.value = true
      return
    }
    if (!authStore.currentUser?.id) {
      error.value = true
      console.error('User is not authenticated or user ID is missing.')
      // Optionally redirect to login
      return
    }

    // Populate the launch options once we know the data is valid
    gameLaunchOptions.gameName = gameName.value as string
    gameLaunchOptions.user.id = authStore.currentUser.id
  })
</script>
