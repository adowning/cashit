<template>
  <UContainer class="py-8">
    <div class="space-y-8">
      <!-- Header -->
      <div class="flex items-center justify-between">
        <h1 class="text-2xl font-bold">WebSocket Monitor</h1>
        <div class="flex items-center space-x-2">
          <UButton
            :loading="isLoading"
            icon="i-heroicons-arrow-path"
            color="gray"
            variant="ghost"
            @click="refresh"
            title="Refresh data"
          />
          <UButton
            :icon="autoRefresh ? 'i-heroicons-pause' : 'i-heroicons-play'"
            :color="autoRefresh ? 'red' : 'green'"
            variant="ghost"
            @click="toggleAutoRefresh"
            :title="autoRefresh ? 'Pause auto-refresh' : 'Enable auto-refresh'"
          />
        </div>
      </div>

      <!-- Stats Cards -->
      <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <UCard>
          <div class="text-center">
            <p class="text-3xl font-bold text-primary">
              {{ stats.activeConnections }}
            </p>
            <p class="text-sm text-gray-500 dark:text-gray-400">Active Connections</p>
          </div>
        </UCard>
        <UCard>
          <div class="text-center">
            <p class="text-3xl font-bold text-green-500">
              {{ stats.userConnections }}
            </p>
            <p class="text-sm text-gray-500 dark:text-gray-400">User Sessions</p>
          </div>
        </UCard>
        <UCard>
          <div class="text-center">
            <p class="text-3xl font-bold text-blue-500">
              {{ stats.gameConnections }}
            </p>
            <p class="text-sm text-gray-500 dark:text-gray-400">Game Sessions</p>
          </div>
        </UCard>
        <UCard>
          <div class="text-center">
            <p class="text-3xl font-bold text-purple-500">
              {{ stats.messagesPerMinute }}
            </p>
            <p class="text-sm text-gray-500 dark:text-gray-400">Messages/Min</p>
          </div>
        </UCard>
      </div>

      <div class="grid grid-cols-1 gap-8 lg:grid-cols-2">
        <!-- Active Connections -->
        <UCard>
          <template #header>
            <h3 class="font-semibold">Active Connections ({{ connections.length }})</h3>
          </template>

          <UTable
            :rows="connections"
            :loading="isLoading"
            :empty-state="{
              icon: 'i-heroicons-link-20-solid',
              label: 'No active connections',
            }"
          >
            <template #id-data="{ row }">
              <UTooltip :text="row.id">
                <span class="truncate max-w-[100px] inline-block"
                  >{{ row.id.slice(0, 8) }}...</span
                >
              </UTooltip>
            </template>

            <template #user-data="{ row }">
              <div class="flex items-center space-x-2">
                <UIcon name="i-heroicons-user" class="w-4 h-4" />
                <span>{{ row.username || "Guest" }}</span>
                <UBadge v-if="row.userId" color="gray"
                  >{{ row.userId.slice(0, 6) }}...</UBadge
                >
              </div>
            </template>

            <template #type-data="{ row }">
              <UBadge :color="row.type === 'user' ? 'green' : 'blue'">
                {{ row.type }}
              </UBadge>
            </template>

            <template #connectedAt-data="{ row }">
              {{ new Date(row.connectedAt).toLocaleTimeString() }}
            </template>
          </UTable>
        </UCard>

        <!-- Recent Messages -->
        <UCard>
          <template #header>
            <h3 class="font-semibold">Recent Messages ({{ messages.length }})</h3>
          </template>

          <UTabs :items="tabs">
            <template #item="{ item }">
              <div class="h-[500px] overflow-y-auto">
                <div
                  v-if="filteredMessages.length === 0"
                  class="text-center py-8 text-gray-500"
                >
                  No messages found
                </div>

                <div v-else class="space-y-4">
                  <div
                    v-for="message in filteredMessages"
                    :key="message.id"
                    class="p-3 rounded-md"
                    :class="{
                      'bg-blue-50 dark:bg-blue-900/20': message.direction === 'in',
                      'bg-green-50 dark:bg-green-900/20': message.direction === 'out',
                    }"
                  >
                    <div class="flex justify-between items-start mb-1">
                      <div class="flex items-center space-x-2">
                        <span
                          class="font-mono text-xs px-2 py-0.5 rounded"
                          :class="{
                            'bg-blue-100 text-blue-800 dark:bg-blue-900/50 dark:text-blue-300':
                              message.direction === 'in',
                            'bg-green-100 text-green-800 dark:bg-green-900/50 dark:text-green-300':
                              message.direction === 'out',
                          }"
                        >
                          {{ message.direction === "in" ? "IN" : "OUT" }}
                        </span>
                        <span class="text-xs text-gray-500">{{
                          formatTime(message.timestamp)
                        }}</span>
                        <UBadge size="xs" color="gray">{{ message.type }}</UBadge>
                      </div>
                      <div class="text-xs text-gray-500">
                        {{ formatSize(message.size) }}
                      </div>
                    </div>

                    <div class="mt-1">
                      <div class="text-sm font-mono break-all">
                        <pre class="whitespace-pre-wrap text-xs">{{
                          JSON.stringify(message.data, null, 2)
                        }}</pre>
                      </div>
                    </div>

                    <div class="mt-2 text-xs text-gray-500 flex justify-between">
                      <span>Client: {{ message.clientId.slice(0, 8) }}...</span>
                      <span v-if="message.userId"
                        >User: {{ message.userId.slice(0, 8) }}...</span
                      >
                    </div>
                  </div>
                </div>
              </div>
            </template>
          </UTabs>
        </UCard>
      </div>
    </div>
  </UContainer>
</template>

<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount, computed } from "vue";
import { useWebSocketMonitor } from "~/composables/useWebSocketMonitor";

const {
  messages,
  connections,
  stats,
  isLoading,
  refresh,
  startAutoRefresh,
  stopAutoRefresh,
  formatTime,
  formatSize,
} = useWebSocketMonitor();

const autoRefresh = ref(false);
let autoRefreshCleanup: (() => void) | null = null;

const tabs = [
  { key: "all", label: "All" },
  { key: "in", label: "Incoming" },
  { key: "out", label: "Outgoing" },
];

const activeTab = ref("all");

const filteredMessages = computed(() => {
  if (activeTab.value === "all") return messages.value;
  return messages.value.filter((m) => m.direction === activeTab.value);
});

const toggleAutoRefresh = () => {
  autoRefresh.value = !autoRefresh.value;

  if (autoRefresh.value) {
    autoRefreshCleanup = startAutoRefresh(5000);
  } else if (autoRefreshCleanup) {
    autoRefreshCleanup();
    autoRefreshCleanup = null;
  }
};

// Initial data load
onMounted(async () => {
  await refresh();
  toggleAutoRefresh();
});

// Clean up auto-refresh on unmount
onBeforeUnmount(() => {
  if (autoRefreshCleanup) {
    autoRefreshCleanup();
  }
});
</script>
