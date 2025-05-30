module Enterprise::Concerns::Inbox
  extend ActiveSupport::Concern

  included do
    has_one :aiAgent_inbox, dependent: :destroy, class_name: 'AiAgentInbox'
    has_one :aiAgent_topic,
            through: :aiAgent_inbox,
            class_name: 'AiAgent::Topic'
  end
end
