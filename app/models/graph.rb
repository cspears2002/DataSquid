require 'json'

class Graph < ActiveRecord::Base
  belongs_to :user

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

  # Determine if a checkbox should be checked
  def is_checked(file_path, src, target)
    parsed_json = self.parse_file(file_path)
    nodes = parsed_json["nodes"]

    # Create a hash of { name => index }
    names_array = Array.new
    nodes.each do |node|
      names_array.push(node["name"])
    end
    names_hash = Hash[names_array.map.with_index.to_a]

    # Compare passed in source and target to source/target
    # pairs in links array
    src_target_hash = {source: names_hash[src],
                       target: names_hash[target]}
    links = parsed_json["links"]
    links.each do |link|
      if link["source"] == src_target_hash[:source] and 
         link["target"] == src_target_hash[:target]
          is_checked = true
          break
      end
    end

    is_checked

  end
  
end
