class DorpTrainingAttendances < ActiveRecord::Migration
  def change
    drop_table :training_attendances
    drop_table :workshop_attendances
  end
end
