class RemoveNodeIdFromLinks < ActiveRecord::Migration
  def change
    remove_column :links, :node_id, :reference
  end
end
