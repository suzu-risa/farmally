class SaleItem < ApplicationRecord
  has_many_attached :images

  belongs_to :item
  belongs_to :sale_item_template,
             class_name: "SaleItemTemplate",
             foreign_key: :sale_item_template_id # TODO: カラム名変更
  has_many :inquiries, foreign_key: :sale_item_id, class_name: "SaleItemInquiry"

  validates :price, presence: true

  delegate :model, :category, :sub_category, :maker, to: :item
  delegate :name, to: :category, prefix: :category

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

    sale_item_template.detail.tables.each do |detail_table|
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
