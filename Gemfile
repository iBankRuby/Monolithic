source 'https://rubygems.org'
ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'devise'
gem 'dotenv'
gem 'forgery'
gem 'hamlit'
gem 'hamlit-rails'
gem 'ibandit', '~> 0.11.5'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'materialize-sass'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.2'
gem 'rails_12factor', group: :production
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'materialize-sass'

group :assets do
  gem 'coffee-rails'
end
group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'diff-lcs', '>= 1.3'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'faker'
  gem 'pry'
  gem 'reek'
  gem 'rubocop'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'simplecov', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'railroady'
end

group :test do
  gem 'factory_girl_rails'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.6'
  gem 'selenium-webdriver'
  gem 'timecop'
end
