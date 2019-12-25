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
#  remark                :text(65535)
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
  has_many :sale_item_images,
           ->{ order("position asc") },
           class_name: "SaleItemImage"

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

  scope :displayable_category, -> {
    eager_load(item: :category).where(categories: { displayable: Category::Displayed })
  }

  scope :sellable_item, -> {
    where.not(status: SaleItem.statuses[:sold_out]).or(SaleItem.where(status: nil))
  }

  paginates_per 4

  # TODO: ファイルのマイグレーションが終わったらリファクタする
  def new_images
    sale_item_images.map(&:image)
  end

  alias_method :old_images, :images

  alias_method :images, :new_images

  def migrate_images_to_sale_item_images
    return false if sale_item_images.present?

    ActiveRecord::Base.transaction do
      old_images.each_with_index do |original_image, i|
        sale_item_image = sale_item_images.create!(position: i)

        ActiveStorage::Downloader.new(original_image).download_blob_to_tempfile do |tempfile|
          sale_item_image.image.attach({
            io: tempfile,
            filename: original_image.blob.filename,
            content_type: original_image.blob.content_type
          })

          sale_item_image.image.update!(
            name: 'image',
            record_type: 'SaleItemImage',
            record_id: sale_item_image.id,
          )
        end
      end
    end
  end

  def for_sale?
    sold_at.nil?
  end

  def sold?
    sold_out?
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

  def self.get_sale_items(params)
    if params[:code].present?
      item_ids = Item.get_item_ids_by_code!(params[:code])
      sale_items = self.sellable_item.where(item_id: item_ids).page(params[:page])
    else
      sale_items = self.sellable_item.displayable_category.page(params[:page])
    end

    raise ActiveRecord::RecordNotFound if sale_items.empty? && params[:page].present?
    sale_items
  end

  def self.get_sale_item_count(params)
    if params[:code].present?
      item_ids = Item.get_item_ids_by_code!(params[:code])
      sale_item_count = self.sellable_item.where(item_id: item_ids).count
    else
      sale_item_count = self.sellable_item.displayable_category.count
    end
  end
end
