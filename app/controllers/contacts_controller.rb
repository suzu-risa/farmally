class ContactsController < ApplicationController
  def create
    if contact = Contact.create(contact_params)
      notifier = InquiryNotifier.new(contact)
      notifier.notify

      flash[:success] = '送信しました。担当者からの連絡をお待ちください'
    else
      flash[:alert] = '送信に失敗しました。再度お試しください。'
    end

    redirect_to request.referer
  end

  private

    def contact_params
      params.require(:contact)
        .permit(:name, :phone_number, :category, :contents)
    end
end
