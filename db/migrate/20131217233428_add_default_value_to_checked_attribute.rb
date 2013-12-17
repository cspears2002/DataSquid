class AddDefaultValueToCheckedAttribute < ActiveRecord::Migration
  def change
    change_column_default :links, :checked, true
  end
end
