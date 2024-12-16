class AddPostionToList < ActiveRecord::Migration[7.2]
  def change
    add_column :lists, :position, :integer, null: false, default: 0
  end
end
