class CreateSaleItemProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :sale_item_properties do |t|
      t.references :sale_item, foreign_key: true
      t.references :sale_property, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
