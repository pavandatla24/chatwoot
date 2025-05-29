require 'rails_helper'

RSpec.describe 'Message Metadata', type: :request do
  let(:account) { create(:account) }
  let(:inbox) { create(:inbox, account: account) }
  let(:conversation) { create(:conversation, account: account, inbox: inbox) }
  let(:agent) { create(:user, account: account, role: :agent) }
  let(:headers) { agent.create_new_auth_token }

  before do
    create(:inbox_member, inbox: inbox, user: agent)
  end

  describe 'POST /api/v1/accounts/{account.id}/conversations/{conversation.id}/messages' do
    context 'when message contains urgency keywords' do
      it 'detects urgency and issue type' do
        post "/api/v1/accounts/#{account.id}/conversations/#{conversation.display_id}/messages",
             params: { content: 'URGENT: System is not working, need immediate help' },
             headers: headers

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body
        expect(json_response['content_attributes']['urgency']).to eq('high')
        expect(json_response['content_attributes']['issue_type']).to eq('technical')
      end
    end

    context 'when message contains medium priority keywords' do
      it 'detects medium urgency' do
        post "/api/v1/accounts/#{account.id}/conversations/#{conversation.display_id}/messages",
             params: { content: 'Important: Need help with billing question' },
             headers: headers

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body
        expect(json_response['content_attributes']['urgency']).to eq('medium')
        expect(json_response['content_attributes']['issue_type']).to eq('billing')
      end
    end

    context 'when message contains no urgency keywords' do
      it 'does not add urgency metadata' do
        post "/api/v1/accounts/#{account.id}/conversations/#{conversation.display_id}/messages",
             params: { content: 'Just wanted to say hello' },
             headers: headers

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body
        expect(json_response['content_attributes']['urgency']).to be_nil
        expect(json_response['content_attributes']['issue_type']).to be_nil
      end
    end
  end
end