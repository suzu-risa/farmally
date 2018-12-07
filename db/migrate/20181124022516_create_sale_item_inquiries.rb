class CreateSaleItemInquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :sale_item_inquiries do |t|
      t.references :sale_item, foreign_key: true
      t.string :name, null: false
      t.string :phone_number, null: false
      t.string :address, null: false
      t.string :email

      t.timestamps
    end
  end
end
