class CreateSaleProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :sale_properties do |t|
      t.references :sale_property_template, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
