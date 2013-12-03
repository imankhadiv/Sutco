class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.string :status
      t.string :access_level

      t.timestamps
    end
  end
end
