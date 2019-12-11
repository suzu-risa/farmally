class BuyController < ApplicationController

  include SetBuySubtitle

  def index
    @sale_item = SaleItem.find(params[:item_id])
    @item = @sale_item.item
    @buy_form = BuyForm.new
    set_meta()
  end

  def create
    @sale_item = SaleItem.find(params[:item_id])
    @item = @sale_item.item
    @buy_form = BuyForm.new(form_params)
    set_meta()

    referer = request.referer

    if @buy_form.valid?
      if @buy_form.agree_to_terms == '1'
        @buy_form.agree_to_terms = 'はい'
      else
        @buy_form.agree_to_terms = 'いいえ'
      end
      notifier = InquiryNotifier.new(@buy_form)
      notifier.notify referer
      flash[:success] = '送信しました。担当者からの連絡をお待ちください';
      redirect_to buy_path(@item)
      return
    end

    render 'index', status: :unprocessable_entity
  end

  private
    def form_params
      params.require(:buy_form).permit(:item_id, :name, :tel, :postal_code, :address, :email, :message, :agree_to_terms)
    end

    def set_meta
      @meta = {
        'title' => '中古農機具購入の申込み・相談 ファーマリー by DMM',
        'description' => '中古農機具マーケットプレイス ファーマリー by DMMの購入申込み・相談フォームです。ファーマリー by DMMは農業生産に必要なあらゆる機械、農機具の仕入れ、販売、メンテナンスを行っています。'
      }
    end
end