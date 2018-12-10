class AddYearToSaleItems < ActiveRecord::Migration[5.2]
  def change
    add_column :sale_items, :year, :smallint
  end
end
