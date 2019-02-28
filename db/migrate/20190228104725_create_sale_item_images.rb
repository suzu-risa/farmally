class CreateSaleItemImages < ActiveRecord::Migration[5.2]
  def change
    create_table :sale_item_images do |t|
      t.references :sale_item, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
