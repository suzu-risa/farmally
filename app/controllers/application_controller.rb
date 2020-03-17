class ApplicationController < ActionController::Base
  before_action :set_request_env
  before_action :set_redirect

  def set_request_env
    if !Rails.env.development?
      request.env['HTTP_X_FORWARDED_SSL'] = 'on'
    end
  end

  def set_redirect
    case true
    when
        # ドメインが farmally でパスが sell/ で始まっていない場合
        request.host == Settings.domain.farmally && ! request.path.start_with?('/sell')
    then
        # farmally にリダイレクトする
        redirect_to protocol + Settings.domain.nouki + request.path, status: :moved_permanently
    when
        # ドメインが nouki.dmm.com でパスが sell/ で始まっている場合
        request.host == Settings.domain.nouki && request.path.start_with?('/sell')
    then
        # DMM 農機 にリダイレクトする
        redirect_to protocol + Settings.domain.farmally + request.path, status: :moved_permanently
    end
  end

  def protocol
    return Rails.env.development? ? 'http://' : 'https://'
  end
end
