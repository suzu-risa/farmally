class AddDetailJsonToSaleItem < ActiveRecord::Migration[5.2]
  def change
    add_column :sale_items, :detail_json, :json
  end
end
