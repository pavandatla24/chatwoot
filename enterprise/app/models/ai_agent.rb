class AiAgent < ApplicationRecord
  has_many :ai_agent_inboxes, dependent: :destroy
  has_many :inboxes, through: :ai_agent_inboxes

  validates :name, presence: true
  validates :description, presence: true
end