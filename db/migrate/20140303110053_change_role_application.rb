class ChangeRoleApplication < ActiveRecord::Migration
  def change
	remove_column :role_applications, :approved, :boolean
	add_column :role_applications, :status, :string
  end
end
