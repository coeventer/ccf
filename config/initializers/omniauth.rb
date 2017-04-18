config = APP_CONFIG.fetch("oauth", [])
if !config.empty?
  Rails.application.config.middleware.use OmniAuth::Builder do
    if Rails.env.development?
      OpenSSL::SSL.class_eval { remove_const :VERIFY_PEER }
      OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    end

    provider :github, config["providers"]["github"]["key"], config["providers"]["github"]["secret"]
    provider :google_oauth2, config["providers"]["google_oauth2"]["key"], config["providers"]["google_oauth2"]["secret"], {client_options: {ssl: {ca_path: "/usr/lib/ssl/certs"}}, setup: true}
    provider :facebook, config["providers"]["facebook"]["key"], config["providers"]["facebook"]["secret"], { scope: 'email', info_fields: 'email'}
    provider :meetup, config["providers"]["meetup"]["key"], config["providers"]["meetup"]["secret"]

    if Rails.env.development? || Rails.env.test?
      provider :developer
    end
  end
end
