<template>
  <div id="app" class="roxdisplay">
    <!-- <Transition name="fade-loader"> -->
    <div
      v-if="isConnected"
      style="z-index: 999999; position: absolute; top: -2px; right: -6px; width: 25px"
    >
      <img src="/images/common/connection-high.svg" h="10" w="15" @click="runTest" />
    </div>
    <div v-else style="z-index: 999999; position: absolute; top: -2px; right: -6px; width: 25px">
      <img src="/images/common/connection-off.png" h="10" w="15" />
    </div>
    <div class="animate__animated animate__fadeIn">
      <GlobalLoading v-if="isAppLoading && isMobile" />
    </div>

    <div v-if="!isAppLoading">
      <!-- Content shown after loading is complete -->
      <div v-if="isAuthenticated && currentUser">
        <DesktopSection v-if="!isMobile">
          <div class="animate__animated animate__fadeIn">
            <GlobalLoading v-if="isAppLoading" />
          </div>

          <RouterView />
        </DesktopSection>
        <MobileSection v-if="isMobile">
          <RouterView />
        </MobileSection>
      </div>
      <!-- Fallback to LoginView if not authenticated or user data not available after initial checks -->
      <div v-else>
        <DesktopSection v-if="!isMobile">
          <LoginView />
        </DesktopSection>
        <MobileSection v-if="isMobile">
          <LoginView />
        </MobileSection>
      </div>
    </div>
  </div>

  <OverlayLayer v-if="depositStore.shopOpen" :model-value="depositStore.shopOpen">
    <ShopView v-if="depositStore.shopOpen" />
  </OverlayLayer>
  <OverlayLayer v-if="tournamentStore.isBattlesOpen" :model-value="tournamentStore.isBattlesOpen">
    <FunRizeRaces v-if="tournamentStore.isBattlesOpen" />
  </OverlayLayer>
</template>

