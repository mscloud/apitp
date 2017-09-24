source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Bootstrap framework
gem 'bootstrap-sass', '~> 3.3.7'

# Devise authentication
gem 'devise', '~> 4.3.0'
# Pundit authorization
gem 'pundit', '~> 1.1.0'
# ActiveAdmin dashboard
gem 'activeadmin', github: 'activeadmin', tag: 'v1.1.0'
# Extensions of ActiveAdmin
gem 'just-datetime-picker', '~> 0.0.7'

# Validate datetimes
gem 'validates_timeliness', '~> 4.0.2'
# Validate urls
gem 'validate_url', '~> 1.0.2'

# Upload handling
gem 'carrierwave', '~> 1.1.0'

# Notify exceptions by e-mail
gem 'exception_notification', '~> 4.2.2'

# Background jobs with ActiveJobs + Que
gem 'que', '~> 0.14.0'

# Locking on PostgreSQL
gem 'with_advisory_lock', '~> 3.1.1'

# Import CSV files
gem 'smarter_csv', '~> 1.1.4'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
