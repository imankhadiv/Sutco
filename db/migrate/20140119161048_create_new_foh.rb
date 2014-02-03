class CreateNewFoh < ActiveRecord::Migration
  def change
    create_table :fohs do |t|

      t.references :show_date, index: true
      t.references :position
      t.references :user, index: true
      t.string :phone_number
      t.timestamps
    end
  end
end
