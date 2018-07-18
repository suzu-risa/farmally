class CategoriesController < ApplicationController
  def show
    @category = Category.find_by(code: params[:code])
    @items = Item.where(category: @category)
    @title = @category.name
    @breadcrumb = [
      {
        name: 'トップ',
        path: '/'
      },
      {
        name: @category.name,
        path: "/categories/#{@category.code}"
      }
    ]
    @page = {
      min: 1,
      current: 2,
      max: 6
    }
  end
end
