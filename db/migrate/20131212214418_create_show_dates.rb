class CreateShowDates < ActiveRecord::Migration
  def change
    create_table :show_dates do |t|
      t.string :title
      t.date :date
      t.time :time
      t.references :show, index: true

      t.timestamps
    end
  end
end
