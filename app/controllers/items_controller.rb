class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @reviews = Review.includes(:review_comments).where(item: @item, approved: true)
    @sale_items = @item.sale_items
    @title = @item.model
    @breadcrumb = breadcrumb(item: @item)
  end
end
