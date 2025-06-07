<template>
  <div class="nolimit-game-container w-full h-full">
    <div v-if="isLoading" class="absolute inset-0 flex items-center justify-center bg-black z-50">
      <div
        class="animate-spin rounded-full h-16 w-16 border-t-4 border-b-4 border-purple-500"
      ></div>
      <p class="ml-4 text-white text-xl">Loading {{ options?.gameName }}...</p>
    </div>

    <iframe
      v-if="iframeUrl"
      :src="iframeUrl"
      ref="gameIframe"
      frameborder="0"
      scrolling="no"
      allowfullscreen
      class="w-full h-full"
      @load="onIframeLoad"
      @error="onIframeError"
      title="Nolimit Game"
    ></iframe>

    <div
      v-if="loadError"
      class="absolute inset-0 flex flex-col items-center justify-center bg-gray-800 text-white p-4"
    >
      <p class="text-xl text-red-500 mb-4">Failed to load Nolimit game.</p>
      <p class="text-sm text-gray-400 mb-2">{{ loadErrorMessage }}</p>
      <button
        @click="retryLoadGame"
        class="bg-purple-600 hover:bg-purple-700 text-white font-semibold py-2 px-4 rounded"
      >
        Retry
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { ref, computed, onMounted, onUnmounted, watch, type PropType } from 'vue'
  import { useAuthStore } from '@/stores/auth.store' // Assuming you use this for user data
  import { useNotificationStore } from '@/stores/notification.store'
  import { useEventManager } from '@/composables/EventManager'
  const eventBus = useEventManager()
  // Define the shape of the launch options expected from the parent
  interface NolimitGameLaunchOptions {
    gameName: string
    // The user object that the Nolimit loader expects
    user: {
      id: string | number
      // ... any other user properties your loader might need
    }
  }

  const props = defineProps({
    options: {
      type: Object as PropType<NolimitGameLaunchOptions>,
      required: true,
    },
  })

  const authStore = useAuthStore()
  const notificationStore = useNotificationStore()
  const gameIframe = ref<HTMLIFrameElement | null>(null)
  const isLoading = ref<boolean>(true)
  const loadError = ref<boolean>(false)
  const loadErrorMessage = ref<string>('')
  // const queryParams = new useRouteQuery()
  const gameName = useRouteQuery('gameName')
  // params.set('gameName', props.options.gameName)

  // Construct the iframe URL with necessary query parameters
  const iframeUrl = computed(() => {
    if (!gameName) {
      loadError.value = true
      loadErrorMessage.value = 'Game Name is missing in options.'
      return null
    }
    if (!currentUser.id) {
      loadError.value = true
      loadErrorMessage.value = 'User information is missing.'
      return null
    }

    // The Nolimit loader expects the user object as a JSON string
    // params.set('user', JSON.stringify(props.options.user))

    return `/nolimit_loader_template.html?${params.toString()}`
  })

  const onIframeLoad = () => {
    console.log('netgame iframe loaded...')
    isLoading.value = false
    loadError.value = false
    console.log(`Nolimit Game Iframe loaded for: ${props.options.gameName}`)
    notificationStore.addNotification('info', `Game "${props.options.gameName}" loaded.`)
    eventBus.emit('hideBottomBar')
  }

  const onIframeError = (event: Event) => {
    isLoading.value = false
    loadError.value = true
    loadErrorMessage.value = `The game frame failed to load. Check browser console for details.`
    console.error('Nolimit Game Iframe load error:', event)
    notificationStore.addNotification('error', `Error loading game: ${props.options.gameName}`)
  }

  const retryLoadGame = () => {
    loadError.value = false
    isLoading.value = true
    if (gameIframe.value && iframeUrl.value) {
      // Add a cache-busting parameter to force a reload
      gameIframe.value.src = `${iframeUrl.value}&retry=${Date.now()}`
    }
  }

  // --- Communication from Iframe to Parent ---
  const handleGameMessage = (event: MessageEvent) => {
    // IMPORTANT: In production, you should verify event.origin
    // if (event.origin !== 'https://your-game-domain.com') return;

    const data = event.data
    if (data && data.event) {
      switch (data.event) {
        case 'nolimit_balance':
          console.log('Received balance update from game:', data.data)
          // Assuming your authStore has a method to update balance
          // authStore.updateBalance(data.data);
          notificationStore.addNotification('success', `Balance updated: ${data.data}`)
          break
        case 'nolimit_ready':
          console.log('Nolimit game reported it is ready.')
          break
        case 'nolimit_message':
          console.log('Received message from game:', data.data)
          break
      }
    }
  }

  onMounted(() => {
    window.addEventListener('message', handleGameMessage)
  })

  onUnmounted(() => {
    window.removeEventListener('message', handleGameMessage)
  })

  // Watch for changes in gameName to reload the component
  watch(
    () => props.options.gameName,
    (newName, oldName) => {
      if (newName && oldName && newName !== oldName) {
        console.log('Game changed, reloading...')
        isLoading.value = true
        loadError.value = false
        // The computed iframeUrl will update automatically, triggering the iframe to reload.
      }
    }
  )
</script>

<style scoped>
  .nolimit-game-container {
    position: relative;
    width: 100%;
    height: 100%;
    background-color: #000;
  }
</style>
