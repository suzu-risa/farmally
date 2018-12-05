class ChangeColumnNullAddressAndEmailToSaleItemInquiries < ActiveRecord::Migration[5.2]
  def change
    change_column_null :sale_item_inquiries, :address, true
    change_column_null :sale_item_inquiries, :email, true
  end
end
