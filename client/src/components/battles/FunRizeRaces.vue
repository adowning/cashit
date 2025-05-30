// main.js or similar entry file (ensure you have these imports) // import { createApp } from 'vue'
// import App from './App.vue' // import './index.css' // Your Tailwind CSS import // import {
createPinia } from 'pinia' // const pinia = createPinia() // const app = createApp(App) //
app.use(pinia) // app.mount('#app') // --- FunrizeRacesView.vue --- // This is the main container
for the tournaments/races page. // It will fetch and display different sections of tournaments. //
SFC: FunrizeRacesView.vue
<template>
  <div class="bg-[#080b2a] min-h-screen text-white font-sans">
    <!-- <header class="p-4 flex justify-between items-center bg-slate-800/50 sticky top-0 z-50">
      <img
        src="https://placehold.co/100x40/7c3aed/white?text=FUNRIZE&font=Inter"
        alt="Funrize Logo"
        class="h-8"
      />
      <div class="flex items-center space-x-3">
        <div class="bg-green-500/20 text-green-300 px-3 py-1 rounded-lg text-sm flex items-center">
          <span class="mr-1">💰</span> 0.00
        </div>
        <div
          class="bg-purple-500/20 text-purple-300 px-3 py-1 rounded-lg text-sm flex items-center"
        >
          <span class="mr-1">💎</span> 59,070
        </div>
        <button class="bg-pink-600 hover:bg-pink-700 px-6 py-2 rounded-lg text-sm font-semibold">
          BUY
        </button>
      </div>
    </header> -->

    <main class="p-4 pb-24 pt-20 overflow-y-auto h-[100vh]">
      <!-- <div class="mb-4">
        <button class="text-gray-400 hover:text-white flex items-center">
          <ChevronLeftIcon class="h-5 w-5 mr-1" />
          Home
        </button>
      </div> -->
      <h1 class="text-3xl font-bold mb-6">Funrize Races</h1>

      <FeaturedTournamentCard :tournament="featuredTournament" class="mb-8" />

      <div class="flex space-x-2 mb-6 justify-center">
        <MazTabs v-model="currentTab">
          <MazTabsBar :items="tabs" style="color: pink !important; padding: 4px" />
          <template #item="{ item, index, active }">
            <!-- <MazBadge size="0.6rem" rounded-size="full" :color="active ? 'primary' : 'gray'">
            </MazBadge> -->
            <div style="line-height: 1; font-size: 1rem">
              {{ item.label }}
            </div>
          </template>
          <!-- <MazTabsContent> -->
          <!-- <MazTabsContentItem :tab="1" class="maz-py-4"> FULL SCHEDULE </MazTabsContentItem>
            <MazTabsContentItem :tab="2" class="maz-py-4"> FINISHED </MazTabsContentItem> -->
          <!-- </MazTabsContent> -->
        </MazTabs>
      </div>
      <div v-if="currentTab === 1" class="animate__animated animate__fadeIn">
        <TournamentList
          title="RIGHT NOW"
          :tournaments="activeTournaments"
          @show-leaderboard="showLeaderboard"
          @show-how-it-works="showHowItWorks"
          @join-tournament="handleJoinTournament"
        />
        <TournamentList
          title="UP NEXT"
          :tournaments="upcomingTournaments"
          @show-how-it-works="showHowItWorks"
          @join-tournament="handleJoinTournament"
          class="mt-8"
        />
        <TournamentList
          title="LATER"
          :tournaments="laterTournaments"
          @show-how-it-works="showHowItWorks"
          @join-tournament="handleJoinTournament"
          class="mt-8"
        />
      </div>

      <div v-if="currentTab === 2" class="animate__animated animate__fadeIn">
        <TournamentList
          title="RECENTLY FINISHED"
          :tournaments="finishedTournaments"
          :is-finished-list="true"
          @show-leaderboard="showLeaderboard"
          class="mt-8"
        />
      </div>
    </main>

    <div class="fixed bottom-20 right-4 z-40 md:bottom-6 md:right-6">
      <button
        class="bg-yellow-500 text-slate-900 p-3 rounded-full shadow-lg relative animate-pulse"
      >
        <GiftIcon class="h-8 w-8" />
        <span
          class="absolute -top-1 -right-1 bg-red-600 text-white text-xs font-bold rounded-full h-5 w-5 flex items-center justify-center"
          >10</span
        >
      </button>
    </div>

    <!-- <TournamentLeaderboard
      :is-open="isLeaderboardModalOpen"
      :tournament="selectedTournamentForModal"
      :leaderboard="currentTournamentLeaderboard"
      @close="isLeaderboardModalOpen = false"
    /> -->
    <Leaderboard :currentUser="currentUser" @close="isLeaderboardModalOpen = false" />

    <HowItWorksModal
      :is-open="isHowItWorksModalOpen"
      :tournament-name="selectedTournamentForModal?.name"
      @close="isHowItWorksModalOpen = false"
    />
  </div>
