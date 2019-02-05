class AddStaffCommentToSaleItems < ActiveRecord::Migration[5.2]
  def change
    add_column :sale_items, :staff_comment, :text
  end
end
