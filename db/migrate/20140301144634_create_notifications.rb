class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :conversation_id
      t.integer :comment_id
      t.integer :user_id
      t.boolean :seen, default:false

      t.timestamps
    end
  end
end
