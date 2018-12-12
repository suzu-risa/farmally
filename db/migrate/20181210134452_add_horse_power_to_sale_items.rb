class AddHorsePowerToSaleItems < ActiveRecord::Migration[5.2]
  def change
    add_column :sale_items, :horse_power, :string
  end
end
