<template>
  <TransitionRoot appear :show="isOpen" as="template">
    <Dialog as="div" @close="$emit('close')" class="relative z-50">
      <TransitionChild
        as="template"
        enter="duration-300 ease-out"
        enter-from="opacity-0"
        enter-to="opacity-100"
        leave="duration-200 ease-in"
        leave-from="opacity-100"
        leave-to="opacity-0"
      >
        <div class="fixed inset-0 bg-black/70 backdrop-blur-sm" />
      </TransitionChild>

      <div class="fixed inset-0 overflow-y-auto">
        <div class="flex min-h-full items-center justify-center p-4 text-center">
          <TransitionChild
            as="template"
            enter="duration-300 ease-out"
            enter-from="opacity-0 scale-95"
            enter-to="opacity-100 scale-100"
            leave="duration-200 ease-in"
            leave-from="opacity-100 scale-100"
            leave-to="opacity-0 scale-95"
          >
            <DialogPanel
              class="w-full max-w-md transform overflow-hidden rounded-2xl bg-slate-800 p-6 text-left align-middle shadow-xl transition-all"
            >
              <DialogTitle
                as="h3"
                class="text-xl font-bold leading-6 text-white mb-1 flex justify-between items-center"
              >
                {{ tournament?.name || 'Leaderboard' }}
                <button @click="$emit('close')" class="p-1 rounded-full hover:bg-slate-700">
                  <XIcon class="w-6 h-6 text-gray-400" />
                </button>
              </DialogTitle>
              <div class="mt-1 mb-4">
                <p class="text-sm text-gray-400">Top players in this race.</p>
              </div>

              <div class="max-h-[60vh] overflow-y-auto pr-2 -mr-2 custom-scrollbar">
                <table class="w-full text-sm">
                  <thead class="sticky top-0 bg-slate-800 z-10">
                    <tr>
                      <th class="text-left py-2 px-2 text-gray-400 font-semibold uppercase">
                        Rank
                      </th>
                      <th class="text-left py-2 px-2 text-gray-400 font-semibold uppercase">
                        Player
                      </th>
                      <th class="text-right py-2 px-2 text-gray-400 font-semibold uppercase">
                        Prize
                      </th>
                      <th class="text-right py-2 px-2 text-gray-400 font-semibold uppercase">
                        Points
                      </th>
                    </tr>
                  </thead>
                  <tbody v-if="leaderboard && leaderboard.length > 0">
                    <tr
                      v-for="(player, index) in leaderboard"
                      :key="player.userId"
                      class="border-b border-slate-700 last:border-b-0 hover:bg-slate-700/50"
                    >
                      <td class="py-3 px-2 text-center">
                        <span
                          class="inline-flex items-center justify-center w-7 h-7 rounded-full text-xs font-bold"
                          :class="getRankClass(player.rank || index + 1)"
                        >
                          {{ player.rank || index + 1 }}
                        </span>
                      </td>
                      <td class="py-3 px-2">
                        <div class="flex items-center">
                          <img
                            :src="
                              player.avatarUrl ||
                              `https://placehold.co/32x32/7f7f7f/white?text=${player.username?.substring(0, 1).toUpperCase()}&font=Inter`
                            "
                            alt="avatar"
                            class="w-8 h-8 rounded-full mr-3 object-cover"
                            @error="imgErrorUser"
                          />
                          <div>
                            <p class="font-medium text-white">{{ player.username }}</p>
                            <p v-if="player.location" class="text-xs text-gray-500">
                              {{ player.location }}
                            </p>
                          </div>
                        </div>
                      </td>
                      <td class="py-3 px-2 text-right font-medium text-yellow-400">
                        💰
                        {{
                          formatPrize(
                            player.prizeAmount ||
                              getPrizeForRank(player.rank || index + 1, tournament?.rewards) ||
                              0
                          )
                        }}
                      </td>
                      <td class="py-3 px-2 text-right font-medium text-white">
                        {{ player.score }}
                      </td>
                    </tr>
                  </tbody>
                  <tbody v-else>
                    <tr>
                      <td colspan="4" class="text-center py-10 text-gray-500">
                        <p v-if="tournamentStore.isLoadingLeaderboard">Loading leaderboard...</p>
                        <p v-else>No participants yet or leaderboard data is unavailable.</p>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

              <div class="mt-6 text-center">
                <button
                  type="button"
                  class="inline-flex justify-center rounded-md border border-transparent bg-purple-600 px-6 py-2.5 text-sm font-medium text-white hover:bg-purple-700 focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-500 focus-visible:ring-offset-2 focus-visible:ring-offset-slate-900"
                  @click="$emit('close')"
                >
                  Close
                </button>
              </div>
            </DialogPanel>
          </TransitionChild>
        </div>
      </div>
    </Dialog>
  </TransitionRoot>
</template>

<script setup>
  import { defineProps, defineEmits, computed } from 'vue'
  import {
    Dialog,
    DialogPanel,
    DialogTitle,
    TransitionRoot,
    TransitionChild,
  } from '@headlessui/vue'
  import { XIcon } from 'lucide-vue-next'
  import { useTournamentStore } from '@/stores/tournament.store' // Adjust path

  const props = defineProps({
    isOpen: Boolean,
    tournament: Object,
    leaderboard: Array,
  })
  defineEmits(['close'])

  const tournamentStore = useTournamentStore()

  const formatPrize = (amount) => {
    if (typeof amount === 'string' && amount.includes(',')) return amount // Already formatted
    if (typeof amount === 'string') return new Intl.NumberFormat().format(parseFloat(amount))
    return new Intl.NumberFormat().format(amount || 0)
  }

  const getPrizeForRank = (rank, rewards) => {
    const reward = rewards?.find((r) => r.rank === rank)
    if (reward && reward.description) {
      const match = reward.description.match(/(\d{1,3}(,\d{3})*(\.\d+)?)/)
      return match ? parseFloat(match[0].replace(/,/g, '')) : 0
    }
    return 0
  }

  const getRankClass = (rank) => {
    if (rank === 1) return 'bg-yellow-500 text-slate-900'
    if (rank === 2) return 'bg-slate-500 text-white'
    if (rank === 3) return 'bg-orange-600 text-white'
    return 'bg-slate-600 text-gray-300'
  }

  const imgErrorUser = (event) => {
    event.target.src = `https://placehold.co/32x32/7f7f7f/white?text=P&font=Inter`
  }
</script>

<style scoped>
  .custom-scrollbar::-webkit-scrollbar {
    width: 6px;
  }
  .custom-scrollbar::-webkit-scrollbar-track {
    background: theme('colors.slate.700');
    border-radius: 3px;
  }
  .custom-scrollbar::-webkit-scrollbar-thumb {
    background: theme('colors.purple.600');
    border-radius: 3px;
  }
  .custom-scrollbar::-webkit-scrollbar-thumb:hover {
    background: theme('colors.purple.500');
  }
</style>
