# == Schema Information
#
# Table name: ai_agent_topic_responses
#
#  id                :bigint           not null, primary key
#  answer            :text             not null
#  documentable_type :string
#  embedding         :vector(1536)
#  question          :string           not null
#  status            :integer          default("available"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  account_id        :bigint           not null
#  documentable_id   :bigint
#  topic_id          :bigint           not null
#
# Indexes
#
#  index_ai_agent_topic_responses_on_account_id    (account_id)
#  index_ai_agent_topic_responses_on_documentable  (documentable_type,documentable_id)
#  index_ai_agent_topic_responses_on_status        (status)
#  index_ai_agent_topic_responses_on_topic_id      (topic_id)
#  vector_idx_knowledge_entries_embedding          (embedding) USING ivfflat
#
class AiAgent::TopicResponse < ApplicationRecord
  self.table_name = 'ai_agent_topic_responses'

  belongs_to :topic, class_name: 'AiAgent::Topic'
  belongs_to :documentable, polymorphic: true, optional: true
  belongs_to :account
  has_neighbors :embedding, normalize: true

  validates :question, presence: true
  validates :answer, presence: true
  validates :account_id, presence: true
  validates :topic_id, presence: true

  before_validation :ensure_account
  before_validation :ensure_status
  after_commit :update_response_embedding

  scope :ordered, -> { order(created_at: :desc) }
  scope :for_account, ->(account_id) { where(account_id: account_id) }
  scope :for_topic, ->(topic_id) { where(topic_id: topic_id) }
  scope :for_document, ->(document_id) { where(documentable_id: document_id) }
  scope :for_documentable_type, ->(documentable_type) { where(documentable_type: documentable_type) }

  enum status: {
    available: 1,
    archived: 2
  }

  def self.search(query)
    embedding = AiAgent::Llm::EmbeddingService.new.get_embedding(query)
    nearest_neighbors(:embedding, embedding, distance: 'cosine').limit(5)
  end

  def push_event_data
    {
      id: id,
      question: question,
      answer: answer,
      topic_id: topic_id,
      documentable_id: documentable_id,
      documentable_type: documentable_type,
      created_at: created_at,
      updated_at: updated_at,
      status: status
    }
  end

  private

  def ensure_status
    self.status ||= :available
  end

  def ensure_account
    self.account = topic&.account
  end

  def update_response_embedding
    return unless saved_change_to_question? || saved_change_to_answer? || embedding.nil?

    AiAgent::Llm::UpdateEmbeddingJob.perform_later(self, "#{question}: #{answer}")
  end
end
