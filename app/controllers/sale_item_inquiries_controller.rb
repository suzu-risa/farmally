class SaleItemInquiriesController < ApplicationController
  def create
    sale_item = find_sale_item(params[:sale_item_id])

    if sale_item_inquiry = sale_item.inquiries.create(sale_item_inquiry_params)
      notifier = InquiryNotifier.new(sale_item_inquiry)
      notifier.notify

      flash[:success] = '送信しました。担当者からの連絡をお待ちください'
    else
      flash[:alert] = '送信に失敗しました。再度お試しください。'
    end

    redirect_to request.referer
  end

  private

    def sale_item_inquiry_params
      params.require(:sale_item_inquiry)
        .permit(:name, :phone_number, :contents)
    end

    def find_item(item_id)
      Item.find(item_id)
    end

    def find_sale_item(sale_item_id)
      SaleItem.find(sale_item_id)
    end
end
