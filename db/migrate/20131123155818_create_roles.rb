class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.string :position
      t.integer :required_number
      t.integer :available_number
      t.references :show, index: true

      t.timestamps
    end
  end
end
