class AddLikeCountToReviewComments < ActiveRecord::Migration[5.2]
  def change
    add_column :review_comments, :like_count, :integer, default: 0, null: false
  end
end
