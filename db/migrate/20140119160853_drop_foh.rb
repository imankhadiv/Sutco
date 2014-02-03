class DropFoh < ActiveRecord::Migration
  def change
    drop_table :fohs
  end
end
