module Shared::ConversationsHelper
  def private_conv_seen_status(conversation)
    # if the latest message of a conversation is not created by a current_user
    # and it is unseen, return an unseen-conv value
    not_created_by_user = conversation.messages.last.user_id != current_user.id
    unseen = conversation.messages.last.seen == false
    not_created_by_user && unseen ? 'unseen-conv' : ''
  end

  def group_conv_seen_status(conversation, current_user)
    # CURRENT_USERがnilであれば、それはヘルパーがサービスから呼び出されたことを意味します
    if current_user.nil?
      ''
    else
      # このユーザーが会話の最後のメッセージを作成していない場合
      not_created_by_user = conversation.messages.last.user_id != current_user.id
      seen_by_user = conversation.messages.last.seen_by.include? current_user.id
      not_created_by_user && seen_by_user == false ? 'unseen-conv' : ''
    end
  end
end
