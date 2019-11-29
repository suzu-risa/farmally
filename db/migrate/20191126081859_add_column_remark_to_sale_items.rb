class AddColumnRemarkToSaleItems < ActiveRecord::Migration[5.2]
  def change
    add_column :sale_items, :remark, :text
  end
end
