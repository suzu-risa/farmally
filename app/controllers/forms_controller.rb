class FormsController < ApplicationController
  def create
    @form = Form.new(form_params)
    if @form.valid?
      notifier = Slack::Notifier.new(Rails.application.credentials[:slack_webhook_url])
      notifier.post(
        text: @form.prettify,
        icon_emoji: Settings.slack.icon_emoji,
        channel: Settings.slack.channel,
        username: Settings.slack.username
      )
      redirect_to form_path, flash: { success: '送信しました。担当者からの連絡をお待ちください' }
      return
    end
    render template: 'home/form', status: :unprocessable_entity
  end

  private

  def form_params
    params.require(:form).permit(:category, :price, :name, :tel, :address, :email)
  end
end
