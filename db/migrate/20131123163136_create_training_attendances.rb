class CreateTrainingAttendances < ActiveRecord::Migration
  def change
    create_table :training_attendances do |t|
      t.string :username
      t.string :recorder
      t.references :training, index: true

      t.timestamps
    end
  end
end
