class CategoriesController < ApplicationController
  include SetCatalogSubtitle

  def show
    @category = Category.find_by!(code: params[:code])
    @items = Item.where(category: @category).page(params[:page])
    @statistics = Item.statistics(@category)
    @title = @category.name
  end
end
