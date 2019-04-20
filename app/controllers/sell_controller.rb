class SellController < ApplicationController
  def index
    @sell_form = SellForm.new
    @prefecture = params[:prefecture]
    @category = params[:category]

    @ptn = params[:ptn]

    if @ptn.present? and @ptn == '2'
      render 'index_price_guarantee'
      return
    end

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

  def call_click_log
    ip_address = request.env['REMOTE_ADDR']
    ua = request.env["HTTP_USER_AGENT"]

    notifier = CallClickNotifier.new
    notifier.notify "[#{ua}] \n [#{ip_address}] \n"

    head :no_content
  end

  private
    def form_params
      params.require(:sell_form).permit(:category, :maker, :name, :tel, :prefecture, :message)
    end
end
