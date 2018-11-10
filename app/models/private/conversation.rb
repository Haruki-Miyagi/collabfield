class Private::Conversation < ApplicationRecord
  self.table_name = 'private_conversations'

  has_many :messages, # rubocop:disable Rails/InverseOf
           class_name: 'Private::Message',
           foreign_key: :conversation_id,
           dependent: :destroy
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User' # rubocop:disable Rails/InverseOf
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User' # rubocop:disable Rails/InverseOf

  scope :between_users, lambda { |user1_id, user2_id|
    where(sender_id: user1_id, recipient_id: user2_id).or(
      where(sender_id: user2_id, recipient_id: user1_id)
    )
  }

  scope :all_by_user, -> (user_id) do
    where(recipient_id: user_id).or(where(sender_id: user_id))
  end

  def opposed_user(user)
    user == recipient ? sender : recipient
  end
end
