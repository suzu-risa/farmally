class SellController < ApplicationController

  include SetSellSubtitle


  def index
    redirect_to protocol + Settings.domain.kaitori, status: :moved_permanently
  end

  def makers
    redirect_to protocol + Settings.domain.kaitori, status: :moved_permanently
  end

  def show_maker
    redirect_to protocol + Settings.domain.kaitori, status: :moved_permanently
  end


  def categories
    redirect_to protocol + Settings.domain.kaitori, status: :moved_permanently
  end

  def show_category
    redirect_to protocol + Settings.domain.kaitori, status: :moved_permanently
  end

  def protocol
    return super
  end

  private
    def form_params
      params.require(:sell_form).permit(:category, :maker, :name, :tel, :prefecture, :message, :lp_pattern)
    end
end
