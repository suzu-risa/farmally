class MakerController < ApplicationController

  def index
    @items = Item.all
    @maker = Maker.where(code: params['maker_code']).first
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
        max: 6,
    }
  end
end
