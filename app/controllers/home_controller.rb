class HomeController < ApplicationController
  def index
    @categories = Category.all
    @makers = Maker.all
    @sale_items = SaleItem.for_sale.order(created_at: :desc).limit(2)

    @sell_cases =  CosmicjsClient.fetch_latest_sell_cases

    @search_item_form = SearchItemForm.new
  end

  def search
    if search_item_form_params

      @category = Category.find_by(code: search_item_form_params[:category])

      @sub_category = SubCategory.find_by(category: @category, code: search_item_form_params[:sub_category])

      @maker = Maker.find_by(code: search_item_form_params[:maker])

      arguments = { category: @category, sub_category: @sub_category, maker: @maker }

      @items = Item.where(search_condition(arguments)).includes(:maker).page(params[:page])

      @title = search_title(arguments)
    else
      @items = Item.all.page(params[:page])

      @title = search_title
    end
  end

  def terms; end

  def guide
    @meta = {
      'title' => 'ご利用ガイド',
      'description' => 'ファーマリーのご利用ガイドです。在庫の見つけにくい中古農機具をはじめとして、農業生産に必要となるあらゆる機械、農機具を掲載している、中古農機具販売サービスです。お客様のご要望に応じてファーマリーが仕入れ、販売、納品、メンテナンスまで一貫して対応いたします。'
    }
  end

  def commercial
    @meta = {
      'title' => '特定商取引法及び古物営業法に基づく表記',
      'description' => 'ファーマリーの特定商取引法及び古物営業法に基づく表記について。在庫の見つけにくい中古農機具をはじめとして、農業生産に必要となるあらゆる機械、農機具を掲載している、中古農機具販売サービスです。お客様のご要望に応じてファーマリーが仕入れ、販売、納品、メンテナンスまで一貫して対応いたします。'
    }
  end

  def form
    @form = Form.new
    render layout: 'form'
  end

  private

  def search_item_form_params
    params[:search_item_form]
  end

  def search_condition(category: nil, sub_category: nil, maker: nil)
    conditions = []
    conditions.push("category_id = #{category.id}") if category.present?
    conditions.push("sub_category_id = #{sub_category.id}") if sub_category.present?
    conditions.push("maker_id = #{maker.id}") if maker.present?
    conditions.join(' and ')
  end

  def search_title(category: nil, sub_category: nil, maker: nil)
    items = []
    items.push(category.name) if category.present?
    items.push(sub_category.name) if sub_category.present?
    items.push(maker.name) if maker.present?
    items.size.zero? ? '全て' : items.join(' / ')
  end
end
