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
