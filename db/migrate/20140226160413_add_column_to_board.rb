class AddColumnToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :public, :boolean
    add_column :boards, :show_id, :integer
  end
end
