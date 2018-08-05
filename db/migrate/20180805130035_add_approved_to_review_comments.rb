class AddApprovedToReviewComments < ActiveRecord::Migration[5.2]
  def change
    add_column :review_comments, :approved, :boolean, default: false, null: false
  end
end
