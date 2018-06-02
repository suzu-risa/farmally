class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :maker_price
      t.integer :used_price
      t.string :model
      t.string :horse_power
      t.string :size
      t.string :weight
      t.integer :category_id
      t.integer :maker_id

      t.timestamps
    end
  end
end
