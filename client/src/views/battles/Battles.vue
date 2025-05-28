<template>
  <div class="battles">
    <div class="battles-header">
      <BattlesHeaderOverview v-if="battlesGetRouteName === 'BattlesOverview'" />
      <BattlesHeaderCreate v-else-if="battlesGetRouteName === 'BattlesCreate'" />
      <BattlesHeaderGame v-else-if="battlesGetRouteName === 'BattlesGame'" />
    </div>
    <div class="battles-content">
      <transition name="slide-fade" mode="out-in">
        <!-- <router-view v-bind:key="$route.fullPath" /> -->
        <slot v-bind:key="$route.fullPath" />
      </transition>
    </div>
  </div>
</template>

<script setup>
  import BattlesHeaderOverview from '@/components/battles/BattlesHeaderOverview.vue'
  import BattlesHeaderCreate from '@/components/battles/BattlesHeaderCreate.vue'
  import BattlesHeaderGame from '@/components/battles/BattlesHeaderGame.vue'
  import { computed } from 'vue'
  import { router } from '@/router'

  const tournamentStore = useTournamentStore()

  // Computed
  const battlesGetRouteName = computed(() => {
    return 'BattlesOverview'
  })
  tournamentStore.subscribeToTournamentUpdates()
  tournamentStore.subscribeToGeneralTournamentAnnouncements()
  // Methods

  // Created
  // this.socketConnectBattles()
</script>

<style scoped>
  .battles {
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 50px 10px;
    background: linear-gradient(
      180deg,
      rgba(255, 255, 255, 0.1) 0%,
      rgba(255, 255, 255, 0.05) 100%
    );
  }

  .battles .battles-header {
    width: 1250px;
    border-bottom: 1px solid rgba(28, 71, 182, 0.15);
  }

  .battles .battles-content {
    width: 1250px;
    margin-top: 20px;
  }

  @media only screen and (max-width: 1270px) {
    .battles .battles-header {
      width: 100%;
    }

    .battles .battles-content {
      width: 100%;
    }
  }
</style>
