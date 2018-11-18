class Sale::Property < ApplicationRecord
  belongs_to :template,
             foreign_key: :sale_property_template_id,
             class_name: "Sale::PropertyTemplate"
end
