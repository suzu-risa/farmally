class ApplicationController < ActionController::Base
    before_action :set_request_env

    def set_request_env
      if !Rails.env.development?
        request.env['HTTP_X_FORWARDED_SSL'] = 'on'
      end
    end
end
