class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy

  has_many :private_messages, class_name: 'Private::Message', dependent: :destroy
  has_many :private_conversations, # rubocop:disable Rails/InverseOf
           foreign_key: :sender_id,
           class_name: 'Private::Conversation',
           dependent: :destroy

  has_many :contacts, dependent: :destroy
  has_many :all_received_contact_requests, # rubocop:disable Rails/HasManyOrHasOneDependent, Rails/InverseOf
           class_name: 'Contact',
           foreign_key: 'contact_id'
  has_many :accepted_sent_contact_requests, -> { where(contacts: { accepted: true }) },
           through: :contacts,
           source: :contact
  has_many :accepted_received_contact_requests, -> { where(contacts: { accepted: true }) },
           through: :all_received_contact_requests,
           source: :user
  has_many :pending_sent_contact_requests, ->  { where(contacts: { accepted: false }) },
           through: :contacts,
           source: :contact
  has_many :pending_received_contact_requests, -> { where(contacts: { accepted: false }) },
           through: :all_received_contact_requests,
           source: :user

  has_many :group_messages, class_name: 'Group::Message', dependent: :destroy
  has_and_belongs_to_many :group_conversations, class_name: 'Group::Conversation' # rubocop:disable Rails/HasAndBelongsToMany

  # すべての連絡先の取得
  def all_active_contacts
    accepted_sent_contact_requests | accepted_received_contact_requests
  end

  # 保留中の送受信された連絡先を取得する
  def pending_contacts
    pending_sent_contact_requests | pending_received_contact_requests
  end

  # 連絡先レコードを取得する
  def contact(contact)
    Contact.where(user_id: id, contact_id: contact.id)[0]
  end
end
