class SaleItem < ApplicationRecord
  belongs_to :item
  belongs_to :property_template,
             class_name: "Sale::PropertyTemplate",
             foreign_key: :sale_property_template_id
end
