FactoryBot.define do
  factory :aiAgent_topic, class: 'AiAgent::Topic' do
    sequence(:name) { |n| "Topic #{n}" }
    description { 'Test description' }
    association :account
  end
end
