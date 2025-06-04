<script setup lang="ts">
  const { isMobile } = useMonitor()
  const eventBus = useEventManager()
  const settingsModal = ref(false)
  const gameStore = useGameStore()
  const { gameSearchList } = storeToRefs(gameStore)

  // Reference to the GameCarousel component
  const gameCarouselRef = ref()

  eventBus.on('settingsModal', (val) => {
    console.log('x')
    settingsModal.value = val
  })

  // Handle scroll events from FilterBar
  const handleScrollLeft = () => {
    if (gameCarouselRef.value) {
      gameCarouselRef.value.scrollLeft()
    }
  }

  const handleScrollRight = () => {
    if (gameCarouselRef.value) {
      gameCarouselRef.value.scrollRight()
    }
  }
</script>
<template>
  <BackGround />
  <LiveWin />
  <GameCarousel
    ref="gameCarouselRef"
    v-if="gameSearchList !== undefined && gameSearchList?.items.length > 0"
    :style="`${isMobile ? 'margin-top: 0px' : 'margin-top: 20px'}`"
  />
  <FilterBar @scroll-left="handleScrollLeft" @scroll-right="handleScrollRight" />
  <AdCarousel />
  <SettingsView :has-cancel="false" :model-value="settingsModal" />
  <!-- <Vip /> -->
</template>
<style scoped></style>
