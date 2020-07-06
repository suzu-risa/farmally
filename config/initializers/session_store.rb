Rails.application.config.session_store :cookie_store, secure: !Rails.env.development?
