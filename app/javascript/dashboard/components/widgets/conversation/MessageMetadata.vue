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
    urgency() {
      return this.contentAttributes.urgency;
    },
    issueType() {
      return this.contentAttributes.issue_type;
    },
    deviceInfo() {
      return this.contentAttributes.device_info || {};
    },
    hasDeviceInfo() {
      return Object.keys(this.deviceInfo).length > 0;
    },
    hasMetadata() {
      return this.urgency || this.issueType || this.hasDeviceInfo;
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
        <span class="badge" :class="[`urgency-${urgency}`]">
          {{ $t(`CONVERSATION.METADATA.URGENCY_${urgency.toUpperCase()}`) }}
        </span>
      </div>

      <!-- Issue Type -->
      <div v-if="issueType" class="metadata-item">
        <span class="label">{{ $t('CONVERSATION.METADATA.ISSUE_TYPE') }}</span>
        <span class="value">{{ issueType }}</span>
      </div>

      <!-- Device Info -->
      <div v-if="hasDeviceInfo" class="metadata-item device">
        <span class="label">{{ $t('CONVERSATION.METADATA.DEVICE') }}</span>
        <div class="device-details">
          <span v-if="deviceInfo.type" class="device-type">{{
            deviceInfo.type
          }}</span>
          <span v-if="deviceInfo.os" class="device-os">{{
            deviceInfo.os
          }}</span>
          <span v-if="deviceInfo.browser" class="device-browser">{{
            deviceInfo.browser
          }}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.message-metadata {
  margin-top: 4px;
  font-size: 12px;

  .metadata-box {
    background: var(--color-background-light);
    border-radius: 4px;
    padding: 8px;
  }

  .metadata-item {
    display: flex;
    align-items: center;
    margin-bottom: 4px;

    &:last-child {
      margin-bottom: 0;
    }

    .label {
      font-weight: 500;
      margin-right: 8px;
      color: var(--color-body);
    }

    .value {
      color: var(--color-body-light);
    }
  }

  .urgency {
    .badge {
      padding: 2px 8px;
      border-radius: 12px;
      font-weight: 500;

      &.urgency-high {
        background: var(--color-error-light);
        color: var(--color-error);
      }
      &.urgency-medium {
        background: var(--color-warning-light);
        color: var(--color-warning);
      }
      &.urgency-low {
        background: var(--color-success-light);
        color: var(--color-success);
      }
    }
  }

  .device-details {
    display: flex;
    gap: 8px;
    color: var(--color-body-light);
  }
}
</style>
