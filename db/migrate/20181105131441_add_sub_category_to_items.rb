class AddSubCategoryToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :sub_category, foreign_key: true, after: :category_id
  end
end
