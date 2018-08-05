class RemoveColumnsFromReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :status, :integer, null: false, default: 0
    remove_column :reviews, :purchase_price, :integer
  end
end