<script setup lang="ts">
  import { ref, onMounted, computed, watch, nextTick } from 'vue'
  import { storeToRefs } from 'pinia'
  import { useRouter } from 'vue-router'
  import LoginView from '@/views/auth/LoginView.vue' // Explicit import for view
  import FunRizeRaces from '@/components/battles/FunRizeRaces.vue' // Explicit import for view

  // Pinia Stores
  import { useAuthStore } from '@/stores/auth.store'
  import { useTransactionStore } from '@/stores/transaction.store'
  import { useImageLoadingStore } from '@/stores/imageLoading.store'
  // import { useVipStore } from '@/stores/vip.store'
  import { useGameStore } from '@/stores/game.store'
  import { useMonitor } from '@/composables/useMonitor'
  import { orpcManager } from './utils/orpc.client'

  //

  // Optional: Utility function to hide a very early, non-Vue loading screen (e.g., from index.html)
  // import { loadingFadeOut } from '@/utils/initialLoader';

  // --- Initialize Stores ---
  const authStore = useAuthStore()
  const depositStore = useTransactionStore()
  const imageLoadingStore = useImageLoadingStore()
  const tournamentStore = useTournamentStore()
  const router = useRouter()

  // --- Composables ---
  const { isMobile } = useMonitor()

  // --- Configuration ---
  const MIN_LOADING_DISPLAY_TIME_MS = 700 // Minimum time the loader should be visible (in milliseconds)

  // --- Reactive State from Stores ---
  const { isAuthenticated, currentUser, initialAuthCheckComplete } = storeToRefs(authStore)
  const { areImagesLoading, initialScanPerformedOnView } = storeToRefs(imageLoadingStore)

  // --- Internal Loading State Management for Minimum Display Time ---
  const underlyingOperationsLoading = computed(() => {
    // Condition 1: Initial authentication check is pending.
    if (!initialAuthCheckComplete.value) return true
    // Condition 2: Authenticated, but currentUser data (from authStore) is pending.
    if (isAuthenticated.value && !currentUser.value) return true
    // Condition 3: The first image scan for the current view hasn't completed yet.
    if (!initialScanPerformedOnView.value) return true
    // Condition 4: Images are actively loading.
    if (areImagesLoading.value) return true

    return false // All clear
  })
  const { status, connect } = useAppWebSocket()
  const isConnected = computed(() => status.value === 'OPEN')

  const showLoaderDueToMinTime = ref(false)
  let loadingStartTime: number | null = null
  let minTimeTimeoutId: ReturnType<typeof setTimeout> | null = null

  // --- Final Computed Property for GlobalLoading v-if ---
  const isAppLoading = computed(() => {
    return underlyingOperationsLoading.value || showLoaderDueToMinTime.value
  })
  function runTest() {
    const { sendTypedMessage } = useAppWebSocket()
    //  type = 'info'
    // meta = {} // Changed line: Use the schema type directly
    // payload?: ZodTypeAny)

    sendTypedMessage('info', { data: 'data' }, {})
  }
  watch(
    underlyingOperationsLoading,
    (isLoadingNow, wasLoadingBefore) => {
      if (isLoadingNow && !wasLoadingBefore) {
        // Operations just started loading
        loadingStartTime = Date.now()
        showLoaderDueToMinTime.value = false // Reset any pending min time hold
        if (minTimeTimeoutId) {
          clearTimeout(minTimeTimeoutId)
          minTimeTimeoutId = null
        }
        // Loader will show because underlyingOperationsLoading is true
      } else if (!isLoadingNow && wasLoadingBefore) {
        // Operations just finished loading
        if (loadingStartTime) {
          const elapsedTime = Date.now() - loadingStartTime
          if (elapsedTime < MIN_LOADING_DISPLAY_TIME_MS) {
            const remainingTime = MIN_LOADING_DISPLAY_TIME_MS - elapsedTime
            showLoaderDueToMinTime.value = true // Keep loader visible to meet min time
            minTimeTimeoutId = setTimeout(() => {
              showLoaderDueToMinTime.value = false
              minTimeTimeoutId = null
            }, remainingTime)
          } else {
            // Minimum time already met, no need to hold
            showLoaderDueToMinTime.value = false
          }
        }
        loadingStartTime = null // Reset for the next loading cycle
      }
    },
    { immediate: true }
  ) // `immediate: true` ensures this runs on mount to set initial state

  // --- Initial App Bootstrap ---
  onMounted(async () => {
    console.log('App.vue onMounted: Initializing authentication...')
    await authStore.initializeAuth()
    const client = orpcManager.getRestClient() // Ensure the client is initialized
    // const mutation = useMutation(
    //   client.todo.create.mutationOptions({
    //     context: { cache: true }, // Provide client context if needed
    //     // additional options...
    //   })
    // )
    // )
    // mutation.mutate({ text: 'New Task' })
    // client.todo.getAll.queryOptions()
    // If you have a static loader in index.html, you might hide it here:
    // loadingFadeOut();
  })

  // --- Watch for route changes to re-trigger image loading check ---
  watch(
    () => router.currentRoute.value,
    async (newRoute, oldRoute) => {
      // Trigger on actual path change or on initial load (where oldRoute might be undefined)
      if (newRoute.path !== oldRoute?.path || oldRoute === undefined) {
        console.log(
          `App.vue Route Watcher: Route changed to ${newRoute.path}. Resetting and checking images.`
        )
        imageLoadingStore.resetImageLoadingState() // This sets initialScanPerformedOnView to false

        await nextTick() // Wait for the DOM of the new route to be updated
        imageLoadingStore.trackImagesInView() // This will scan and set initialScanPerformedOnView to true
      }
    },
    { deep: true, immediate: true } // `immediate: true` ensures this runs on initial load
  )

  // --- Watch for authentication state changes for side effects like navigation ---
  watch(
    isAuthenticated,
    async (isNowAuthenticated) => {
      console.log(`App.vue Auth Watcher: isAuthenticated changed to ${isNowAuthenticated}.`)
      if (isNowAuthenticated) {
        if (!isConnected) {
          console.log('App.vue Auth Watcher: Connecting to socket server')
          await connect()
        }
        // If user becomes authenticated and is on the Login page, redirect to Home
        if (router.currentRoute.value.name === 'Login') {
          router.push({ name: 'Home' })
        }
      } else {
        // If user becomes unauthenticated (and initial auth check is complete)
        // and is on a route that requires auth, redirect to Login.
        if (initialAuthCheckComplete.value && router.currentRoute.value.meta.requiresAuth) {
          router.push({ name: 'Login' })
        }
      }
    }
    // `immediate: true` is generally not needed here if authStore.initializeAuth() and route guards handle initial state.
  )

  // --- Fetch initial data that depends on the user being loaded ---
  watch(
    currentUser,
    async (user) => {
      if (user) {
        try {
          console.log(
            'App.vue User Watcher: currentUser is available. Fetching user-specific data.'
          )
          const vipStore = useVipStore()
          const gameStore = useGameStore()
          await vipStore.dispatchVipInfo()
          await gameStore.dispatchGameBigWin()
          await gameStore.dispatchGetAllGames()
          await connect()
        } catch (e) {
          console.log(e)
        }
        // Potentially other data fetching dependent on the user
      }
    },
    { immediate: true } // Run immediately if currentUser is already populated (e.g., from persisted state)
  )

  // Example for `loadingFadeOut` if you were using a static HTML loader:
  // const loadingFadeOut = () => {
  //   const loader = document.getElementById('initial-static-loader');
  //   if (loader) {
  //     loader.style.opacity = '0';
  //     setTimeout(() => loader.remove(), 300); // Fade out then remove
  //   }
  // };
