class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string :title
      t.text :description
      t.datetime :date

      t.timestamps
    end
  end
end
