class FixShowDates < ActiveRecord::Migration
  def change
    remove_column :show_dates, :title, :string
  end
end
