class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :value
      t.boolean :checked

      t.timestamps
    end
  end
end
