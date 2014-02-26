class AddColumnToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :body, :text
  end
end
