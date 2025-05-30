FactoryBot.define do
  factory :aiAgent_copilot_thread, class: 'CopilotThread' do
    account
    user
    title { Faker::Lorem.sentence }
    topic { create(:aiAgent_topic, account: account) }
  end
end
