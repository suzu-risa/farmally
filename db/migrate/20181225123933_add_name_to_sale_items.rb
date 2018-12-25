class AddNameToSaleItems < ActiveRecord::Migration[5.2]
  def change
    add_column :sale_items, :name, :string, null: false
  end
end
