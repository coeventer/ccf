source 'https://rubygems.org'

gem 'rails', '3.2.14'

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
gem 'bootstrap-wysihtml5-rails'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx]
  gem 'quiet_assets'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'mysql2'
end
group :test do
  gem 'capybara'
  gem 'cucumber-rails', :require=>false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
  gem "shoulda-matchers"
end
group :production do
  # Oracle gems
  gem 'ruby-oci8'
  gem 'activerecord-oracle_enhanced-adapter', '1.4.2'
end

# Temporarily using FB for auth, will use Shibboleth on UMN infra
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'

gem 'will_paginate'
gem 'capistrano', '<3'