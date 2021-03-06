class ItemsController < ApplicationController
  include SetCatalogSubtitle

  def index
    # @categories = Category.all
    @categories = Category.displayed
    @sale_items = SaleItem.get_sale_items(params)
    @sale_item_count = SaleItem.get_sale_item_count(params)

    if params[:code] then
      @category_name = Category.where(code: params[:code]).first.name;
    end

    title = '%s販売'
    description = '%sの中古販売ならDMM 農機。在庫の見つけにくい中古農機具をはじめとして、農業生産に必要となるあらゆる機械、農機具を掲載している、中古農機具販売サービスです。お客様のご要望に応じてDMM 農機が仕入れ、販売、納品、メンテナンスまで一貫して対応いたします。'

    @meta = {
      'title' => sprintf(title, @category_name),
      'description' => sprintf(description, @category_name)
    }
  end

  def images
    sale_item = SaleItem.find(params[:sale_item_id])

    render json: {
      sale_item_images: sale_item.images.map { |image|
        {
          url: rails_representation_url(image.variant(combine_options: { resize: '500x500', auto_orient: true, strip: true }).processed),
          alt: sale_item.maker.name + ' ' + sale_item.item.model
        }
      }
    }
  end
end
