class SaleItem < ApplicationRecord
  has_many_attached :images

  belongs_to :item
  belongs_to :sale_property_template, class_name: "Sale::PropertyTemplate"

  has_many :sale_item_properties,
           class_name: "SaleItemProperty"

  def sale_item_property_attributes=(_sale_item_property_attributes)
    if _sale_item_property_attributes.respond_to?(:values)
      _sale_item_property_attributes = _sale_item_property_attributes.values
    end

    sale_item_properties.destroy_all

    self.sale_item_properties =
      _sale_item_property_attributes.map do |_sale_item_property_attribute|
        sale_item_properties.build(_sale_item_property_attribute)
      end
  end
end
