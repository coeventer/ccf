source 'https://rubygems.org'

gem 'rails', '3.2.14'
gem 'mysql2'

group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  
  gem "therubyracer"
  gem "less-rails"
  gem "twitter-bootstrap-rails"
end



gem 'jquery-rails'
gem 'cancan'

gem 'figaro'
gem 'rolify'

gem 'formtastic'
gem 'formtastic-bootstrap'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx]
  gem 'quiet_assets'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end
group :test do
  gem 'capybara'
  gem 'cucumber-rails', :require=>false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
end

# Temporarily using FB for auth, will use Shibboleth on UMN infra
gem 'omniauth-facebook'
gem 'omniauth-shibboleth'

gem 'will_paginate'