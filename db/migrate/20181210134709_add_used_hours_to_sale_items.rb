class AddUsedHoursToSaleItems < ActiveRecord::Migration[5.2]
  def change
    add_column :sale_items, :used_hours, :integer
  end
end
