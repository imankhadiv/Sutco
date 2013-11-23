class CreateWorkshopAttendances < ActiveRecord::Migration
  def change
    create_table :workshop_attendances do |t|
      t.string :username
      t.string :recorder
      t.references :workshop, index: true

      t.timestamps
    end
  end
end
