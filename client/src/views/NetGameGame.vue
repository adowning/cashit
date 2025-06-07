<template>
  <div style="width: 100vw; height: 100vh">
    <GameLoader
      :options="`url:https://slots.cashflowcasino.com/netgame?gameName=${gameName}&token=${token}`"
    />
  </div>
</template>

<script setup lang="ts">
  import { NetGameOptions } from 'shared'
  import { ref, reactive, onMounted } from 'vue'
  const authStore = useAuthStore()
  const { accessToken: token } = storeToRefs(authStore)
  defineProps<{
    gameName: {
      type: string
      required: true
    }
  }>()
  // import { useAuthStore } from '@/stores/auth.store'
  // const netGameOptions = reactive<NetGameOptions>({
  //   gameName,
  //   token,
  //   url: `https:/slots.cashflowcasino.com/netgame?gameName=${gameName}&token=${token}`,
  // })

  onMounted(() => {})
</script>
