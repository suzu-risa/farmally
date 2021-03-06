class SaleItemsController < ApplicationController

  include SetBuySubtitle

  def index
    @sale_items = SaleItem.page(params[:page])
  end

  def show
    @item = find_item(params[:item_id])
    @sale_item = find_sale_item(params[:id])
    @inquiry = @sale_item.inquiries.build
    @title = "#{@sale_item.name} #{@sale_item.model}".strip

    @related_sale_items = @sale_item.related_sale_items
  end

  def images
    sale_item = find_sale_item(params[:sale_item_id])

    render json: {
      sale_item_images: sale_item.images.map{ |image|
        { url: rails_representation_url(image.variant(combine_options: { resize: '500x500', auto_orient: true, strip: true }).processed) }
      }
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
