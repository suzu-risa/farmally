class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :items

  validates :name, presence: true
  validates :code, presence: true, uniqueness: { scope: :category }

  validate :category_should_be_parent

  private

  def category_should_be_parent
    item = Item.find_by(sub_category: self)
    return if item.nil?
    errors.add(:category, 'は変更できません') if category_id != item.category_id
  end
end
