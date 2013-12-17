class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.integer :group
      t.references :link, index: true

      t.timestamps
    end
  end
end
