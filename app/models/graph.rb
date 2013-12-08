class Graph < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :data, presence: true
  
end
