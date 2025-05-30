class Api::V1::Accounts::AiAgent::InboxesController < Api::V1::Accounts::BaseController
  before_action :current_account
  before_action -> { check_authorization(AiAgent::Topic) }

  before_action :set_topic
  def index
    @inboxes = @topic.inboxes
  end

  def create
    @topic.inboxes << inbox
    head :ok
  end

  def destroy
    @topic.inboxes.delete(inbox)
    head :ok
  end

  private

  def set_topic
    @topic = AiAgent::Topic.find(params[:topic_id])
  end

  def inbox
    @inbox ||= Current.account.inboxes.find(params[:inbox_id])
  end

  def account_topics
    @account_topics ||= Current.account.aiAgent_topics
  end

  def permitted_params
    params.permit(:topic_id, :id, :account_id, :inbox_id)
  end

  def topic_params
    params.require(:inbox).permit(:inbox_id)
  end
end
