class Private::Conversation < ApplicationRecord
  self.table_name = 'private_conversations'

  has_many :messages, # rubocop:disable Rails/InverseOf
           class_name: 'Private::Message',
           foreign_key: :conversation_id,
           dependent: :destroy
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User' # rubocop:disable Rails/InverseOf
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User' # rubocop:disable Rails/InverseOf
end
