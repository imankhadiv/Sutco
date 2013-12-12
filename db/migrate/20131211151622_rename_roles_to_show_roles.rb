class RenameRolesToShowRoles < ActiveRecord::Migration
  def change
    rename_table :roles, :show_roles
  end
end
