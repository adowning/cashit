<script setup>
  import { router } from '@/router'
  import { useAuthStore } from '@/stores/auth.store'
  import { useTransactionStore } from '@/stores/transaction.store'

  const authStore = useAuthStore()
  const depositStore = useTransactionStore()
  const {
    isAuthenticated, // Computed property from authStore (single source of truth)
    currentUser, // isLoading: authLoading, // If you need to show auth-specific loading in App.vue
    // error: authError, // Auth store errors
  } = storeToRefs(authStore)
  // const {
  //   currentUser, // State from userStore
  //   // isLoading: userLoading, // If you need to show user-specific loading in App.vue
  //   // error: userError, // User store errors
  // } = storeToRefs(userStore);
  // const isAuthenticated = computed(() => authenticated.loggedIn);
</script>

<template>
  <div
    class="mobile-section grow-1 relative m-0 flex h-screen min-h-screen w-screen flex-col justify-start align-start items-start overflow-hidden p-0"
  >
    <ShowToasts />

    <TopBarMobile
      v-if="
        isAuthenticated &&
        !depositStore.shopOpen &&
        currentUser != undefined &&
        currentUser !== null
      "
    />

    <slot />
    <FooterBarMobile
      v-if="
        isAuthenticated &&
        !depositStore.shopOpen &&
        !router.currentRoute.value.path.includes('/battles') &&
        !depositStore.shopOpen &&
        currentUser != undefined &&
        currentUser !== null
      "
    />
  </div>
</template>
<style scoped>
  .mobile-section {
    /* Background image from URL provided by user */
    background-image: url('/images/starsbg.png');
    background-size: cover; /* Cover the entire viewport */
    background-position: center; /* Center the background image */
    /* background-repeat: no-repeat;  */
    min-height: 100vh; /* Make sure the body takes at least the full viewport height */
    font-family: 'Roboto', sans-serif; /* Apply a default sans-serif font */
    /* Flexbox utilities to center the game area on the page */
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    margin: auto;
    padding: 0; /* Reduced padding slightly for larger game area */
  }
</style>
