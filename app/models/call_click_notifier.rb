class CallClickNotifier
  def notify session_id
    notifier = Slack::Notifier.new(Rails.application.credentials[Rails.env.to_sym][:slack_sell_webhook_url])
    notifier.post(
      text: session_id + '買取LPの電話ボタンがクリックされました。',
      icon_emoji: Settings.slack.icon_emoji,
      username: Settings.slack.username
    )
  end
end
