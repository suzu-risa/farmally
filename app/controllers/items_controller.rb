class ItemsController < ApplicationController
  include SetCatalogSubtitle

  def index
    @categories = Category.get_displayable_categories
    @sale_items = SaleItem.get_sale_items(params)
  end

  def show
    @item = Item.find(params[:id])
    @reviews = Review.includes(:review_comments).where(item: @item, approved: true)
    @sale_items = @item.sale_items
    @title = @item.model
  end
end
