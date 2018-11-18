class CreateSalePropertyTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :sale_property_templates do |t|
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
