module Shared::MessagesHelper
  def append_previous_messages_partial_path
    'shared/load_more_messages/window/append_messages'
  end

  def remove_link_to_messages
    if @is_messenger == 'false'
      if @messages_to_display_offset != 0
        'shared/empty_partial'
      else
        'shared/load_more_messages/window/remove_more_messages_link'
      end
    else
      'shared/empty_partial'
    end
  end

  # スクロールバーが表示されるまでメッセンジャーに前のメッセージをロードする
  def autoload_messenger_messages
    if @is_messenger == 'true'
      # 以前のメッセージが存在する場合は、それらをロードします
      if @messages_to_display_offset != 0
        'shared/load_more_messages/messenger/load_previous_messages'
      else
        # 削除負荷前のメッセージのリンク
        'shared/load_more_messages/messenger/remove_previous_messages_link'
      end
    else
      'shared/empty_partial'
    end
  end
end
