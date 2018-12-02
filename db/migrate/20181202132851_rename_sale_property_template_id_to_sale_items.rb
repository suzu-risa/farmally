class RenameSalePropertyTemplateIdToSaleItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :sale_items, :sale_property_template_id, :sale_item_template_id
  end
end
