class SaleItemInquiriesController < ApplicationController
  def new
    @sale_item = find_sale_item(params[:sale_item_id])
    @inquiry = @sale_item.inquiries.build
  end

  def create
    sale_item = find_sale_item(params[:sale_item_id])

    if sale_item.inquiries.create(sale_item_inquiry_params)
    else
    end
  end

  private

    def sale_item_inquiry_params
      params.require(:sale_item_inquiry)
        .permit(:name, :phone_number, :address, :email)
    end

    def find_item(item_id)
      Item.find(item_id)
    end

    def find_sale_item(sale_item_id)
      SaleItem.find(sale_item_id)
    end
end
