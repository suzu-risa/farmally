class CreateSaleItems < ActiveRecord::Migration[5.2]
  def change
    create_table :sale_items do |t|
      t.references :item, foreign_key: true
      t.integer :price, null: false, default: 0
      t.references :sale_property_template, foreign_key: true

      t.timestamps
    end
  end
end
