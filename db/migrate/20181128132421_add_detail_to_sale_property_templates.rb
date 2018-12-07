class AddDetailToSalePropertyTemplates < ActiveRecord::Migration[5.2]
  def change
    add_column :sale_property_templates, :detail_json, :json
  end
end
