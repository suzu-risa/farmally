class HomeController < ApplicationController
  def index
    @category = Category.all
  end

  def search
    @category = Category.find_by(code: params[:category])
    @maker = Maker.find_by(code: params[:maker])
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
      }
    ]
  end

  def terms; end

  def privacy; end

  def commercial; end

  def company; end
end
