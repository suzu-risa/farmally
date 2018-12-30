class SubCategoriesController < ApplicationController
  def index
    sub_categories =
      if params[:category_id]
        SubCategory.where(category_id: params[:category_id])
      else
        SubCategory.joins(:category).where(categories: { code: params[:category_code] })
      end

    render json: { sub_categories: sub_categories.select(:id, :code, :name).map(&:attributes) }
  end

  def show
    @category = Category.find_by!(code: params[:code])
    @sub_category = SubCategory.find_by!(category: @category, code: params[:sub_code])
    @items = Item.where(category: @category, sub_category: @sub_category).page(params[:page])
    @title = "#{@category.name} / #{@sub_category.name}"
  end
end
