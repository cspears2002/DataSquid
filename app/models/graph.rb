require 'json'

class Graph < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :data, presence: true

  def parse_file(path)
    # check to see if the json file exists and is not empty
    if File.exist?(path) &&
       File.extname(path) == ".json" &&
       !File.zero?(path)
          file = open(path)
          json = file.read
          parsed = JSON.parse(json)
          puts parse
    end
  end
  
end
