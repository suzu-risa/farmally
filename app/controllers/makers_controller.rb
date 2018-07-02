class MakersController < ApplicationController
  def show
    @items = Item.all
    @maker = Maker.find_by(code: params[:maker_code])
    @title = @maker.name
    @breadcrumb = [
      {
        name: 'トップ',
        path: '/'
      },
      {
        name: @maker.name,
        path: "/makers/#{@maker.code}"
      }
    ]
    @page = {
      min: 1,
      current: 2,
      max: 6
    }
  end
end
