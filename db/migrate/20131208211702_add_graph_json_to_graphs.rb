class AddGraphJsonToGraphs < ActiveRecord::Migration
  def change
    add_column :graphs, :graph_json, :json
  end
end
