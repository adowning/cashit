<template>
  <img
    :src="`${closePressed ? '/images/common/close-pressed.png' : '/images/common/close.png'}`"
    style="width: 45px; height: 45px"
  />
</template>

<script setup lang="ts">
  import { defineProps, withDefaults } from 'vue'
  import type { IconProps } from '../types'

  const props = withDefaults(defineProps<IconProps>(), {
    closePressed: false,
  })
</script>
