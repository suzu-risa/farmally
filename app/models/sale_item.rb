# == Schema Information
#
# Table name: sale_items
#
#  id                    :bigint(8)        not null, primary key
#  detail_json           :json
#  horse_power           :string(255)
#  name                  :string(255)      not null
#  prefecture_code       :integer
#  price                 :integer
#  price_text            :string(255)      not null
#  sold_at               :datetime
#  staff_comment         :text(65535)
#  status                :integer
#  used_hours            :integer
#  year                  :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  item_id               :bigint(8)
#  sale_item_template_id :bigint(8)
#  staff_id              :bigint(8)
#
# Indexes
#
#  index_sale_items_on_item_id                (item_id)
#  index_sale_items_on_sale_item_template_id  (sale_item_template_id)
#  index_sale_items_on_staff_id               (staff_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (sale_item_template_id => sale_item_templates.id)
#

class SaleItem < ApplicationRecord
  include JpPrefecture
  jp_prefecture :prefecture_code

  enum status: { try_display: 0, under_maintenance: 1, maintenanced: 2, sold_out: 3 }

  has_many_attached :images

  belongs_to :staff, optional: true
  belongs_to :item
  belongs_to :sale_item_template,
             class_name: "SaleItemTemplate",
             foreign_key: :sale_item_template_id # TODO: カラム名変更
  has_many :inquiries, foreign_key: :sale_item_id, class_name: "SaleItemInquiry"

  validates :price, presence: true

  delegate :model, :category, :sub_category, :maker, to: :item
  delegate :name, :id, to: :category, prefix: :category
  delegate :name, to: :maker, prefix: :maker
  delegate :name, to: :prefecture, prefix: :prefecture, allow_nil: true
  delegate :name, to: :staff, prefix: :staff, allow_nil: true

  scope :for_sale, -> {
    where.not(status: 3)
  }

  scope :sold, -> {
    where(status: 3)
  }

  def for_sale?
    sold_at.nil?
  end

  def sold?
    sold_at.present? || sold_out?
  end

  def related_sale_items
    self.class.joins(:item).
      where(items: { category_id: category_id }).
      where.not(sale_items: { id: id })
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
