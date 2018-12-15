class HomeController < ApplicationController
  def index
    @items = Item.order(created_at: :desc, id: :desc).limit(15)
    @categories = Category.all
    @makers = Maker.all

    @search_item_form = SearchItemForm.new
  end

  def search
    @category = Category.find_by(code: params[:category])
    @sub_category = SubCategory.find_by(category: @category, code: params[:sub_category])
    @maker = Maker.find_by(code: params[:maker])
    arguments = { category: @category, sub_category: @sub_category, maker: @maker }
    @items = Item.where(search_condition(arguments)).includes(:maker).page(params[:page])
    @title = search_title(arguments)
  end

  def terms; end

  def privacy; end

  def commercial; end

  def company; end

  def form
    @form = Form.new
    render layout: 'form'
  end

  def sell_form
    @form = Form.new
    render layout: 'form'
  end

  private

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
