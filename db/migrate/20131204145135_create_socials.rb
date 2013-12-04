class CreateSocials < ActiveRecord::Migration
  def change
    create_table :socials do |t|
      t.string :title
      t.text :location
      t.text :description
      t.datetime :date
      t.timestamps
    end
  end
end
