class CreateFohs < ActiveRecord::Migration
  def change
    create_table :fohs do |t|
      t.string :position
      t.integer :required_number
      t.integer :available_number
      t.datetime :date
      t.references :show, index: true

      t.timestamps
    end
  end
end
