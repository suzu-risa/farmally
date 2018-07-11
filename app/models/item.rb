class Item < ApplicationRecord
  belongs_to :maker
  belongs_to :category

  has_many :reviews

  validates :maker_price, numericality: { only_integer: true }, allow_nil: true
  validates :used_price, numericality: { only_integer: true }, allow_nil: true
  validates :model, length: { maximum: 255 }
  validates :horse_power, length: { maximum: 255 }
  validates :size, length: { maximum: 255 }
  validates :weight, length: { maximum: 255 }

  def self.import(file)
    categories_hash = Hash[*Category.all.map { |c| [c.name, c] }.flatten]
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
        used_price: normalize_price(attributes['used_price']),
        model: attributes['model'],
        size: attributes['size'],
        horse_power: attributes['horse_power'],
        weight: attributes['weight'],
        category: categories_hash[attributes['category']],
        maker: makers_hash[attributes['maker']]
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
    %w[maker_price used_price model horse_power size weight category maker]
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

  private_class_method :acceptable_attributes, :utf8_encoding?, :normalize_price
end
