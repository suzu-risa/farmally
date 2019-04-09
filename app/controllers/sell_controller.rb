class SellController < ApplicationController
  def index
    @sell_form = SellForm.new
    @prefecture = params[:prefecture]
    @category = params[:category]

    render layout: 'sell'
  end

  def create
    @form = SellForm.new(form_params)
    if @form.valid?
      notifier = InquiryNotifier.new(@form)
      notifier.notify

      redirect_to sell_index_path, flash: { success: '送信しました。担当者からの連絡をお待ちください' }
      return
    end

    render template: 'sell', status: :unprocessable_entity
  end

  private
    def form_params
      params.require(:sell_form).permit(:category, :maker, :name, :tel, :prefecture, :message)
    end
end
