class AddStatusToSaleItems < ActiveRecord::Migration[5.2]
  def change
    add_column :sale_items, :status, :integer
  end
end
