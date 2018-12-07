class AddDescriptionContentToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :description_content, :text
  end
end
