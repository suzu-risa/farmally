class MakersController < ApplicationController
  def show
    @maker = Maker.find_by!(code: params[:code])
    @items = Item.where(maker: @maker).page(params[:page])
    @title = @maker.name
  end
end
