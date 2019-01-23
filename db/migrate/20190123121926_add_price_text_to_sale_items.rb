class AddPriceTextToSaleItems < ActiveRecord::Migration[5.2]
  def change
    change_column :sale_items, :price, :integer, null: true, default: nil
    add_column :sale_items, :price_text, :string, null: false
  end
end
