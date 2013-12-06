class CreateGraphs < ActiveRecord::Migration
  def change
    create_table :graphs do |t|
      t.string :name
      t.string :data
      t.references :user, index: true

      t.timestamps
    end
  end
end
