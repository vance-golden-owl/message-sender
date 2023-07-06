source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'rails', '~> 7.0.3'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'bootsnap', require: false
gem 'bcrypt'
gem 'rack-cors'
gem 'blueprinter'
gem 'seedbank'
gem 'pundit'
gem 'pagy'
gem 'jwt'
gem 'sentry-ruby'
gem 'sentry-rails'
gem 'enumerize'
gem 'image_processing', '>= 1.2'
gem 'rswag'
gem 'countries', '~> 5.3'
gem 'slim'
gem 'geocoder'
gem 'timezone', '~> 1.0'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-rails'
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 5.1', '>= 5.1.2'
  gem 'rspec_junit_formatter'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem 'rubocop', require: false
  gem 'brakeman', require: false
  gem 'letter_opener'
  gem 'annotate'
  gem 'bullet'
end

group :test do
  gem 'simplecov', require: false
  gem 'shoulda-matchers'
end
