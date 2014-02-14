class CreateWorkshopRecords < ActiveRecord::Migration
  def change
    create_table :workshop_records do |t|
      t.integer :user_id
      t.integer :workshop_id
      t.boolean :attended

      t.timestamps
    end
  end
end
