source "https://rubygems.org"
source "https://gems.shefcompsci.org.uk" do
  gem 'activerecord-session_store'
  gem 'airbrake'
  gem 'epi_deploy', group: :development
  gem 'capybara-select2', group: :test
end

gem 'rails', '5.2.1'
gem 'bootsnap'
gem 'responders'
gem 'thin'

gem 'sqlite3', '1.3.13', group: [:development, :test]
gem 'pg'

gem 'bootstrap-wysihtml5-rails'

gem 'ed25519', '>= 1.2', '< 2.0'
gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'

gem 'haml-rails', '1.0.0'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'

gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem 'select2-rails'
gem 'epi_js'

gem 'simple_form'
gem 'draper'
gem 'ransack'

gem 'polyamorous'

gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'carrierwave'
gem 'mini_magick'

gem 'devise'
gem 'devise_ldap_authenticatable'
gem 'devise_cas_authenticatable'
gem 'cancancan'

gem 'whenever'
gem 'capistrano3-delayed-job', '~> 1.0'
gem 'delayed_job_active_record'
gem 'delayed-plugins-airbrake'
gem 'daemons'

gem 'turbolinks', '~> 5'
gem 'geokit-rails'
gem 'geocoder'

gem "httparty"
gem "nokogiri"


group :development, :test do
  gem 'rspec-rails'
  gem 'byebug'
end

group :development do
  gem 'listen'
  gem 'web-console'

  gem 'capistrano', '~> 3.4'
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-passenger', require: false

  gem 'eventmachine'
  gem 'letter_opener'
  gem 'annotate'
end

group :test do
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'poltergeist'
  gem 'rspec-instafail', require: false
  gem 'phantomjs', :require => 'phantomjs/poltergeist'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'simplecov'
end