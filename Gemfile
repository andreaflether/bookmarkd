# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.5'
gem 'rails', '~> 5.2.4', '>= 5.2.4.3'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'sqlite3'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# Custom gems for this project
gem 'actionmailer_inline_css'
gem 'activerecord-typedstore'
gem 'bootstrap4-kaminari-views'
gem 'cursor-paginate'
gem 'data-confirm-modal'
gem 'devise'
gem 'faker'
gem 'friendly_id'
gem 'kaminari'
gem 'omniauth-twitter'
gem 'pg'
gem 'ransack'
gem 'rest-client'
gem 'rubocop-rails', require: false
gem 'rubocop-rspec', require: false
gem 'simple_form'
gem 'twitter'

group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara'
end

group :development do
  gem 'bullet'
  gem 'guard', '~> 2.15'
  gem 'guard-livereload', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'query_diet'
  gem 'rack-livereload'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'sql_tracker'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'database_cleaner', '~> 1.7'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'json_matchers'
  gem 'rails-controller-testing'
  gem 'rspec-json_expectations'
  gem 'rspec-rails', '~> 3.6'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'webdrivers'
  gem 'webmock'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
