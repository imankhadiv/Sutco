class ChangeUsers < ActiveRecord::Migration
  def change
    remove_column :users, :year, :date
    add_column :users, :level, :string
  end
end
