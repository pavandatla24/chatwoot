import { shallowMount } from '@vue/test-utils';
import MessageMetadata from '../MessageMetadata.vue';

describe('MessageMetadata.vue', () => {
  it('renders correctly with urgency and issue type', () => {
    const wrapper = shallowMount(MessageMetadata, {
      props: {
        contentAttributes: {
          urgency: 'high',
          issue_type: 'technical',
        },
      },
      global: {
        mocks: {
          $t: msg => msg,
        },
      },
    });

    expect(wrapper.find('.message-metadata').exists()).toBe(true);
    expect(wrapper.find('.urgency').exists()).toBe(true);
    expect(wrapper.find('.badge').text()).toBe('HIGH');
    expect(wrapper.find('.value').text()).toBe('technical');
  });

  it('does not render when no metadata is present', () => {
    const wrapper = shallowMount(MessageMetadata, {
      props: {
        contentAttributes: {},
      },
    });

    expect(wrapper.find('.message-metadata').exists()).toBe(false);
  });

  it('renders only urgency when issue type is missing', () => {
    const wrapper = shallowMount(MessageMetadata, {
      props: {
        contentAttributes: {
          urgency: 'medium',
        },
      },
      global: {
        mocks: {
          $t: msg => msg,
        },
      },
    });

    expect(wrapper.find('.urgency').exists()).toBe(true);
    expect(wrapper.find('.badge').text()).toBe('MEDIUM');
    expect(wrapper.find('.value').exists()).toBe(false);
  });

  it('renders only issue type when urgency is missing', () => {
    const wrapper = shallowMount(MessageMetadata, {
      props: {
        contentAttributes: {
          issue_type: 'billing',
        },
      },
      global: {
        mocks: {
          $t: msg => msg,
        },
      },
    });

    expect(wrapper.find('.urgency').exists()).toBe(false);
    expect(wrapper.find('.value').text()).toBe('billing');
  });
});
