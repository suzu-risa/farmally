class SoldItemsController < ApplicationController
  def index
    @sold_items = SaleItem.sold.page(params[:page])
  end
end
