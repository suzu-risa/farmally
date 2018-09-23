class AddTimestampsToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :created_at, :datetime, null: false, default: -> { 'NOW()' }
    add_column :reviews, :updated_at, :datetime, null: false, default: -> { 'NOW()' }
  end
end
