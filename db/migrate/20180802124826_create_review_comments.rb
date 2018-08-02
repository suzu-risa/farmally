class CreateReviewComments < ActiveRecord::Migration[5.2]
  def change
    create_table :review_comments do |t|
      t.references :review, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
