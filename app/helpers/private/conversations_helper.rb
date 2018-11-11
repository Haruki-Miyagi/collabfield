module Private::ConversationsHelper
  include Shared::ConversationsHelper
  # チャットの相手となるユーザーを取得
  def private_conv_recipient(conversation)
    conversation.opposed_user(current_user)
  end

  # if the conversation has unshown messages, show a button to get them
  def load_private_messages(conversation)
    if conversation.messages.count.positive?
      'private/conversations/conversation/messages_list/link_to_previous_messages'
    else
      'shared/empty_partial'
    end
  end

  def add_to_contacts_partial_path(contact)
    if recipient_is_contact?
      'shared/empty_partial'
    else
      non_contact(contact)
    end
  end

  # 表示する会話見出しのスタイルを決定する
  def conv_heading_class(contact)
    # オプションを付けないで会話の見出しを表示する
    if unaccepted_contact_exists(contact)
      'conversation-heading-full'
    else
      'conversation-heading'
    end
  end

  def get_contact_record(recipient)
    contact = Contact.find_by_users(current_user.id, recipient.id)
  end

  # 受け入れられていない連絡先のステータスがあればそれを表示する
  def unaccepted_contact_request_partial_path(contact)
    if unaccepted_contact_exists(contact) 
      if request_sent_by_user(contact)
        "private/conversations/conversation/request_status/sent_by_current_user"  
      else
        "private/conversations/conversation/request_status/sent_by_recipient" 
      end
    else
      'shared/empty_partial'
    end
  end

  # 連絡先を送信するためのリンクを表示する
  # 反対のユーザーが連絡先になく、要求が存在しない場合
  def not_contact_no_request_partial_path(contact)
    if recipient_is_contact? == false && unaccepted_contact_exists(contact) == false
      "private/conversations/conversation/request_status/send_request"
    else
      'shared/empty_partial'
    end
  end

  private

  # 受信者がユーザーの連絡先かどうかの確認する
  def recipient_is_contact?
    contacts = current_user.all_active_contacts
    contacts.find { |contact| contact['id'] == @recipient.id }.present?
  end

  def non_contact(contact)
    # if 連絡先の要求がユーザーまたは受信者によって送信された場合
    if unaccepted_contact_exists(contact)
      'shared/empty_partial'
    else
      # 件の連絡リクエストはどのユーザーからも送信されません
      'private/conversations/conversation/heading/add_user_to_contacts'
    end
  end

  def unaccepted_contact_exists(contact)
    if contact.present?
      contact.accepted ? false : true
    else
      false
    end
  end

  def request_sent_by_user(contact)
    # 連絡先要求がcurrent_userによって送信された場合はtrue
    # 受信者によって送信された場合は＃false
    contact['user_id'] == current_user.id
  end
end
