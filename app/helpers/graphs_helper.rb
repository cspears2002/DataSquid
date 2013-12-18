module GraphsHelper

  def make_headers graph
    graph.set_graph_size(graph.data).each do |node|
      node["name"]
    end
  end

end
