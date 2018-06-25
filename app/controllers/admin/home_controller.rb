module Admin
  class HomeController < Admin::ApplicationController
    def index; end

    def import
      # flash.now[:error] = ['Some errors occured', 'hogehoge'].join('<br />')
      # render :index
      redirect_to admin_root_url, notice: '商品を追加しました'
    end
  end
end
