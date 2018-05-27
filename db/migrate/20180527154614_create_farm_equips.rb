class CreateFarmEquips < ActiveRecord::Migration[5.2]
  def change
    create_table :farm_equips do |t|
      t.integer :maker_price
      t.integer :used_price
      t.string :maker, index: true
      t.string :model
      t.string :horse_power
      t.string :josu
      t.integer :model_year
      t.string :drive_system
      t.string :safety_frame
      t.string :rotary
      t.string :hour_meter
      t.string :accessories
      t.string :location
      t.string :condition
      t.string :category_code, index: true

      t.timestamps
    end
  end
end
