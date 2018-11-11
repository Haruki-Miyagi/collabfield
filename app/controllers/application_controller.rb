class ApplicationController < ActionController::Base
  before_action :opened_conversations_windows
  before_action :all_ordered_conversations

  def opened_conversations_windows
    if user_signed_in?
      # opened conversations
      session[:private_conversations] ||= []
      @private_conversations_windows = Private::Conversation.includes(:recipient, :messages).find(session[:private_conversations])
    else
      @private_conversations_windows = []
    end
  end

  def all_ordered_conversations
    @all_conversations = OrderConversationsService.new(user: current_user).call if user_signed_in?
  end
end
