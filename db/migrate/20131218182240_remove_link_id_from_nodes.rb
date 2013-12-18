class RemoveLinkIdFromNodes < ActiveRecord::Migration
  def change
    remove_column :nodes, :link_id, :reference
  end
end
