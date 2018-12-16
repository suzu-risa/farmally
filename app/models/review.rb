# == Schema Information
#
# Table name: reviews
#
#  id         :bigint(8)        not null, primary key
#  approved   :boolean          default(FALSE), not null
#  content    :text(65535)      not null
#  like_count :integer          default(0), not null
#  name       :string(255)      not null
#  star       :integer          default("unselected"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :bigint(8)
#
# Indexes
#
#  index_reviews_on_item_id  (item_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#

class Review < ApplicationRecord
  has_one_attached :picture

  has_many :review_comments, dependent: :destroy

  belongs_to :item

  validates :name, length: { minimum: 1, maximum: 100 }
  validates :content, length: { minimum: 1, maximum: 10_000 }

  enum star: {
    unselected: 0,
    very_bad: 1,
    bad: 2,
    normal: 3,
    good: 4,
    very_good: 5
  }, _prefix: true

  def star_count
    self.class.stars[self.star]
  end
end
