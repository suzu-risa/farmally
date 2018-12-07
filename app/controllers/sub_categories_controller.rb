class SubCategoriesController < ApplicationController
  def show
    @category = Category.find_by!(code: params[:code])
    @sub_category = SubCategory.find_by!(category: @category, code: params[:sub_code])
    @items = Item.where(category: @category, sub_category: @sub_category).page(params[:page])
    @title = "#{@category.name} / #{@sub_category.name}"
  end
end
