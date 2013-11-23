class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :name
      t.string :image
      t.string :director
      t.string :stage_manager
      t.string :producer
      t.text :synopsis

      t.timestamps
    end
  end
end
