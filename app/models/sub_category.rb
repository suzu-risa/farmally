# == Schema Information
#
# Table name: sub_categories
#
#  id          :bigint(8)        not null, primary key
#  code        :string(255)      not null
#  name        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint(8)
#
# Indexes
#
#  index_sub_categories_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#

class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :items

  validates :name, presence: true, uniqueness: { scope: :category }
  validates :code, presence: true, uniqueness: { scope: :category }

  validate :category_should_be_parent

  private

  def category_should_be_parent
    item = Item.find_by(sub_category: self)
    return if item.nil?
    errors.add(:category, 'は変更できません') if category_id != item.category_id
  end
end
