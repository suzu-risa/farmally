class Review < ApplicationRecord
  has_one_attached :picture

  belongs_to :item

  validates :content, length: { minimum: 1, maximum: 10_000 }

  enum status: {
    unselected: 0,
    new: 1,
    used: 2
  }, _prefix: true

  enum star: {
    unselected: 0,
    very_bad: 1,
    bad: 2,
    normal: 3,
    good: 4,
    very_good: 5
  }, _prefix: true
end
