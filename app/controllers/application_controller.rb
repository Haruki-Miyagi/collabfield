class ApplicationController < ActionController::Base
  before_action :opened_conversations_windows

  def opened_conversations_windows
    if user_signed_in?
      # opened conversations
      session[:private_conversations] ||= []
      @private_conversations_windows = Private::Conversation.includes(:recipient, :messages).find(session[:private_conversations])
    else
      @private_conversations_windows = []
    end
  end
end
