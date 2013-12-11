class FixSocials < ActiveRecord::Migration
  def change
	remove_column :socials, :date, :datetime
	add_column :socials, :date, :date
	add_column :socials, :time, :time
	add_column :socials, :duration, :integer
  end
end
