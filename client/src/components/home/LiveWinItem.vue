<template>
  <div class="w-[190px] live-card">
    <div class="flex flex-row">
      <div class="flex">
        <img class="w-[60px] h-[70px] rounded" :src="gameImage" alt="user image" />
      </div>
      <div class="flex flex-col ml-2 my-1 justify-between items-start">
        <div
          class="flex flex-row text-[#F5F5F5] text-[14px] font-bold ellipsis items-center"
          style="line-height: 0.8"
        >
          <div class="color-white-800 font-bold text-lg" style="color: whiteff">
            {{ userName.substring(0, 6) }}
          </div>
          <div class="font-thin text-gray-300">&nbsp; won</div>
        </div>
        <div class="flex justify-start items-center gap-1">
          <!-- <div class="flex text-[#F5F5F5] text-[14px] font-bold" style="line-height: 1"> -->
          <img src="../../assets/img/icons/coin.svg" height="25" />
          <div class="text-yellow-300 font-bold text-lg">{{ amount }}</div>
          <!-- </div> -->
        </div>
        <!-- <div class="text-[#F5F5F5] text-[14px] font-bold ellipsis" style="line-height: 0.8">
          {{ gameName.replace('RTG').replace('NLC').replace('NG').replace('NET').replace('CQ9') }}
        </div> -->
      </div>
    </div>
  </div>
</template>
<style scoped>
  .live-card {
    background: var(--maz-bg-color-dark);
    border-radius: 12px;
    border-color: var(--maz-bg-color-dark-light);
    border-style: solid;
    border-width: 1px;
    border-left-width: 0px;
    padding: 0px;
    margin: 2px;
  }
  .ellipsis {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    width: 120px; /* or max-width: 200px */
  }
</style>
<script setup lang="ts">
  const { textarea, input } = useTextareaAutosize()
  const props = defineProps<{
    amount: string
    userName: string
    gameName: string
    gameImage: string
  }>()
  const userName = ref(props.userName)
</script>