</template>
<style scoped>
  .active.m-tabs-bar__item {
    font-weight: 900;
  }
  .m-tabs .m-tabs-bar .button {
    color: #f805af !important; /* Pink color for buttons */
    font-weight: 900;
  }
  /* Add any specific styles for FunrizeRacesView if needed, beyond Tailwind */
  .font-sans {
    /* Ensure Inter is loaded if it's your primary font */
    font-family: 'Inter', sans-serif;
  }
</style>

<script setup lang="ts">
  import { ref, onMounted, computed } from 'vue'
  import { useTournamentStore, TournamentStatus } from '@/stores/tournament.store' // Adjust path as needed
  import FeaturedTournamentCard from './FeaturedTournamentCard.vue'
  import TournamentList from './TournamentList.vue'
  // import TournamentLeaderboard from './TournamentLeaderboard.vue'
  import Leaderboard from './LeaderBoard.vue'
  import HowItWorksModal from './HowItWorksModal.vue'
  import {
    ChevronLeftIcon,
    GiftIcon,
    MenuIcon,
    Gamepad2Icon,
    ZapIcon,
    BellIcon,
    TicketIcon,
  } from 'lucide-vue-next'
  import MazTabs from 'maz-ui/components/MazTabs'
  import MazTabsBar, { MazTabsBarItem } from 'maz-ui/components/MazTabsBar'

  const authStore = useAuthStore()
  const { currentUser } = storeToRefs(authStore)

  const currentTab = ref(2)
  const tabs: MazTabsBarItem[] = [
    { label: 'FULL SCHEDULE', disabled: false },
    {
      label: 'FINISHED',
      // badge: { color: 'danger', content: 1, roundedSize: 'full' },
    },
  ]
  const tournamentStore = useTournamentStore()

  const activeTab = ref('schedule') // 'schedule' or 'finished'

  const isLeaderboardModalOpen = ref(false)
  const isHowItWorksModalOpen = ref(false)
  const selectedTournamentForModal = ref()

  // --- Computed properties to get tournaments from the store ---
  const activeTournaments = computed(() => tournamentStore.activeTournaments)
  const upcomingTournaments = computed(() =>
    tournamentStore.upcomingTournaments.filter(
      (t) =>
        t.status === TournamentStatus.PENDING &&
        new Date(t.startTime) > new Date(Date.now() + 3 * 60 * 60 * 1000)
    )
  ) // Example: UP NEXT > 3 hours away
  const laterTournaments = computed(() =>
    tournamentStore.upcomingTournaments.filter(
      (t) =>
        t.status === TournamentStatus.PENDING &&
        new Date(t.startTime) > new Date(Date.now() + 24 * 60 * 60 * 1000)
    )
  ) // Example: LATER > 1 day away
  const finishedTournaments = computed(() =>
    Object.values(tournamentStore.tournaments).filter(
      (t) => t.status === TournamentStatus.COMPLETED || t.status === TournamentStatus.CANCELLED
    )
  )

  const currentTournamentLeaderboard = computed(() => tournamentStore.currentTournamentLeaderboard)

  // Example featured tournament (replace with actual logic if needed)
  const featuredTournament = computed(() => ({
    name: 'Team Races',
    title: 'RACE TOGETHER, WIN TOGETHER!',
    prizePool: '350,000',
    startDate: '29 May 2025, 09:00 AM',
    imageLeft: '/images/tournaments/team-race-banner-mob.png',
    imageRight: 'https://placehold.co/150x200/ef4444/000000?text=Game+Changers',
    isTeamRace: true,
  }))

  onMounted(async () => {
    await tournamentStore.fetchTournaments({ status: TournamentStatus.ACTIVE })
    await tournamentStore.fetchTournaments({ status: TournamentStatus.PENDING })
    await tournamentStore.fetchTournaments({ status: TournamentStatus.COMPLETED })
    // Potentially subscribe to general announcements
    // tournamentStore.subscribeToGeneralTournamentAnnouncements();
  })

  const showLeaderboard = async (tournament: { id: string } | null) => {
    console.log('showLeaderboard called with tournament:', tournament)
    selectedTournamentForModal.value = tournament
    await tournamentStore.fetchTournamentDetails(tournament?.id) // Fetches details and initial leaderboard
    isLeaderboardModalOpen.value = true
  }

  const showHowItWorks = (tournament: null) => {
    selectedTournamentForModal.value = tournament
    isHowItWorksModalOpen.value = true
  }

  const handleJoinTournament = async (tournamentId: string) => {
    const success = await tournamentStore.joinTournament(tournamentId)
    if (success) {
      // Optionally refetch tournament details or rely on WebSocket updates
      await tournamentStore.fetchTournamentDetails(tournamentId)
    }
  }
</script>
