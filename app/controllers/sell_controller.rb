class SellController < ApplicationController
  def index
    @sell_form = SellForm.new
    @prefecture = params[:prefecture]
    @category = params[:category]

    @ptn = params[:ptn]

    if @ptn.present? and @ptn == '2'
      @sell_form.lp_pattern = '2'
      render 'index_price_guarantee'
      return
    end

    render layout: 'sell'
  end

  def show_maker
    @maker_slug = params[:maker_slug]

    result =  CosmicjsClient.fetch_maker(@maker_slug)

    @maker_info =  result.data.object
    @maker_meta = result.data.object.metadata

    @sell_form = SellForm.new

    render layout: 'sell'
  end

  def show_category
    @category_slug = params[:cateogry_slug]

    result =  CosmicjsClient.fetch_maker(@category_slug)

    @category_info =  result.data.object
    @category_meta = result.data.object.metadata

    @sell_form = SellForm.new

    render layout: 'sell'
  end

  def create
    @form = SellForm.new(form_params)
    referer = request.referer
    if @form.valid?
      notifier = InquiryNotifier.new(@form)
      notifier.notify referer

      if @form.lp_pattern == '2'
        redirect_to sell_index_path(ptn: 2), flash: { success: '送信しました。担当者からの連絡をお待ちください' }
      else
        redirect_to sell_index_path, flash: { success: '送信しました。担当者からの連絡をお待ちください' }
      end
      return
    end

    render template: 'sell', status: :unprocessable_entity
  end

  def call_click_log
    ip_address = request.env['REMOTE_ADDR']
    ua = request.env["HTTP_USER_AGENT"]
    referer = request.referer

    notifier = CallClickNotifier.new
    notifier.notify "[#{ua}] \n [#{ip_address}] \n [#{referer}] \n"

    head :no_content
  end

  private
    def form_params
      params.require(:sell_form).permit(:category, :maker, :name, :tel, :prefecture, :message, :lp_pattern)
    end
end
