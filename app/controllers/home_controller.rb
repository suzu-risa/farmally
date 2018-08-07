class HomeController < ApplicationController
  def index
    @category = Category.all
  end

  def search
    @category = Category.find_by(code: params[:category])
    @maker = Maker.find_by(code: params[:maker])
    @items = Item.where(category_id: @category.id, maker_id: @maker.id)
    @title = "#{@category.name} / #{@maker.name}"
    @breadcrumb = breadcrumb(category: @category, maker: @maker)
  end

  def terms
    render layout: 'without_form'
  end

  def privacy
    render layout: 'without_form'
  end

  def commercial
    render layout: 'without_form'
  end

  def company
    render layout: 'without_form'
  end

  def form
    @form = Form.new
    render layout: 'without_form'
  end
end
