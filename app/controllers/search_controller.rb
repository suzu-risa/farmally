class SearchController < ApplicationController

  def index
    @category = Category.where(code: params[:category]).first
    @maker = Maker.where(code: params[:maker]).first
    @items = Item.where(category_id: @category.id, maker_id: @maker.id).all
    @breadcrumb = [
        {
            name: 'トップ',
            path: '/'
        },
        {
            name: @category.name,
            path: "/categories/#{@category.code}"
        },
        {
            name: @maker.name,
            path: "/makers/#{@maker.code}"
        },
    ]
  end
end
