class AddStaffReferencesToSaleItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :sale_items, :staff, foreign_key: false
  end
end
