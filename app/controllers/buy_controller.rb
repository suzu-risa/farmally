class BuyController < ApplicationController

  include SetBuySubtitle

  def index
    @item = Item.find(params[:item_id])
    @buy_form = BuyForm.new

    render layout: 'buy'
  end

  def create
    @item = Item.find(params[:item_id])
    @form = BuyForm.new(form_params)
    referer = request.referer
    if @form.valid?
      if @form.agree_to_terms == '1'
        @form.agree_to_terms = 'はい'
      else
        @form.agree_to_terms = 'いいえ'
      end
      notifier = InquiryNotifier.new(@form)
      notifier.notify referer
      redirect_to buy_path(@item), flash: { success: '送信しました。担当者からの連絡をお待ちください' }
      return
    end

    render template: 'buy', status: :unprocessable_entity
  end

  private
    def form_params
      params.require(:buy_form).permit(:item_id, :name, :tel, :postal_code, :address, :email, :message, :agree_to_terms)
    end
end