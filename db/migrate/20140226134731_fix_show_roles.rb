class FixShowRoles < ActiveRecord::Migration
  def change
  	remove_column :show_roles, :name, :string
  	remove_column :show_roles, :available_number, :integer
  end
end
