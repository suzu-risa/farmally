# == Schema Information
#
# Table name: review_comments
#
#  id         :bigint(8)        not null, primary key
#  approved   :boolean          default(FALSE), not null
#  content    :text(65535)
#  like_count :integer          default(0), not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  review_id  :bigint(8)
#
# Indexes
#
#  index_review_comments_on_review_id  (review_id)
#
# Foreign Keys
#
#  fk_rails_...  (review_id => reviews.id)
#

class ReviewComment < ApplicationRecord
  belongs_to :review

  validates :name, length: { minimum: 1, maximum: 100 }
  validates :content, length: { minimum: 1, maximum: 3000 }
end
