module GraphsHelper

  def horizonal_row graph
    graph.set_graph_size(graph.data).each do |node|
      node["name"]
    end
  end

end
