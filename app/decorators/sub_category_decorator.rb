module SubCategoryDecorator
  def show_path
    sub_category_category_path(code: category.code, sub_code: code)
  end
end
