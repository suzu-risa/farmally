class ItemsController < ApplicationController
  include SetCatalogSubtitle

  def index
    sale_item_view = SaleItemView.new(params)
    @categories = sale_item_view.get_sale_category
    @sale_items = sale_item_view.get_sale_items
  end

  def show
    @item = Item.find(params[:id])
    @reviews = Review.includes(:review_comments).where(item: @item, approved: true)
    @sale_items = @item.sale_items
    @title = @item.model
  end
end
