<template>
  <svg
    xmlns="http://www.w3.org/2000/svg"
    viewBox="0 0 20 20"
    fill="currentColor"
    :class="props.className"
  >
    <path
      fill-rule="evenodd"
      d="M10.868 2.884c-.321-.772-1.415-.772-1.736 0l-1.83 4.401-4.753.39-3.463 3.518 1.318 4.995L6.03 17.84l4.007-2.105 4.007 2.105 2.884-2.722 1.318-4.995-3.463-3.518-4.753-.39-1.83-4.401zm0 0L9.132.164a.75.75 0 00-1.264 0L6.132 2.884l-1.83 4.401-4.753.39a.75.75 0 00-.463 1.283l3.463 3.518-1.318 4.995a.75.75 0 001.138.806l2.884-2.722 4.007 2.105a.75.75 0 00.832 0l4.007-2.105 2.884 2.722a.75.75 0 001.138-.806l-1.318-4.995 3.463-3.518a.75.75 0 00-.463-1.283l-4.753-.39-1.83-4.401z"
      clip-rule="evenodd"
    />
  </svg>
</template>

<script setup lang="ts">
  import { defineProps, withDefaults } from 'vue'
  import type { IconProps } from '../types'

  const props = withDefaults(defineProps<IconProps>(), {
    className: 'w-5 h-5',
  })
</script>
