class ReviewComment < ApplicationRecord
  belongs_to :review

  validates :content, length: { minimum: 1, maximum: 3000 }
end
