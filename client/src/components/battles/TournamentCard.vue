<template>
  <div
    :class="[
      'rounded-xl shadow-lg overflow-hidden transition-all duration-300 hover:shadow-purple-500/30',
      cardBgClass,
    ]"
  >
    <div class="p-2">
      <div class="flex items-start justify-between mb-3">
        <div class="race-header flex gap-2 h-[71px]" data-v-3202436b="" data-v-6814e224="">
          <div class="flex flex-col justify-start">
            <img
              src="https://funrize.com/cdn-cgi/image/quality=70,format=auto,onerror=redirect/uploads-funrize/tournaments/0.47714800%201744703907-iconPath-67fe11a3747e0-679fd6806ad6b.png"
              onerror="this.setAttribute('data-error', 1)"
              width="88"
              height="71"
              alt="Wilderness Warriors"
              class="col-img-mob"
            />
            <!-- <div class="toledo prize-title text-cannes text-xs" style="">
                <div class="text-gray-400">
                  Time left: <span class="text-white font-medium">{{ timeLeft }}</span>
                </div>
              </div> -->
          </div>

          <div class="race-title-mob font-bold">
            <div class="tunis bold title text-cannes" style="">
              {{ tournament.name }}
            </div>
            <div class="race-prize-mob">
              <div class="toledo prize-title text-cannes text-xs" style="">
                <!--[-->Split the grand prize<!--]-->
              </div>
              <!--[-->
              <div class="prize coins flex" style="color: gold">
                <img
                  src="../../assets/img/icons/coin.svg"
                  onerror="this.setAttribute('data-error', 1)"
                  alt="coins"
                /><span class="toledo bold" style="font-weight: 700">350,000</span>
              </div>
            </div>
          </div>
        </div>
        <!-- <div class="flex items-center">
          <img
            :src="
              tournament.image ||
              `https://placehold.co/80x80/${bgColorForImage(tournament.status)}/white?text=${tournament.name.substring(0, 1)}&font=Inter`
            "
            alt="Tournament Icon"
            class="w-16 h-16 rounded-lg mr-4 object-cover shadow-md"
            @error="imgError"
          />
          <div>
            <span
              v-if="tournament.isTeamRace || tournament.name?.toLowerCase().includes('team race')"
              class="text-xs uppercase font-semibold text-purple-400 tracking-wider mb-1 block"
              >TEAM RACE</span
            >
            <h3 class="text-xl font-bold text-white">{{ tournament.name }}</h3>
            <p class="text-sm text-gray-300">
              {{ tournament.description || 'Split the grand prize' }}
            </p>
          </div>
        </div> -->
        <button
          v-if="!isFinished && (isActiveSection || tournament.status === 'PENDING')"
          @click.stop="toggleExpand"
          class="text-gray-400 hover:text-white p-1"
        >
          <ChevronDownIcon
            :class="['w-6 h-6 transition-transform duration-300', isExpanded ? 'rotate-180' : '']"
          />
        </button>
      </div>

      <!-- <div class="mb-3 flex items-center">
        <span class="text-yellow-400 text-2xl font-bold mr-2"
          >💰 {{ formatPrize(tournament.prizeFund || tournament.targetScore || 0) }}</span
        >
        <span v-if="isFinished" class="text-sm text-gray-400"
          >Finished {{ formatFinishTime(tournament.endTime) }}</span
        > 
      </div> -->

      <div v-if="isActiveSection && !isFinished" class="space-y-3 mb-4 justify-center">
        <div class="grid w-[100%] grid-cols-2 gap-x-4 gap-y-2 text-sm mx-2">
          <div class="text-gray-400">
            Time left: <span class="text-white font-medium">{{ timeLeft }}</span>
          </div>
          <!-- <div class="text-gray-400">
            Plays: <span class="text-white font-medium">{{ tournament.plays || 1000 }}</span>
          </div> -->
          <div class="text-gray-400 justify-self-end mr-4">
            Min play level:
            <span class="text-white font-medium">{{ tournament.minPlayLevel || 100 }}</span>
          </div>
          <!-- <div class="text-gray-400">
            Duration:
            <span class="text-white font-medium">{{ tournament.duration || '23h 58m' }}</span>
          </div> -->
        </div>
        <div class="w-full bg-slate-700 rounded-full h-2.5">
          <div
            class="bg-purple-600 h-2.5 rounded-full"
            :style="{ width: (tournament.progress || 0) + '%' }"
          ></div>
        </div>
        <div class="flex justify-between items-center text-sm bg-slate-800/50 p-3 rounded-lg">
          <div>
            My Rank: <span class="font-bold text-purple-400">{{ tournament.myRank || 0 }}</span>
          </div>
          <div>
            My Points: <span class="font-bold text-purple-400">{{ tournament.myPoints || 0 }}</span>
          </div>
          <div>
            Free play:
            <span class="font-bold text-purple-400"
              >{{ tournament.freePlayUsed || 0 }}/{{ tournament.freePlayTotal || 1000 }}</span
            >
          </div>
        </div>
      </div>

      <div
        v-if="!isActiveSection && !isFinished && tournament.status === 'PENDING'"
        class="text-sm text-gray-300 mb-3"
      >
        <p>
          Starts:
          <span class="text-white font-medium">{{ formatStartTime(tournament.startTime) }}</span>
        </p>
        <p>
          Min play level:
          <span class="text-white font-medium">{{ tournament.minPlayLevel || 20 }}</span>
        </p>
      </div>

      <div v-if="isFinished" class="space-y-2 mb-3">
        <div
          v-for="(winner, index) in (tournament.participants || []).slice(0, 3)"
          :key="winner.userId"
          class="flex items-center text-sm"
        >
          <span class="mr-2 text-yellow-400 font-semibold">{{ index + 1 }}.</span>
          <img
            :src="
              winner.avatarUrl ||
              'https://placehold.co/24x24/7f7f7f/white?text=' +
                winner.username?.substring(0, 1).toUpperCase()
            "
            alt="avatar"
            class="w-6 h-6 rounded-full mr-2"
          />
          <span class="text-white flex-grow">{{ winner.username }}</span>
          <span class="text-yellow-400 mr-2"
            >💰
            {{
              formatPrize(winner.prizeAmount || getPrizeForRank(index + 1, tournament.rewards) || 0)
            }}</span
          >
          <span class="text-gray-400 w-12 text-right">{{ winner.score }}</span>
        </div>
      </div>

      <div
        v-show="isExpanded && !isFinished"
        class="mt-4 pt-4 border-t border-slate-700/50 space-y-3"
      >
        <p class="text-sm text-gray-300">
          Eligible Games:
          <span class="text-white">{{
            tournament.eligibleGames?.map((g) => g.name).join(', ') ||
            'All slot games (excluding Fishing)'
          }}</span>
        </p>
        <p class="text-sm text-gray-300">
          Points System:
          <span class="text-white"
            >Based on win multipliers. Higher multipliers earn more points.</span
          >
        </p>
      </div>

      <div class="mt-4 flex flex-col sm:flex-row space-y-2 sm:space-y-0 sm:space-x-3">
        <button
          v-if="!isFinished"
          @click.stop="$emit('show-leaderboard')"
          class="flex-1 bg-slate-700 hover:bg-slate-600 text-white font-semibold py-2.5 px-4 rounded-lg text-sm transition-colors"
        >
          Show Leaderboard
        </button>
        <button
          v-if="isActiveSection && !isFinished"
          @click.stop="$emit('join-tournament')"
          class="flex-1 bg-pink-600 hover:bg-pink-700 text-white font-semibold py-2.5 px-4 rounded-lg text-sm transition-colors"
        >
          {{ tournament.isJoined ? 'CONTINUE RACING' : 'JOIN NOW' }}
        </button>
        <button
          v-if="!isActiveSection && !isFinished && tournament.status === 'PENDING'"
          @click.stop="$emit('join-tournament')"
          class="flex-1 bg-purple-600 hover:bg-purple-700 text-white font-semibold py-2.5 px-4 rounded-lg text-sm transition-colors"
        >
          JOIN RACE
        </button>
      </div>
      <button
        v-if="!isFinished && isExpanded"
        @click.stop="$emit('show-how-it-works')"
        class="w-full mt-3 text-center text-purple-400 hover:text-purple-300 text-sm font-medium"
      >
        How It Works
      </button>
    </div>
  </div>
</template>

<script setup>
  import { defineProps, defineEmits, ref, computed } from 'vue'
  import { ChevronDownIcon } from 'lucide-vue-next'
  import { formatDistanceToNowStrict, format } from 'date-fns'

  const props = defineProps({
    tournament: Object,
    isActiveSection: Boolean, // True if in "RIGHT NOW" section
    isFinished: Boolean, // True if in "FINISHED" section
  })

  const emit = defineEmits(['show-leaderboard', 'show-how-it-works', 'join-tournament'])

  const isExpanded = ref(props.isActiveSection) // Auto-expand if in "RIGHT NOW"

  const toggleExpand = () => {
    isExpanded.value = !isExpanded.value
  }

  const formatPrize = (amount) => {
    if (typeof amount === 'string') return amount // Already formatted
    return new Intl.NumberFormat().format(amount)
  }

  const timeLeft = computed(() => {
    if (!props.tournament.endTime) return 'N/A'
    try {
      const endDate = new Date(props.tournament.endTime)
      if (endDate < new Date()) return 'Ended'
      return formatDistanceToNowStrict(endDate, { addSuffix: false }) // e.g. "7h 11m"
    } catch (e) {
      return 'N/A'
    }
  })

  const formatFinishTime = (isoString) => {
    if (!isoString) return 'N/A'
    try {
      return format(new Date(isoString), 'h:mm a')
    } catch (e) {
      return 'N/A'
    }
  }

  const formatStartTime = (isoString) => {
    if (!isoString) return 'N/A'
    try {
      // Check if it's today, tomorrow, or a specific date
      const date = new Date(isoString)
      const today = new Date()
      const tomorrow = new Date(today)
      tomorrow.setDate(tomorrow.getDate() + 1)

      if (date.toDateString() === today.toDateString()) {
        return `Today, ${format(date, 'h:mm a')}`
      } else if (date.toDateString() === tomorrow.toDateString()) {
        return `Tomorrow, ${format(date, 'h:mm a')}`
      } else {
        return format(date, 'dd MMM yyyy, h:mm a')
      }
    } catch (e) {
      return 'N/A'
    }
  }

  const getPrizeForRank = (rank, rewards) => {
    const reward = rewards?.find((r) => r.rank === rank)
    if (reward && reward.description) {
      const match = reward.description.match(/(\d{1,3}(,\d{3})*(\.\d+)?)/) // Extracts number
      return match ? match[0] : 'N/A'
    }
    return 0
  }

  const cardBgClass = computed(() => {
    if (props.isFinished) return 'bg-slate-800'
    if (props.tournament.isTeamRace || props.tournament.name?.toLowerCase().includes('team race'))
      return 'bg-gradient-to-br from-sky-600 to-cyan-700'
    return 'bg-gradient-to-br from-[#7133f7] to-[#0e0449] backdrop-blur-sm'
  })

  const bgColorForImage = (status) => {
    if (props.isFinished || status === 'COMPLETED' || status === 'CANCELLED')
      return 'maz-bg-color-dark' // slate
    if (status === 'ACTIVE') return '16a34a' // green
    if (status === 'PENDING') return 'f59e0b' // amber
    return '7c3aed' // purple (default)
  }

  const imgError = (event) => {
    event.target.src = `https://placehold.co/80x80/${bgColorForImage(props.tournament.status)}/white?text=${props.tournament.name?.substring(0, 1)}&font=Inter`
  }
</script>
