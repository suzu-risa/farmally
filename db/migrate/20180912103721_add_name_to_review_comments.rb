class AddNameToReviewComments < ActiveRecord::Migration[5.2]
  def change
    add_column :review_comments, :name, :string, null: false
  end
end
