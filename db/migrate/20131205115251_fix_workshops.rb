class FixWorkshops < ActiveRecord::Migration
  def change
	remove_column :workshops, :date, :datetime
	add_column :workshops, :date, :date
	add_column :workshops, :time, :time
	add_column :workshops, :duration, :integer
  end
end
