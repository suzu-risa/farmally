class HomeController < ApplicationController
  def index
    @categories = Category.all
    @makers = Maker.all
    @sale_items = SaleItem.for_sale.order(created_at: :desc).limit(2)

    @sell_cases =  CosmicjsClient.fetch_latest_sell_cases
    @sell_cases = @sell_cases.original_hash["data"]["getObjects"]

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

  def commercial; end

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
