class FixTrainings < ActiveRecord::Migration
  def change
	remove_column :trainings, :date, :datetime
	add_column :trainings, :date, :date
	add_column :trainings, :time, :time
	add_column :trainings, :duration, :integer
  end
end
