class FixRoleApplication < ActiveRecord::Migration
  def change
    add_column :role_applications, :approved, :boolean
  end
end
