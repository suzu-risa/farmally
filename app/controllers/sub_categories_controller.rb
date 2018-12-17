class SubCategoriesController < ApplicationController
  def index
    sub_categories =
      SubCategory.joins(:category).where(categories: { code: params[:category_code] })

    render json: { sub_categories: sub_categories.select(:id, :code, :name).map(&:attributes) }
  end

  def show
    @category = Category.find_by!(code: params[:code])
    @sub_category = SubCategory.find_by!(category: @category, code: params[:sub_code])
    @items = Item.where(category: @category, sub_category: @sub_category).page(params[:page])
    @title = "#{@category.name} / #{@sub_category.name}"
  end
end