</script>

<style>
  /* Global styles */
  #app {
    color: white; /* Example global style */
    /* Add other global application container styles here, e.g., min-height, display: flex, etc. */
  }

  .error-message {
    position: fixed;
    bottom: 20px;
    left: 50%;
    transform: translateX(-50%);
    background-color: red;
    color: white;
    padding: 10px 20px;
    border-radius: 5px;
    z-index: 10000; /* Ensure it's above other content */
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  }

  /* Transition for the Global Loader */
  .fade-loader-enter-active,
  .fade-loader-leave-active {
    transition: opacity 0.3s ease; /* Duration and easing for fade */
  }

  .fade-loader-enter-from,
  .fade-loader-leave-to {
    opacity: 0;
  }
  :root {
    --maz-color-primary-50: hsl(210deg 100% 95%);
    --maz-color-primary-100: hsl(210deg 100% 87%);
    --maz-color-primary-200: hsl(210deg 100% 79%);
    --maz-color-primary-300: hsl(210deg 100% 71%);
    --maz-color-primary-400: hsl(210deg 100% 64%);
    --maz-color-primary: hsl(210deg 100% 56%);
    --maz-color-primary-600: hsl(210deg 79% 46%);
    --maz-color-primary-700: hsl(210deg 78% 36%);
    --maz-color-primary-800: hsl(210deg 79% 26%);
    --maz-color-primary-900: hsl(210deg 79% 17%);
    --maz-color-primary-alpha: hsl(210deg 100% 56% / 60%);
    --maz-color-primary-alpha-20: hsl(210deg 100% 56% / 20%);
    --maz-color-primary-alpha-10: hsl(210deg 100% 56% / 10%);
    --maz-color-primary-alpha-05: hsl(210deg 100% 56% / 05%);
    --maz-color-primary-contrast: hsl(0deg 0% 100%);

    --maz-color-secondary-50: hsl(164deg 65% 93%);
    --maz-color-secondary-100: hsl(164deg 66% 84%);
    --maz-color-secondary-200: hsl(164deg 66% 75%);
    --maz-color-secondary-300: hsl(164deg 66% 65%);
    --maz-color-secondary-400: hsl(164deg 66% 56%);
    --maz-color-secondary: hsl(164deg 76% 46%);
    --maz-color-secondary-600: hsl(164deg 76% 38%);
    --maz-color-secondary-700: hsl(164deg 77% 30%);
    --maz-color-secondary-800: hsl(164deg 77% 22%);
    --maz-color-secondary-900: hsl(164deg 77% 14%);
    --maz-color-secondary-alpha: hsl(164deg 76% 46% / 60%);
    --maz-color-secondary-alpha-20: hsl(164deg 76% 46% / 20%);
    --maz-color-secondary-alpha-10: hsl(164deg 76% 46% / 10%);
    --maz-color-secondary-alpha-05: hsl(164deg 76% 46% / 05%);
    --maz-color-secondary-contrast: hsl(0deg 0% 100%);

    --maz-color-info-50: hsl(188deg 53% 93%);
    --maz-color-info-100: hsl(188deg 54% 82%);
    --maz-color-info-200: hsl(188deg 53% 72%);
    --maz-color-info-300: hsl(188deg 53% 61%);
    --maz-color-info-400: hsl(188deg 53% 51%);
    --maz-color-info: hsl(188deg 78% 41%);
    --maz-color-info-600: hsl(188deg 78% 34%);
    --maz-color-info-700: hsl(188deg 78% 26%);
    --maz-color-info-800: hsl(188deg 78% 19%);
    --maz-color-info-900: hsl(188deg 77% 12%);
    --maz-color-info-alpha: hsl(188deg 78% 41% / 60%);
    --maz-color-info-alpha-20: hsl(188deg 78% 41% / 20%);
    --maz-color-info-alpha-10: hsl(188deg 78% 41% / 10%);
    --maz-color-info-alpha-05: hsl(188deg 78% 41% / 05%);
    --maz-color-info-contrast: hsl(0deg 0% 100%);

    --maz-color-success-50: hsl(80deg 63% 94%);
    --maz-color-success-100: hsl(80deg 61% 85%);
    --maz-color-success-200: hsl(80deg 60% 76%);
    --maz-color-success-300: hsl(80deg 61% 68%);
    --maz-color-success-400: hsl(80deg 61% 59%);
    --maz-color-success: hsl(80deg 61% 50%);
    --maz-color-success-600: hsl(80deg 61% 41%);
    --maz-color-success-700: hsl(80deg 60% 33%);
    --maz-color-success-800: hsl(80deg 60% 24%);
    --maz-color-success-900: hsl(80deg 61% 15%);
    --maz-color-success-alpha: hsl(80deg 61% 50% / 60%);
    --maz-color-success-alpha-20: hsl(80deg 61% 50% / 20%);
    --maz-color-success-alpha-10: hsl(80deg 61% 50% / 10%);
    --maz-color-success-alpha-05: hsl(80deg 61% 50% / 05%);
    --maz-color-success-contrast: hsl(210deg 8% 14%);

    --maz-color-warning-50: hsl(40deg 100% 95%);
    --maz-color-warning-100: hsl(40deg 97% 88%);
    --maz-color-warning-200: hsl(40deg 98% 81%);
    --maz-color-warning-300: hsl(40deg 97% 73%);
    --maz-color-warning-400: hsl(40deg 98% 66%);
    --maz-color-warning: hsl(40deg 97% 59%);
    --maz-color-warning-600: hsl(40deg 68% 49%);
    --maz-color-warning-700: hsl(40deg 67% 38%);
    --maz-color-warning-800: hsl(40deg 68% 28%);
    --maz-color-warning-900: hsl(40deg 67% 18%);
    --maz-color-warning-alpha: hsl(40deg 97% 59% / 60%);
    --maz-color-warning-alpha-20: hsl(40deg 97% 59% / 20%);
    --maz-color-warning-alpha-10: hsl(40deg 97% 59% / 10%);
    --maz-color-warning-alpha-05: hsl(40deg 97% 59% / 05%);
    --maz-color-warning-contrast: hsl(217deg 19% 27%);

    --maz-color-danger-50: hsl(1deg 100% 96%);
    --maz-color-danger-100: hsl(1deg 100% 91%);
    --maz-color-danger-200: hsl(2deg 100% 86%);
    --maz-color-danger-300: hsl(1deg 100% 81%);
    --maz-color-danger-400: hsl(1deg 100% 76%);
    --maz-color-danger: hsl(1deg 100% 71%);
    --maz-color-danger-600: hsl(1deg 58% 58%);
    --maz-color-danger-700: hsl(1deg 41% 46%);
    --maz-color-danger-800: hsl(1deg 42% 34%);
    --maz-color-danger-900: hsl(1deg 41% 21%);
    --maz-color-danger-alpha: hsl(1deg 100% 71% / 60%);
    --maz-color-danger-alpha-20: hsl(1deg 100% 71% / 20%);
    --maz-color-danger-alpha-10: hsl(1deg 100% 71% / 10%);
    --maz-color-danger-alpha-05: hsl(1deg 100% 71% / 05%);
    --maz-color-danger-contrast: hsl(0deg 0% 100%);

    /* WHITE */
    --maz-color-white: hsl(0deg 0% 100%);
    --maz-color-white-contrast: hsl(0deg 0% 0%);

    /* BLACK */
    --maz-color-black: hsl(0deg 0% 0%);
    --maz-color-black-contrast: hsl(0deg 0% 100%);

    /** TEXT COLOR LIGHT **/
    --maz-color-text-light: hsl(0deg 0% 85%);
    --maz-color-muted-light: hsl(0deg 0% 0% / 54%);

    /** TEXT COLOR DARK **/
    /* --maz-color-text-dark: hsl(210deg 8% 14%); */
    --maz-color-text-dark: #f805af;
    --maz-color-muted-dark: #f805af79;

    /** BG OVERLAY **/
    --maz-bg-overlay: hsl(0deg 0% 0% / 30%);

    /** BG LIGHT COLOR **/
    --maz-bg-color-light-lighter: hsl(0deg 0% 97%);
    --maz-bg-color-light-light: hsl(0deg 0% 94%);
    --maz-bg-color-light: hsl(0deg 0% 100%);
    --maz-bg-color-light-dark: hsl(0deg 0% 91%);
    --maz-bg-color-light-darker: hsl(0deg 0% 88%);

    /** BG DARK COLOR **/
    --maz-bg-color-dark-lighter: #7133f7;
    --maz-bg-color-dark-light: #662fe1;
    --maz-bg-color-dark: #0e0449;
    --maz-bg-color-dark-dark: #0e1246;
    --maz-bg-color-dark-darker: #080b2a;
    /**
  * Border of components
  **/
    --maz-border-color: hsl(220deg 13.04% 90.98%);

    /**
  * DEFAULT BORDER WIDTH (0.063rem = 1px with a font-size base of 16px)
  **/
    --maz-border-width: 0.063rem;

    /**
  * DEFAULT BORDER RADIUS (0.7rem = 11.2px with a font-size base of 16px)
  **/
    --maz-border-radius: 2rem;

    /**
  * FONT FAMILY
  * Not used in the library --> Use this variable on your <html> element (optional)
  **/
    --maz-font-family:
      system-ui, -apple-system, blinkmacsystemfont, 'Segoe UI', roboto, oxygen, ubuntu, cantarell,
      'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif;
  }

  /* Ensure your layout components like DesktopSection and MobileSection fill the viewport as needed */
  /* Add any necessary global styles for .roxdisplay or other root elements */
</style>
