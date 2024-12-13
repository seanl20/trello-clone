class RemoveClassListFromItems < ActiveRecord::Migration[7.2]
  def change
    remove_column :items, :class_list
  end
end
