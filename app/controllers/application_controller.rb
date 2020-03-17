class ApplicationController < ActionController::Base
  before_action :set_request_env
  before_action :set_redirect

  def set_request_env
    if !Rails.env.development?
      request.env['HTTP_X_FORWARDED_SSL'] = 'on'
    end
  end

  def set_redirect
    if Settings.domain.farmally == request.host then
      if request.path == '/' then
        redirect_to protocol + Settings.domain.nouki, status: :moved_permanently
      else
        case true
        when
          request.path.include?('inquiry'),
          request.path.include?('items'),
          request.path.include?('buy'),
          request.path.include?('specified-commercial')
        then
          redirect_to protocol + Settings.domain.nouki + request.path, status: :moved_permanently
        end
      end
    elsif Settings.domain.nouki == request.host then
      case true
      when request.path.include?('sell') then
        redirect_to protocol + Settings.domain.farmally + request.path, status: :moved_permanently
      end
    end
  end

  def protocol
    return Rails.env.development? ? 'http://' : 'https://'
  end
end
