class Private::ConversationChannel < ApplicationCable::Channel
  def subscribed
    # サーバー側のweb通知チャネル作成
    stream_from "private_conversations_#{current_user.id}"
  end

  def unsubscribed
    # 全てを unsubscribe (登録解除)
    stop_all_streams
  end

  def send_message(data)
    message_params = data['message'].each_with_object({}) do |el, hash|
      hash[el['name']] = el['value']
    end
    Private::Message.create(message_params)
  end

  def set_as_seen(data)
    # 会話を見つけて、目に見えないメッセージをすべて設定する
    conversation = Private::Conversation.find(data['conv_id'].to_i)
    messages = conversation.messages.where(seen: false)
    messages.each do |message|
      message.update(seen: true)
    end
  end
end
