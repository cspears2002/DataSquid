class AddFilePathToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :file_path, :string
  end
end
