class HomeController < ApplicationController
  def index; end

  def search
    @category = Category.find_by(code: params[:category])
    @maker = Maker.find_by(code: params[:maker])
    @items = Item.where(category: @category, maker: @maker)
    @title = "#{@category.name} / #{@maker.name}"
    @breadcrumb = breadcrumb(category: @category, maker: @maker)
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
end
