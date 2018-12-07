class InquiryNotifier
  def initialize(inquiry)
    @inquiry = inquiry
  end

  def notify
    notifier =
      Slack::Notifier.new(Rails.application.credentials[:slack_webhook_url])
    notifier.post(
      text: inquiry.prettify,
      icon_emoji: Settings.slack.icon_emoji,
      channel: Settings.slack.channel,
      username: Settings.slack.username
    )
  end

  private
    attr_reader :inquiry
end
