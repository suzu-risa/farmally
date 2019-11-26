class SaleItemView
  include ActiveModel::Model

  def initialize(params)
    @params = params
    @displayable_category = [2,7,10]
  end

  def get_sale_items
    if @params[:code].present?
      item = Item.find_by!(category_id: @params[:code])
      @sale_items = SaleItem.where(item_id: item.id).page(@params[:page])
    else
      @sale_items = SaleItem.page(@params[:page])
    end
  end

  def get_sale_category
    @categories = Category.find(@displayable_category)
  end
end