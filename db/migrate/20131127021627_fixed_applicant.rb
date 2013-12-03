class FixedApplicant < ActiveRecord::Migration
  def change
    drop_table :applicants
    create_table :applicants do |t|
      t.string :name
      t.string :course
      t.integer :ucard
      t.date :year
      t.string :email
      t.string :status
      t.string :level

      t.timestamps
    end
  end
end
