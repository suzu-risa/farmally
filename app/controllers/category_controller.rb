class CategoryController < ApplicationController
  def index
    @items = Item.all
    @category = Category.where(code: 'tractor').first
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
        max: 6,
    }
  end
end
