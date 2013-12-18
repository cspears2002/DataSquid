class RemoveCheckedFromLinks < ActiveRecord::Migration
  def change
    remove_column :links, :checked, :boolean
  end
end
