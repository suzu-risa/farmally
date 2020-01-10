class InquiryNotifier
  def initialize(inquiry)
    @inquiry = inquiry
  end

  def notify referer
    # remove notifier to sales channel after we agreed on new channel.
    notifier =
      Slack::Notifier.new(Rails.application.credentials[Rails.env.to_sym][:slack_webhook_url])
    notifier2 = Slack::Notifier.new(Rails.application.credentials[Rails.env.to_sym][:slack_sell_webhook_url])
    notifier.post(
      text: inquiry.prettify,
      icon_emoji: Settings.slack.icon_emoji,
      channel: Settings.slack.channel,
      username: Settings.slack.username
    )
    notifier2.post(
        text: "[#{referer}] \n" + inquiry.prettify,
        icon_emoji: Settings.slack.icon_emoji,
        username: Settings.slack.username
    )
  end

  private
    attr_reader :inquiry
end
