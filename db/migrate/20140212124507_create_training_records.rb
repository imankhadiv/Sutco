class CreateTrainingRecords < ActiveRecord::Migration
  def change
    create_table :training_records do |t|
      t.integer :user_id
      t.integer :training_id
      t.boolean :attended

      t.timestamps
    end
  end
end
