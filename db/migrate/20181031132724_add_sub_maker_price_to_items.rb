class AddSubMakerPriceToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :sub_maker_price, :integer
  end
end
