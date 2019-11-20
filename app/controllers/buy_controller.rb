class BuyController < ApplicationController

  include SetBuySubtitle


  def index
    @item = Item.find(params[:item_id])
    @buy_form = BuyForm.new

    # invalidate cache when the query param passed.
    if params[:invalidate_cache]
      Rails.cache.clear
    end

    render layout: 'buy'
  end

  def makers
    @buy_form = BuyForm.new
    render layout: 'buy'
  end

  def show_maker
    @maker_slug = params[:maker_slug]

    result =  CosmicjsClient.fetch_maker(@maker_slug)

    @maker_info = result["object"]
    @maker_meta = result["object"]["metadata"]

    @maker_breadcrumbs = {title: @maker_info["title"], slug: @maker_slug}

    @buy_cases =  CosmicjsClient.fetch_latest_buy_cases_by_maker_slug @maker_slug

    @buy_form = BuyForm.new

    render layout: 'buy'
  end


  def categories

    @buy_form = BuyForm.new

    render layout: 'buy'
  end

  def show_category
    @category_slug = params[:category_slug]

    result =  CosmicjsClient.fetch_category(@category_slug)

    @category_info = result["object"]
    @category_meta = result["object"]["metadata"]

    @category_breadcrumb = {title: @category_info["title"], slug: @category_meta}

    @buy_cases =  CosmicjsClient.fetch_latest_buy_cases_by_category_slug  @category_slug

    @buy_form = BuyForm.new

    render layout: 'buy'
  end

  def create
    @item = Item.find(params[:item_id])
    @form = BuyForm.new(form_params)
    referer = request.referer
    if @form.valid?
      if @form.recieve_contact == '1'
        @form.recieve_contact = 'はい'
      else
        @form.recieve_contact = 'いいえ'
      end
      notifier = InquiryNotifier.new(@form)
      notifier.notify referer
      redirect_to buy_path(@item), flash: { success: '送信しました。担当者からの連絡をお待ちください' }
      return
    end

    render template: 'buy', status: :unprocessable_entity
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
      params.require(:buy_form).permit(:item_id, :name, :tel, :postal_code, :address, :email, :message, :recieve_contact)
    end
end