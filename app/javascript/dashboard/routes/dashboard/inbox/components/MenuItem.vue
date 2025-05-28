<script setup>
defineProps({
  label: {
    type: String,
    default: '',
  },
});
</script>

<template>
  <button
    class="flex items-center w-full h-8 px-2 py-1 rounded-md cursor-pointer hover:text-woot-500 min-w-0"
    @click="$emit('click')"
  >
    <span class="text-xs font-medium truncate text-n-slate-12">
      {{ label }}
    </span>
  </button>
</template>
