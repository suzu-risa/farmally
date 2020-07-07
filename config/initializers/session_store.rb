Rails.application.config.session_store :cookie_store, key: '_farmally_session', secure: !Rails.env.development?
