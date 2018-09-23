class MakersController < ApplicationController
  def show
    @maker = Maker.find_by(code: params[:code])
    @items = Item.where(maker: @maker)
    @title = @maker.name
    @breadcrumb = breadcrumb(maker: @maker)
    @page = {
      min: 1,
      current: 2,
      max: 6
    }
  end
end
