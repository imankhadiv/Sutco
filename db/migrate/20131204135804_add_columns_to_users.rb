class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :ucard, :string
    add_column :users, :course, :string
    add_column :users, :year, :date
    add_column :users, :approved, :boolean, :default => false, :null => false
    add_index  :users, :approved
  end
end
