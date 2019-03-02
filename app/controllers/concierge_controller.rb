class ConciergeController < ApplicationController
  def create
    @form = Form.new(form_params)
    if @form.valid?
      notifier = InquiryNotifier.new(@form)
      notifier.notify

      redirect_to concierge_index_path, flash: { success: '送信しました。担当者からの連絡をお待ちください' }
      return
    end
    render template: 'concierge', status: :unprocessable_entity
  end

  def index
    @form = Form.new
    render layout: 'concierge'
  end

  def form_params
    params.require(:form).permit(:category, :price, :name, :tel, :address, :email, :inquiry_type)
  end
end
