class AddColumnsToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :machine_type, :string
    add_column :items, :work_efficiency, :string
    add_column :items, :other, :text
  end
end
