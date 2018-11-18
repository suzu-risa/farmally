class SaleItem < ApplicationRecord
  belongs_to :item
  belongs_to :sale_property_template
end
