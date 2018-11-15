class Group::Message < ApplicationRecord
  self.table_name = 'group_messages'

  serialize :seen_by, Array
  serialize :added_new_users, Array

  belongs_to  :conversation, # rubocop:disable Rails/InverseOf
              class_name: 'Group::Conversation',
              foreign_key: 'conversation_id'
  belongs_to :user

  validates :content, presence: true
  validates :user_id, presence: true
  validates :conversation_id, presence: true

  default_scope { includes(:user) }

  # 会話の前のメッセージを得る
  def previous_message
    previous_message_index = conversation.messages.index(self) - 1
    conversation.messages[previous_message_index]
  end
end
