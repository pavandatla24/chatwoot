<script setup>
import { computed } from 'vue';
import { getLanguageName } from 'dashboard/components/widgets/conversation/advancedFilterItems/languages';
import ContactDetailsItem from './ContactDetailsItem.vue';
import CustomAttributes from './customAttributes/CustomAttributes.vue';

const props = defineProps({
  conversationAttributes: {
    type: Object,
    default: () => ({}),
  },
  contactAttributes: {
    type: Object,
    default: () => ({}),
  },
});

const referer = computed(() => props.conversationAttributes.referer);
const initiatedAt = computed(
  () => props.conversationAttributes.initiated_at?.timestamp
);

const browserLanguage = computed(() =>
  getLanguageName(props.conversationAttributes.browser_language)
);

const createdAtIp = computed(() => props.contactAttributes.created_at_ip);
</script>

<template>
  <div class="current-chat-info">
    <div class="chat-info-container">
      <div class="chat-info-header">
        <h2 class="text-black-800 dark:text-slate-100 text-lg font-semibold">
          {{ $t('CONVERSATION.ONGOING_CONVERSATION') }}
        </h2>
      </div>

      <div class="chat-info-body">
        <div class="chat-info-section">
          <h3
            class="text-black-800 dark:text-slate-100 text-base font-medium mb-2"
          >
            {{ $t('CONVERSATION.BROWSER_INFORMATION') }}
          </h3>
          <div class="chat-info-content">
            <ContactDetailsItem
              v-if="browserLanguage"
              :label="$t('CONVERSATION.BROWSER_LANGUAGE')"
              :value="browserLanguage"
            />
            <ContactDetailsItem
              v-if="referer"
              :label="$t('CONVERSATION.REFERER')"
              :value="referer"
            />
            <ContactDetailsItem
              v-if="initiatedAt"
              :label="$t('CONVERSATION.INITIATED_AT')"
              :value="initiatedAt"
            />
            <ContactDetailsItem
              v-if="createdAtIp"
              :label="$t('CONVERSATION.IP_ADDRESS')"
              :value="createdAtIp"
            />
          </div>
        </div>

        <div class="chat-info-section">
          <h3
            class="text-black-800 dark:text-slate-100 text-base font-medium mb-2"
          >
            {{ $t('CONVERSATION.CUSTOM_ATTRIBUTES') }}
          </h3>
          <CustomAttributes
            :conversation-attributes="conversationAttributes"
            :contact-attributes="contactAttributes"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.current-chat-info {
  @apply h-full overflow-auto;
}

.chat-info-container {
  @apply p-4;
}

.chat-info-header {
  @apply mb-4;
}

.chat-info-section {
  @apply mb-6;
}

.chat-info-content {
  @apply space-y-2;
}
</style>
