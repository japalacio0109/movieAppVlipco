# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

ruby '2.6.3'

gem 'grape'
gem 'grape-swagger'
gem 'json'
gem 'rack-cors'
gem 'mime-types'
gem 'sequel'
gem 'sqlite3'
gem 'mysql2'
gem 'puma'
gem 'newrelic_rpm'
gem 'dry-transaction', '~> 0.13.0'
gem 'dry-validation', '~> 1.3', '>= 1.3.1'
gem 'dry-schema', '~> 1.3', '>= 1.3.4'
gem 'dry-struct', '~> 1.0'
gem 'dry-types', '~> 1.1', '>= 1.1.1'

group :development do
  gem 'rake'
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rack'
  gem 'rubocop'
  gem 'pry'
end

group :test do
  gem 'minitest'
end
