class AddPrefectureCodeToSaleItems < ActiveRecord::Migration[5.2]
  def change
    add_column :sale_items, :prefecture_code, :integer
  end
end
