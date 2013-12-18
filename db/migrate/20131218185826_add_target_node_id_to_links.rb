class AddTargetNodeIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :target_node_id, :integer
  end
end
