<script lang="ts" setup>
  const display = ref(true)
  const shakeIt = ref(false)

  // Define emits for carousel scrolling
  const emit = defineEmits<{
    scrollLeft: []
    scrollRight: []
  }>()

  // Handle arrow clicks
  const handleScrollLeft = () => {
    emit('scrollLeft')
  }

  const handleScrollRight = () => {
    emit('scrollRight')
  }
</script>

<template>
  <!-- <div class="animate__animated animate__slideInUp"> -->
  <div class="flex flex-row justify-center m-0" style="max-width: fit-content; margin-inline: auto">
    <div
      v-show="display"
      class="basis-1/2 animate__animated animate__slideInUp flex"
      style="
        background-color: white !important;
        z-index: 21;
        background-repeat: no-repeat;
        background-color: transparent;
        justify-content: center;
        max-height: 50px;
        align-items: center;
      "
    >
      <img
        src="/images/filterbar/side-arrow-prev.avif"
        class="mr-2 flex cursor-pointer"
        style="text-align: center"
        @click="handleScrollLeft"
      />
      <div class="animate__animated animate__slideInUp bottomDropper ml-2 flex p-0">
        <AllIcon :shake="shakeIt" />
      </div>
      <div class="animate__animated animate__slideInUp bottomDropper flex p-0">
        <FishIcon :shake="shakeIt" />
      </div>
      <div class="animate__animated animate__slideInUp bottomDropper flex p-0">
        <SlotsIcon :shake="shakeIt" />
      </div>
      <div
        class="animate__animated animate__slideInUp bottomDropper flex justify-center align-middle"
      />
      <img
        src="/images/filterbar/side-arrow.avif"
        class="ml-2 flex cursor-pointer"
        style="text-align: center"
        @click="handleScrollRight"
      />
    </div>
  </div>
</template>

<style scoped>
  .bottomDropper {
    --animate-duration: 0.3s;
  }

  .div --active {
    /* color: var(--div -active-color); */
    background-color: transparent;
  }

  .div --active {
    /* color: var(--div -active-color); */
    background-color: transparent;
    margin-top: 5px;
  }

  .van-tabbar {
    height: 42px;
    font-family: 'bungeecolor';
  }
</style>
