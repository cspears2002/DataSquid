require 'json'

class Graph < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :data, presence: true

  def set_graph_size(file_path)
    parsed_json = self.parse_file(file_path)
    nodes = parsed_json["nodes"]

    nodes
  end

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
  
end
