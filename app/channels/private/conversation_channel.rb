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
end
