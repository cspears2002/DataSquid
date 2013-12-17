class AddSourceToLinks < ActiveRecord::Migration
  def change
    add_column :links, :source, :integer
  end
end
