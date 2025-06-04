<template>
  <div class="user-profiles-list p-6">
    <h2 class="text-2xl font-bold mb-4">All User Profiles</h2>
    
    <!-- Search and Filters -->
    <div class="mb-4 flex gap-4">
      <input
        v-model="searchQuery"
        type="text"
        placeholder="Search by username or cashtag..."
        class="px-3 py-2 border rounded-lg flex-1"
        @input="debouncedSearch"
      />
      <select v-model="orderBy" @change="fetchProfiles" class="px-3 py-2 border rounded-lg">
        <option value="createdAt">Created Date</option>
        <option value="username">Username</option>
        <option value="totalXpFromOperator">Total XP</option>
      </select>
      <select v-model="orderDirection" @change="fetchProfiles" class="px-3 py-2 border rounded-lg">
        <option value="desc">Descending</option>
        <option value="asc">Ascending</option>
      </select>
    </div>

    <!-- Loading State -->
    <div v-if="userStore.allUserProfilesState.isLoading.value" class="text-center py-8">
      <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-500 mx-auto"></div>
      <p class="mt-2">Loading user profiles...</p>
    </div>

    <!-- Error State -->
    <div v-else-if="userStore.allUserProfilesState.error.value" class="text-red-600 text-center py-8">
      <p>Error loading user profiles: {{ userStore.allUserProfilesState.error.value.message }}</p>
      <button @click="fetchProfiles" class="mt-2 px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">
        Retry
      </button>
    </div>

    <!-- User Profiles List -->
    <div v-else-if="userProfiles?.items" class="space-y-4">
      <div
        v-for="profile in userProfiles.items"
        :key="profile.id"
        class="bg-white border rounded-lg p-4 shadow-sm hover:shadow-md transition-shadow"
      >
        <div class="flex items-center justify-between">
          <div class="flex items-center space-x-4">
            <img
              :src="profile.avatar || '/default-avatar.png'"
              :alt="profile.username"
              class="w-12 h-12 rounded-full object-cover"
            />
            <div>
              <h3 class="font-semibold text-lg">{{ profile.username }}</h3>
              <p class="text-gray-600">{{ profile.cashtag || 'No cashtag' }}</p>
              <p class="text-sm text-gray-500">
                Joined: {{ new Date(profile.createdAt).toLocaleDateString() }}
              </p>
            </div>
          </div>
          <div class="text-right">
            <p class="font-semibold">XP: {{ profile.totalXpFromOperator || 0 }}</p>
            <p class="text-sm text-gray-500">ID: {{ profile.id.slice(0, 8) }}...</p>
          </div>
        </div>
      </div>

      <!-- Pagination -->
      <div class="flex justify-between items-center mt-6">
        <div class="text-sm text-gray-600">
          Showing {{ (currentPage - 1) * pageSize + 1 }} to 
          {{ Math.min(currentPage * pageSize, userProfiles.total) }} of 
          {{ userProfiles.total }} profiles
        </div>
        <div class="flex space-x-2">
          <button
            @click="goToPage(currentPage - 1)"
            :disabled="currentPage <= 1"
            class="px-3 py-1 border rounded disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-50"
          >
            Previous
          </button>
          <span class="px-3 py-1">Page {{ currentPage }} of {{ userProfiles.totalPages }}</span>
          <button
            @click="goToPage(currentPage + 1)"
            :disabled="currentPage >= userProfiles.totalPages"
            class="px-3 py-1 border rounded disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-50"
          >
            Next
          </button>
        </div>
      </div>
    </div>

    <!-- Empty State -->
    <div v-else class="text-center py-8 text-gray-500">
      <p>No user profiles found.</p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useUserStore } from '@/stores/user.store'
import { debounce } from 'lodash-es'

const userStore = useUserStore()

// Reactive state
const searchQuery = ref('')
const orderBy = ref<'username' | 'createdAt' | 'totalXpFromOperator'>('createdAt')
const orderDirection = ref<'asc' | 'desc'>('desc')
const currentPage = ref(1)
const pageSize = ref(20)

// Computed
const userProfiles = computed(() => userStore.allUserProfilesState.data.value)

// Methods
const fetchProfiles = async () => {
  await userStore.fetchAllUserProfiles({
    page: currentPage.value,
    limit: pageSize.value,
    search: searchQuery.value || undefined,
    orderBy: orderBy.value,
    orderDirection: orderDirection.value,
  })
}

const goToPage = (page: number) => {
  currentPage.value = page
  fetchProfiles()
}

const debouncedSearch = debounce(() => {
  currentPage.value = 1 // Reset to first page when searching
  fetchProfiles()
}, 300)

// Lifecycle
onMounted(() => {
  fetchProfiles()
})
</script>

<style scoped>
.user-profiles-list {
  max-width: 1200px;
  margin: 0 auto;
}
</style>
