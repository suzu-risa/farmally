class SaleItemProperty < ApplicationRecord
  belongs_to :sale_item
  belongs_to :property,
             class_name: "Sale::Property",
             foreign_key: :sale_property_id

  delegate :name, to: :property
end
