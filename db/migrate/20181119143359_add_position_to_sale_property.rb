class AddPositionToSaleProperty < ActiveRecord::Migration[5.2]
  def change
    add_column :sale_properties, :position, :integer, null: false
  end
end
