class CreateRoleApplications < ActiveRecord::Migration
  def change
    create_table :role_applications do |t|
      t.integer :show_role_id
      t.integer :user_id
      t.text :content

      t.timestamps
    end
  end
end
