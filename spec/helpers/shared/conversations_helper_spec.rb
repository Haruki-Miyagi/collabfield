require 'rails_helper'

RSpec.describe Shared::ConversationsHelper, type: :helper do # rubocop:disable Metrics/BlockLength
  context '#private_conv_seen_status' do # rubocop:disable Metrics/BlockLength
    it 'returns an empty string' do
      current_user = create(:user)
      conversation = create(:private_conversation)
      create(:private_message,
             conversation_id: conversation.id,
             seen: false,
             user_id: current_user.id)
      allow(helper).to receive(:current_user).and_return(current_user)
      expect(helper.private_conv_seen_status(conversation)).to eq('')
    end

    it 'returns an empty string' do
      current_user = create(:user)
      recipient = create(:user)
      conversation = create(:private_conversation)
      create(:private_message,
             conversation_id: conversation.id,
             seen: true,
             user_id: recipient.id)
      allow(helper).to receive(:current_user).and_return(current_user)
      expect(helper.private_conv_seen_status(conversation)).to eq('')
    end

    it 'returns unseen-conv status' do
      current_user = create(:user)
      recipient = create(:user)
      conversation = create(:private_conversation)
      create(:private_message,
             conversation_id: conversation.id,
             seen: false,
             user_id: recipient.id)
      allow(helper).to receive(:current_user).and_return(current_user)
      expect(helper.private_conv_seen_status(conversation)).to eq('unseen-conv')
    end
  end
end
