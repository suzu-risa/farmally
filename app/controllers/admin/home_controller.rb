module Admin
  class HomeController < Admin::ApplicationController
    def index; end

    def import
      result = Item.import(params[:file])
      if result[:success]
        redirect_to admin_items_url, notice: '商品を追加しました'
        return
      end
      flash.now[:error] = result[:messages].join('<br />')
      render :index
    end
  end
end
