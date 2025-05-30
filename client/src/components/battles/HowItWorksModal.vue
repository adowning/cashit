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
              class="w-full max-w-lg transform overflow-hidden rounded-2xl bg-slate-800 p-6 text-left align-middle shadow-xl transition-all"
            >
              <DialogTitle
                as="h3"
                class="text-xl font-bold leading-6 text-white mb-4 flex justify-between items-center"
              >
                How It Works: {{ tournamentName || 'Race' }}
                <button @click="$emit('close')" class="p-1 rounded-full hover:bg-slate-700">
                  <XIcon class="w-6 h-6 text-gray-400" />
                </button>
              </DialogTitle>

              <div
                class="mt-2 space-y-4 text-sm text-gray-300 max-h-[70vh] overflow-y-auto custom-scrollbar pr-2"
              >
                <ol class="list-decimal list-inside space-y-2 pl-2">
                  <li>Please note that each race has a minimum Play Level to participate.</li>
                  <li>
                    Click the "Join Now" or "Continue Racing" button to participate in the race.
                  </li>
                  <li>
                    Play any slot game (usually excluding specific types like Fishing Games unless
                    stated otherwise).
                  </li>
                  <li>Points are awarded for your winnings based on multipliers.</li>
                </ol>

                <div class="bg-slate-700/50 p-4 rounded-lg">
                  <h4 class="font-semibold text-white mb-2">
                    Points are generated based on the multipliers:
                  </h4>
                  <p class="mb-2">
                    Let's say you make a play with 200 Play Level and win 20.00, that's a 10X
                    Multiplier.
                  </p>
                  <div class="space-y-3">
                    <div class="flex items-center">
                      <img
                        src="https://placehold.co/40x40/eab308/FFFFFF?text=10x&font=Inter"
                        alt="10x Multiplier"
                        class="w-10 h-10 rounded-md mr-3"
                      />
                      <div>
                        Up to <span class="font-bold text-yellow-400">10X</span> Multiplier brings
                        you <span class="font-bold text-white">2 points</span>
                      </div>
                    </div>
                    <div class="flex items-center">
                      <img
                        src="https://placehold.co/40x40/f97316/FFFFFF?text=25x&font=Inter"
                        alt="25x Multiplier"
                        class="w-10 h-10 rounded-md mr-3"
                      />
                      <div>
                        Up to <span class="font-bold text-orange-400">25X</span> Multiplier brings
                        you <span class="font-bold text-white">25 points</span>
                      </div>
                    </div>
                    <div class="flex items-center">
                      <img
                        src="https://placehold.co/40x40/ef4444/FFFFFF?text=25x%2B&font=Inter"
                        alt="25x+ Multiplier"
                        class="w-10 h-10 rounded-md mr-3"
                      />
                      <div>
                        <span class="font-bold text-red-400">25X+</span> Multiplier brings you
                        <span class="font-bold text-white">100 points</span>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="bg-slate-700/50 p-4 rounded-lg">
                  <h4 class="font-semibold text-white mb-2">Prizes:</h4>
                  <div class="flex items-start mb-2">
                    <AwardIcon class="w-6 h-6 text-yellow-400 mr-3 mt-1 shrink-0" />
                    <p>The leaderboard updates in real time. Keep an eye on your rank!</p>
                  </div>
                  <div class="flex items-start">
                    <GiftIcon class="w-6 h-6 text-purple-400 mr-3 mt-1 shrink-0" />
                    <p>
                      Prizes are automatically added to the player account at the end of each race.
                    </p>
                  </div>
                </div>
              </div>

              <div class="mt-6 text-center">
                <button
                  type="button"
                  class="inline-flex justify-center rounded-md border border-transparent bg-purple-600 px-6 py-2.5 text-sm font-medium text-white hover:bg-purple-700 focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-500 focus-visible:ring-offset-slate-900"
                  @click="$emit('close')"
                >
                  Got It!
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
  import { defineProps, defineEmits } from 'vue'
  import {
    Dialog,
    DialogPanel,
    DialogTitle,
    TransitionRoot,
    TransitionChild,
  } from '@headlessui/vue'
  import { XIcon, AwardIcon, GiftIcon } from 'lucide-vue-next'

  const props = defineProps({
    isOpen: Boolean,
    tournamentName: String,
  })
  defineEmits(['close'])
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
