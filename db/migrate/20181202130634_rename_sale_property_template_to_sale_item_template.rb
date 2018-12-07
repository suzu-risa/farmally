class RenameSalePropertyTemplateToSaleItemTemplate < ActiveRecord::Migration[5.2]
  def change
    rename_table :sale_property_templates, :sale_item_templates
  end
end
