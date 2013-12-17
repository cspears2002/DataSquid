class AddTargetToLinks < ActiveRecord::Migration
  def change
    add_column :links, :target, :integer
  end
end
