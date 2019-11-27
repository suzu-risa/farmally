class ItemsController < ApplicationController
  include SetCatalogSubtitle

  def index
    @categories = Category.get_displayable_categories
    @sale_items = SaleItem.get_sale_items(params)
  end

  def images
    sale_item = SaleItem.find(params[:sale_item_id])

    render json: {
      sale_item_images: sale_item.images.map{ |image|
        { url: rails_representation_url(image.variant(resize: '500x500').processed) }
      }
    }
  end
end
