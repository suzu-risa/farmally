class AddContentsToSaleItemInquiries < ActiveRecord::Migration[5.2]
  def change
    add_column :sale_item_inquiries, :contents, :text
  end
end
