class Links < ActiveRecord::Base
  has_one :source_node, class_name: 'Node'
  has_one :target_node, class_name: 'Node'

end
