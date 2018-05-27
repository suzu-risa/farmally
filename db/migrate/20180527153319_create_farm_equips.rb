class CreateFarmEquips < ActiveRecord::Migration[5.2]
  def change
    create_table :farm_equips do |t|
      t.string :maker_price
      t.string :integer
      t.string :used_price
      t.string :integer
      t.string :maker
      t.string :model
      t.string :horse_power
      t.string :string
      t.string :josu
      t.string :integer
      t.string :model_year
      t.string :integer
      t.string :drive_system
      t.string :string
      t.string :safety_frame
      t.string :string
      t.string :rotary
      t.string :string
      t.string :hour_meter
      t.string :string
      t.string :accessories
      t.string :string
      t.string :location
      t.string :string
      t.string :condition
      t.string :string
      t.string :category_id
      t.string :integer

      t.timestamps
    end
  end
end
