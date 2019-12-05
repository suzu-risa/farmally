class BuyController < ApplicationController

  include SetBuySubtitle

  def index
    @item = Item.find(params[:item_id])
    @buy_form = BuyForm.new

    @meta = {
      'title' => '農機購入の申込み・相談',
      'description' => '中古農機具マーケットプレイス ファーマリー by DMMの購入申込み・相談フォームです。ファーマリー by DMMは農業生産に必要なあらゆる機械、農機具の仕入れ、販売、メンテナンスを行っています。'
    }

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