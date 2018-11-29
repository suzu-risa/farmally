class SaleItem < ApplicationRecord
  has_many_attached :images

  belongs_to :item
  belongs_to :sale_property_template, class_name: "Sale::PropertyTemplate"

  has_many :sale_item_properties,
           class_name: "SaleItemProperty"

  has_many :inquiries, foreign_key: :sale_item_id, class_name: "SaleItemInquiry"

  delegate :model, to: :item

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

  def detail_json=(hash_or_json)
    if hash_or_json.is_a?(Hash)
      hash_or_json = hash_or_json.to_json
    end

    super(hash_or_json)
  end

  def detail
    detail_hash = JSON.parse(detail_json || '{ "properties": {} }')

    Hashie::Mash.new(detail_hash)
  end

  def detail_with_template
    detail_hash = {
      tables: [
      ]
    }

    sale_property_template.detail.tables.each do |detail_table|
      _hash = { name: detail_table.name, properties: [] }

      detail_table.properties.each do |property|
        _hash[:properties].push(
          { name: property.property_name, value: detail.properties[property.property_key] }
        )
      end

      detail_hash[:tables].push(_hash)
    end

    Hashie::Mash.new(detail_hash)
  end
end
