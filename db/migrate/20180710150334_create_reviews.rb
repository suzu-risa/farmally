class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :item, foreign_key: true
      t.text :content, null: false
      t.integer :star, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.integer :purchase_price, null: false, default: 0
      t.boolean :approved, null: false, default: false
    end
  end
end
