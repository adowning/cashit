<template>
  <div class="notification-container">
    <TransitionGroup
      name="toast-fade"
      tag="div"
      enter-active-class="animate__animated animate__lightSpeedInRight animate__delay-0s"
      leave-active-class="animate__animated animate__lightSpeedOutLeft animate__delay-0s"
    >
      <div
        v-for="notification in notifications"
        :key="notification.id"
        class="mt-12"
        :class="['toast', `toast-${notification.type}`]"
      >
        <span class="toast-message">{{ notification.message }}</span>
        <button
          class="toast-close"
          aria-label="Close notification"
          @click="notificationStore.removeNotification(notification.id)"
        >
          &times;
        </button>
      </div>
    </TransitionGroup>
  </div>
</template>

<script setup lang="ts">
  import { useNotificationStore } from '@/stores/notification.store' // Adjust path
  import { computed } from 'vue'

  const notificationStore = useNotificationStore()

  // Get computed ref to the notifications array from the store
  const notifications = computed(() => notificationStore.activeNotifications)

  // No need for manual timers here, the store handles removal
</script>

<style scoped>
  .notification-container {
    position: fixed;
    top: 4px;
    right: 20px;
    z-index: 1050;
    /* Ensure it's above most other content */
    width: 300px;
    /* Or max-width */
    display: flex;
    flex-direction: column;
    gap: 10px;
    /* Spacing between toasts */
  }

  .toast {
    background-color: #333;
    color: white;
    padding: 12px 15px;
    border-radius: 4px;
    font-family: Rox Display;
    font-size: medium;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
    display: flex;
    justify-content: space-between;
    opacity: 0.8;
    align-items: center;
    /* Required for Animate.css performance */
    will-change: transform, opacity;
    /* Control animation speed */
    --animate-duration: 0.3s;
  }

  /* --- Animation Base --- */
  /* Optional: If you want slightly different behavior than default animate.css */
  .toast-fade-enter-active,
  .toast-fade-leave-active {
    transition: all 0.4s ease;
  }

  .toast-fade-enter-from,
  .toast-fade-leave-to {
    opacity: 0;
    transform: translateX(100%);
  }

  /* --- Toast Types Styling (Example) --- */
  .toast-info {
    background-color: #007bff;
    /* Blue */
    color: white;
  }

  .toast-success {
    background-color: #28a745;
    /* Green */
    color: white;
  }

  .toast-warning {
    background-color: #ffc107;
    /* Yellow */
    color: #333;
    /* Darker text for yellow */
  }

  .toast-error {
    background-color: #dc3545;
    /* Red */
    color: white;
  }

  .toast-message {
    flex-grow: 1;
    margin-right: 2px;
  }

  .toast-close {
    background: none;
    border: none;
    color: inherit;
    /* Inherit color from parent toast type */
    opacity: 0.7;
    font-size: 1.2em;
    line-height: 1;
    cursor: pointer;
    padding: 0 5px;
  }

  .toast-close:hover {
    opacity: 1;
  }
</style>
