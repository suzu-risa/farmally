class InquiryController < ApplicationController

  def index
    @inquiry_form = InquiryForm.new

    @meta = {
      'title' => '相談・お問い合わせ（価格変更連絡・入荷連絡の申込み）',
      'description' => '中古農機具マーケットプレイス ファーマリー by DMMの相談・お問い合わせフォームです。価格変更連絡・入荷連絡の申込みも出来ます。ファーマリー by DMMは農業生産に必要なあらゆる機械、農機具の仕入れ、販売、メンテナンスを行っています。'
    }
  end

  def create
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
end