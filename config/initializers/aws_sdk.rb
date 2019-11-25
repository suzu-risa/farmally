access_key_id = Rails.application.credentials[:aws][:access_key_id]
secret_access_key = Rails.application.credentials[:aws][:secret_access_key]
creds = Aws::Credentials.new(access_key_id, secret_access_key)
Aws::Rails.add_action_mailer_delivery_method(:aws_sdk, credentials: creds, region: 'us-east-1')
