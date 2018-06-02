class ItemController < ApplicationController

  def index
    @item = Item.find(params[:id])
    @title = @item.model
    @breadcrumb = [
        {
            name: 'トップ',
            path: '/'
        },
        {
            name: @item.category.name,
            path: "/categories/#{@item.category.code}"
        },
        {
            name: @item.model,
            path: "/items/#{@item.id}"
        },
    ]
  end
end
