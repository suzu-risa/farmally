class RemoveNotNullPhoneNumberSaleItemInquiries < ActiveRecord::Migration[5.2]
  def change
    change_column_null :sale_item_inquiries, :phone_number, true
  end
end
