class AddColumnToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :displayable, :boolean, after: :code
  end
end
