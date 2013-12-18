class Links < ActiveRecord::Base
  belongs_to :source_node, class_name: 'Node'
  belongs_to :target_node, class_name: 'Node'

  def compare_names(graph, name_1, name_2)
    links = Link.find_by(graph_id: graph)
    links.each do |link|
      src_node = Node.find_by(id: link.source_node_id)
      target_node = Node.find_by(id: link.target_node_id)
      src_name = src_node.name
      target_name = target_node.name
      if (src_name == name_1) and (target_node == name_2)
        true
      else
        false
      end
    end
  end

end
