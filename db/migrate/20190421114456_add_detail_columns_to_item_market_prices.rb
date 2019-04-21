class AddDetailColumnsToItemMarketPrices < ActiveRecord::Migration[5.2]
  def change
    add_column :item_market_prices, :number_of_thread, :integer
    add_column :item_market_prices, :tank, :boolean
    add_column :item_market_prices, :planting_method, :string
    add_column :item_market_prices, :cabin, :boolean
    add_column :item_market_prices, :fertilizer, :boolean
    add_column :item_market_prices, :horse_power, :integer
    add_column :item_market_prices, :drive_system, :string
    add_column :item_market_prices, :safety_frame, :string
    add_column :item_market_prices, :rotary, :boolean
  end
end
