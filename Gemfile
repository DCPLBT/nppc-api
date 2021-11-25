# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  gem 'bullet', '~> 6.1'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'database_cleaner', '~> 1.8'
  gem 'factory_bot_rails', '~> 6.1'
  gem 'faker', '~> 2.15'
  gem 'rspec-rails', '~> 4.0'
  gem 'rubocop-rails', '~> 2.9'
  gem 'rubocop-rspec', '~> 2.0'
  gem 'shoulda-matchers', '~> 4.4'
  gem 'simplecov', '~> 0.20.0'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'annotate', '~> 3.1'
gem 'devise', '~> 4.7'
gem 'devise_invitable', '~> 2.0'
gem 'dotenv-rails', '~> 2.7'
gem 'fast_jsonapi', '~> 1.5'
gem 'haml-rails', '~> 2.0'
gem 'http_accept_language', '~> 2.1'
gem 'letter_opener', '~> 1.7'
gem 'overcommit', '~> 0.57.0'
gem 'pagy', '~> 3.11'
gem 'pundit', '~> 2.1'
gem 'react-rails', '~> 2.6'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
