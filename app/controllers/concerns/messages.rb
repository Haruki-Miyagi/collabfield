require 'active_support/concern'

module Messages
  extend ActiveSupport::Concern

  def get_messages(conversation_type, messages_amount) # rubocop:disable Metrics/AbcSize
    # convert a string into a constant, so the models can be called dynamically
    model = "#{conversation_type.capitalize}::Conversation".constantize
    @conversation = model.find(params[:conversation_id])
    # get previous messages of the conversation
    @messages = @conversation.messages.order(created_at: :desc)
                             .limit(messages_amount)
                             .offset(params[:messages_to_display_offset].to_i)
    # set a variable to get another previous messages of the conversation
    @messages_to_display_offset = params[:messages_to_display_offset].to_i + messages_amount

    @type = conversation_type.downcase
    # if messages are the last in the conversation, mark the variable as 0
    # so the load more messages link will be removed
    @messages_to_display_offset = 0 if @conversation.messages.count < @messages_to_display_offset
  end
end
