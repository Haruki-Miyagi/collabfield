class CreateGroupConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :group_conversations do |t|

      t.timestamps
    end
  end
end
