class FixTrainingsTable < ActiveRecord::Migration

  def change
    #drop_table :trainings
    create_table :trainings do |t|
      t.string :title
      #type is a reserved word
      #t.string :type
      t.string :category
      t.datetime :date
      t.text :description

      t.timestamps
    end
  end
end
