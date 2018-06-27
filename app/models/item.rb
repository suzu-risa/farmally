class Item < ApplicationRecord
  belongs_to :maker
  belongs_to :category

  validates :maker_price, numericality: { only_integer: true }, allow_nil: true
  validates :used_price, numericality: { only_integer: true }, allow_nil: true
  validates :model, length: { maximum: 255 }
  validates :horse_power, length: { maximum: 255 }
  validates :size, length: { maximum: 255 }
  validates :weight, length: { maximum: 255 }

  def self.import(file)
    categories_hash = Hash[*Category.all.map { |c| [c.name, c] }.flatten]
    makers_hash = Hash[*Maker.all.map { |m| [m.name, m] }.flatten]
    ActiveRecord::Base.transaction do
      CSV.foreach(file.path, headers: true) do |row|
        attributes = row.to_hash.slice(*acceptable_attributes)
        item = Item.new(
          maker_price: attributes['maker_price'],
          used_price: attributes['used_price'],
          model: attributes['model'],
          size: attributes['size'],
          weight: attributes['weight'],
          category: categories_hash[attributes['category']],
          maker: makers_hash[attributes['maker']]
        )
        item.save!
      end
    end
  end

  def self.acceptable_attributes
    %w[maker_price used_price model horse_power size weight category maker]
  end
end
