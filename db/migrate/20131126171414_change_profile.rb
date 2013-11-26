class ChangeProfile < ActiveRecord::Migration
  def change
    drop_table :profiles
    create_table :profiles do |t|
      t.string :name
      t.string :course
      t.integer :ucard
      t.date :year
      t.string :email
      t.references :applicant

      t.timestamps
    end
  end
end
