class InquiryController < ApplicationController

  def index
    @inquiry_form = InquiryForm.new
    set_meta()
  end

  def create
    set_meta()
    @inquiry_form = InquiryForm.new(inquiry_params)
    referer = request.referer
    if @inquiry_form.valid?

      if @inquiry_form.request_notification == '1'
        @inquiry_form.request_notification = 'する'
      else
        @inquiry_form.request_notification = 'しない'
      end

      if @inquiry_form.agree_to_terms == '1'
        @inquiry_form.agree_to_terms = 'はい'
      else
        @inquiry_form.agree_to_terms = 'いいえ'
      end

      notifier = InquiryNotifier.new(@inquiry_form)
      notifier.notify referer
      redirect_to inquiry_index_path, flash: { success: '送信しました。担当者からの連絡をお待ちください' }
      return
    end

    render 'index', status: :unprocessable_entity
  end

  private

    def inquiry_params
      params.require(:inquiry_form)
        .permit(:name, :tel, :email, :message, :request_notification, :agree_to_terms)
    end


  def set_meta
    @meta = {
      'title' => '相談・お問い合わせ（価格変更連絡・入荷連絡の申込み）',
      'description' => 'DMM 農機の相談・お問い合わせフォームです。在庫の見つけにくい中古農機具をはじめとして、農業生産に必要となるあらゆる機械、農機具を掲載している、中古農機具販売サービスです。お客様のご要望に応じてDMM 農機が仕入れ、販売、納品、メンテナンスまで一貫して対応いたします。'
    }
  end
end