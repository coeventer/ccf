config = APP_CONFIG.fetch("oauth", [])
if !config.empty?
  Rails.application.config.middleware.use OmniAuth::Builder do
    if Rails.env.development?    then
      OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    end

    provider :google_oauth2, config["providers"]["google_oauth2"]["key"], config["providers"]["google_oauth2"]["secret"], {client_options: {ssl: {ca_path: "/usr/lib/ssl/certs"}}, setup: true}
    provider :facebook, config["providers"]["facebook"]["key"], config["providers"]["facebook"]["secret"], { scope: 'email', info_fields: 'email'}
  end
end
