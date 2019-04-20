class CreateItemMarketPrices < ActiveRecord::Migration[5.2]
  def change
    create_table :item_market_prices do |t|
      t.string :category_name, null: false
      t.string :sub_category_name, null: false
      t.string :area, null: false
      t.string :maker_name, null: false
      t.string :model, null: false
      t.integer :sold_count, null: false
      t.text :detail_json
      t.integer :from_year, null: false
      t.integer :to_year, null: false
      t.integer :max_price, null: false
      t.integer :average_price, null: false
      t.integer :min_price, null: false

      t.timestamps
    end
  end
end
