source 'https://rubygems.org'

gem 'rails'
gem 'active_model_serializers', :github => 'rails-api/active_model_serializers'

gem 'pg'

gem 'omniauth'
gem 'omniauth-password'

gem "therubyracer"

gem 'bluecloth'

gem 'configatron'

gem "mini_magick"
gem 'carrierwave'

gem 'draper'

gem "transitions", :require => ["transitions", "active_model/transitions"]

gem "omniauth-google-oauth2"

gem 'google-api-client'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'bootstrap-sass'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'


group :test, :development do
  gem 'timecop'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'launchy'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'rack_session_access'

  gem 'pry'
  gem 'pry-debugger'
  gem 'pry-rails'

  gem 'capistrano'
  gem 'capistrano-tools', :git => 'git://github.com/fragallia/capistrano-tools.git', :require => false
  gem 'annotate'
  gem 'xml-simple'
end

group :development do
  gem 'quiet_assets'
end

# Use unicorn as the app server
gem 'unicorn'
