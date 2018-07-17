class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @reviews = Review.where(item: @item, approved: true)
    @review = @item.reviews.build
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
        name: @item.maker.name,
        path: "/makers/#{@item.maker.code}"
      },
      {
        name: @item.model,
        path: "/items/#{@item.id}"
      }
    ]
  end
end
