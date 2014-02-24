if Rails.env.development? then
  Rails.application.config.middleware.use OmniAuth::Builder do
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    provider :google_oauth2, '767649200826.apps.googleusercontent.com', '3lsEI96bMAbLe1aHj1xbG10J', {:client_options => {:ssl => {:ca_path => "/usr/lib/ssl/certs"}}, :setup => true}
  end  
else
  
end