class BuyController < ApplicationController

  include SetBuySubtitle

  def index
    @sale_item = SaleItem.find(params[:item_id])
    @item = @sale_item.item
    @buy_form = BuyForm.new
  end

  def create
    @sale_item = SaleItem.find(params[:item_id])
    @item = @sale_item.item
    @buy_form = BuyForm.new(form_params)

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
end