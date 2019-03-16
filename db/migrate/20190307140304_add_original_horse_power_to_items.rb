class AddOriginalHorsePowerToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :original_horse_power, :string
  end
end
