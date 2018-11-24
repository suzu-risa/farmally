class SaleItemsController < ApplicationController
  def show
    @item = Item.find(params[:item_id])
    @sale_item = SaleItem.find(params[:id])
    @title = @item.model
    @breadcrumb = breadcrumb(item: @item)
  end
end
