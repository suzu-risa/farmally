# == Schema Information
#
# Table name: items
#
#  id                   :bigint(8)        not null, primary key
#  horse_power          :string(255)
#  machine_type         :string(255)
#  maker_price          :integer
#  model                :string(255)
#  original_horse_power :string(255)
#  other                :text(65535)
#  size                 :string(255)
#  sub_maker_price      :integer
#  used_price           :integer
#  weight               :string(255)
#  work_efficiency      :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  category_id          :integer          not null
#  maker_id             :integer          not null
#  sub_category_id      :bigint(8)
#
# Indexes
#
#  index_items_on_sub_category_id  (sub_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (sub_category_id => sub_categories.id)
#

class Item < ApplicationRecord
  belongs_to :maker
  belongs_to :category
  belongs_to :sub_category

  has_many :reviews, dependent: :destroy

  has_many :sale_items, class_name: "SaleItem"

  validates :maker_price, numericality: { only_integer: true }, allow_nil: true
  validates :sub_maker_price, numericality: { only_integer: true }, allow_nil: true
  validates :used_price, numericality: { only_integer: true }, allow_nil: true
  validates :model, length: { maximum: 255 }
  validates :horse_power, length: { maximum: 255 }
  validates :size, length: { maximum: 255 }
  validates :weight, length: { maximum: 255 }
  validates :machine_type, length: { maximum: 255 }
  validates :work_efficiency, length: { maximum: 255 }
  validates :other, length: { maximum: 3000 }

  validate :sub_category_should_be_category_child

  delegate :sale_item_template, to: :category
  delegate :name, to: :maker, prefix: :maker

  scope :for_categories, -> (code) {
    includes(:category).where(categories: { code: code })
  }

  paginates_per 30

  def self.import(file)
    categories_hash = Hash[*Category.all.map { |c| [c.name, c] }.flatten]
    sub_categories_hash = Hash[
      *SubCategory.all.includes(:category).map { |s| ["#{s.category.name}-#{s.name}", s] }.flatten
    ]
    makers_hash = Hash[*Maker.all.map { |m| [m.name, m] }.flatten]

    return { success: false, messages: ['ファイルが空です'] } if file.nil?

    unless utf8_encoding?(file)
      return { success: false, messages: ['ファイルの文字コードはUTF-8である必要があります'] }
    end

    items = []
    error_messages = []
    CSV.foreach(file.path, headers: true) do |row|
      attributes = row.to_hash.slice(*acceptable_attributes)
      item = Item.new(
        maker_price: normalize_price(attributes['maker_price']),
        sub_maker_price: normalize_price(attributes['sub_maker_price']),
        used_price: normalize_price(attributes['used_price']),
        model: attributes['model'],
        size: attributes['size'],
        horse_power: attributes['horse_power'],
        weight: attributes['weight'],
        category: categories_hash[attributes['category']],
        sub_category: sub_categories_hash["#{attributes['category']}-#{attributes['sub_category']}"],
        maker: makers_hash[attributes['maker']],
        machine_type: attributes['machine_type'],
        work_efficiency: attributes['work_efficiency'],
        other: attributes['other']
      )
      items << item
      if item.invalid?
        joined_message = item.errors.full_messages.join(' ')
        error_messages << "#{$INPUT_LINE_NUMBER}行目: #{joined_message}"
      end
    end

    if error_messages.present?
      return { success: false, messages: error_messages }
    end

    ActiveRecord::Base.transaction { items.each(&:save!) }
    { success: true }
  rescue CSV::MalformedCSVError => _e
    { success: false, messages: ['CSVのパース中にエラーが発生しました'] }
  rescue StandardError => e
    Rails.logger.error e
    Rails.logger.error e.backtrace.join("\n")
    { success: false, messages: ['エラーが発生しました'] }
  end

  def self.acceptable_attributes
    %w[
      category
      sub_category
      maker
      model
      size
      horse_power
      machine_type
      work_efficiency
      weight
      maker_price
      sub_maker_price
      used_price
      other
    ]
  end

  def self.utf8_encoding?(file)
    s = IO.binread(file.path)
    s.force_encoding(Encoding::UTF_8)
    s.valid_encoding?
  end

  def self.normalize_price(price)
    return price if price.instance_of?(Integer)
    return price.delete(',').to_i if price.instance_of?(String)
    price
  end

  def self.statistics(category)
    # consider less than 1 yen or more than 5000万円 is invalid value.
    # TODO: Improve efficiency of fetch operations and consider using cache for further performance improvement.
    max = self.where(category: category).where('maker_price > ?', 1).where('maker_price < ?', 40000).maximum(:maker_price)
    min = self.where(category: category).where('maker_price > ?', 1).where('maker_price < ?', 40000).minimum(:maker_price)
    avg = self.where(category: category).where('maker_price > ?', 1).where('maker_price < ?', 40000).average(:maker_price)
    {
        max: max,
        min: min,
        avg: avg,
    }
  end

  def creansing_horse_power!
    if original_horse_power.present?
      update!(horse_power: HorsePowerConverter.new(original_horse_power).convert_to_ps)
    end
  end

  def self.get_item_ids_by_code!(code)
    item_ids = self.for_categories(code).pluck (:id)
    raise ActiveRecord::RecordNotFound if item_ids.empty?
    item_ids
  end

  private

  def sub_category_should_be_category_child
    return if sub_category.nil?
    return if sub_category.category_id == category_id
    errors.add(:sub_category, 'の親カテゴリーと商品のカテゴリーが違います')
  end

  private_class_method :acceptable_attributes, :utf8_encoding?, :normalize_price
end
