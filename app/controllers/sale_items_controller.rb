class SaleItemsController < ApplicationController
  def show
    @item = find_item(params[:item_id])
    @sale_item = find_sale_item(params[:id])
    @inquiry = @sale_item.inquiries.build
    @title = @item.model
  end

  def images
    sale_item = find_sale_item(params[:sale_item_id])

    render json: {
      sale_item_images: sale_item.images.map{ |image| { url: Rails.application.routes.url_helpers.url_for(image) } }
    }
  end

  private

    def find_item(item_id)
      Item.find(item_id)
    end

    def find_sale_item(sale_item_id)
      SaleItem.find(sale_item_id)
    end
end
