class ReviewComment < ApplicationRecord
  belongs_to :review

  validates :name, length: { minimum: 1, maximum: 100 }
  validates :content, length: { minimum: 1, maximum: 3000 }
end
