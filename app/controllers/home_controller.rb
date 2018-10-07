class HomeController < ApplicationController
  def index; end

  def search
    @category = Category.find_by(code: params[:category])
    @maker = Maker.find_by(code: params[:maker])
    @items = if @category.present? && @maker.present?
      Item.where(category: @category, maker: @maker).page(params[:page])
    elsif @category.present?
      Item.where(category: @category).page(params[:page])
    elsif @maker.present?
      Item.where(maker: @maker).page(params[:page])
    else
      Item.all.page(params[:page])
    end
    @title = if @category.present? && @maker.present?
      "#{@category.name} / #{@maker.name}"
    elsif @category.present?
      @category.name
    elsif @maker.present?
      @maker.name
    else
      "全て"
    end
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
