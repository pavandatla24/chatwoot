<script>
export default {
  name: 'MessageMetadata',
  props: {
    contentAttributes: {
      type: Object,
      default: () => ({}),
    },
  },
  computed: {
    hasMetadata() {
      return this.urgency || this.issueType;
    },
    urgency() {
      return this.contentAttributes.urgency;
    },
    issueType() {
      return this.contentAttributes.issue_type;
    },
  },
};
</script>

<template>
  <div v-if="hasMetadata" class="message-metadata">
    <div class="metadata-box">
      <!-- Urgency Badge -->
      <div v-if="urgency" class="metadata-item urgency">
        <span class="label">{{ $t('CONVERSATION.METADATA.URGENCY') }}</span>
        <span class="badge" :class="`urgency-${urgency}`">
          {{ urgency.toUpperCase() }}
        </span>
      </div>

      <!-- Issue Type -->
      <div v-if="issueType" class="metadata-item">
        <span class="label">{{ $t('CONVERSATION.METADATA.ISSUE_TYPE') }}</span>
        <span class="value">{{ issueType }}</span>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.message-metadata {
  margin-top: 4px;
  font-size: 12px;

  .metadata-box {
    @apply bg-slate-50 dark:bg-slate-700 rounded-md p-2;
  }

  .metadata-item {
    @apply flex items-center mb-1 last:mb-0;

    .label {
      @apply font-medium mr-2 text-slate-800 dark:text-slate-100;
    }

    .value {
      @apply text-slate-600 dark:text-slate-300;
    }
  }

  .urgency {
    .badge {
      @apply px-2 py-0.5 rounded-xl font-medium;

      &.urgency-high {
        @apply bg-red-50 dark:bg-red-900/50 text-red-700 dark:text-red-300;
      }
      &.urgency-medium {
        @apply bg-yellow-50 dark:bg-yellow-900/50 text-yellow-700 dark:text-yellow-300;
      }
      &.urgency-low {
        @apply bg-green-50 dark:bg-green-900/50 text-green-700 dark:text-green-300;
      }
    }
  }
}
</style>
