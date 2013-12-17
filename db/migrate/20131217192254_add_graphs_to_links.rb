class AddGraphsToLinks < ActiveRecord::Migration
  def change
    add_reference :links, :graph, index: true
  end
end
