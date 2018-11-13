class Group::Conversation < ApplicationRecord
  self.table_name = 'group_conversations'

  has_and_belongs_to_many :users # rubocop:disable Rails/HasAndBelongsToMany
  has_many :messages, # rubocop:disable Rails/InverseOf
           class_name: 'Group::Message',
           foreign_key: 'conversation_id',
           dependent: :destroy
end
