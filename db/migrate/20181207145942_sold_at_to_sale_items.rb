class SoldAtToSaleItems < ActiveRecord::Migration[5.2]
  def change
    add_column :sale_items, :sold_at, :datetime
  end
end
