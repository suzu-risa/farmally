class SellController < ApplicationController

  include SetSellSubtitle


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

  def makers
    @sell_form = SellForm.new
    render layout: 'sell'
  end

  def show_maker
    @maker_slug = params[:maker_slug]

    result =  CosmicjsClient.fetch_maker(@maker_slug)

    @maker_info = result["object"]
    @maker_meta = result["object"]["metadata"]

    @maker_breadcrumbs = {title: @maker_info["title"], slug: @maker_slug}

    @sell_form = SellForm.new

    render layout: 'sell'
  end


  def categories

    @sell_form = SellForm.new

    render layout: 'sell'
  end

  def show_category
    @category_slug = params[:category_slug]

    result =  CosmicjsClient.fetch_category(@category_slug)

    @category_info = result["object"]
    @category_meta = result["object"]["metadata"]

    @category_breadcrumb = {title: @category_info["title"], slug: @category_meta}

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
