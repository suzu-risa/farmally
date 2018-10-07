class CategoriesController < ApplicationController
  def show
    @category = Category.find_by!(code: params[:code])
    @items = Item.where(category: @category).page(params[:page])
    @title = @category.name
    @breadcrumb = breadcrumb(category: @category)
  end
end
