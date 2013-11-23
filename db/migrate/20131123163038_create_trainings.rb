class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.string :title
      t.string :type
      t.datetime :date
      t.text :description

      t.timestamps
    end
  end
end
