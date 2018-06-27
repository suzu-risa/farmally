class AddNullFalseOptionToItems < ActiveRecord::Migration[5.2]
  def up
    change_column :items, :category_id, :integer, null: false
    change_column :items, :maker_id, :integer, null: false
  end

  def down
    change_column :items, :category_id, :integer, null: true
    change_column :items, :maker_id, :integer, null: true
  end
end
