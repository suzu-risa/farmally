class MakersController < ApplicationController
  def show
    @items = Item.all
    @maker = Maker.find_by(code: params[:code])
    @title = @maker.name
    @breadcrumb = breadcrumb(maker: @maker)
    @page = {
      min: 1,
      current: 2,
      max: 6
    }
  end
end
