class AddSourceNodeIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :source_node_id, :integer
  end
end
