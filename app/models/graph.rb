require 'json'
require 'links.rb'
require 'nodes.rb'

class Graph < ActiveRecord::Base
  belongs_to :user
  has_many :links

  validates :name, presence: true
  validates :data, presence: true

  def parse_file(file_path)
    path = Rails.root.join(file_path);

    # Check to see if the json file exists and is not empty
    if File.exist?(path) &&
       File.extname(path) == ".json" &&
       !File.zero?(path)

          # Open, read, and close file
          file = File.open(path, 'r')
          json = file.read
          file.close

          # Parse the json
          parsed = JSON.parse(json)
          parsed
    end
  end

  # Base graph size off of number of nodes
  def set_graph_size(file_path)
    parsed_json = self.parse_file(file_path)
    nodes = parsed_json["nodes"]
    nodes
  end


  def checked(name_1, name_2)
    # Get the links that belong to the graph
    links = Links.where(graph_id: self)

    # Compare the names to the names in the nodes
    value = false
    links.each do |link|
      src_node = Nodes.find_by(id: link.source_node_id)
      target_node = Nodes.find_by(id: link.target_node_id)
      src_name = src_node.name
      target_name = target_node.name
      if src_name == name_1 && target_name == name_2
        value = true
      end
    end
    value
  end
  
end
