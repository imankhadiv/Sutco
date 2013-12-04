class FixTables < ActiveRecord::Migration
  def change
    drop_table :profiles
    drop_table :applicants
  end
end
