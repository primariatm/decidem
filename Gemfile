# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = { git: 'https://github.com/decidim/decidim.git', branch: 'release/0.25-stable' }

gem "rails", "6.0.4.1"
gem "decidim", DECIDIM_VERSION

# gem "decidim-conferences", "0.25.0"
# gem "decidim-consultations", "0.25.0"
# gem "decidim-elections", "0.25.0"
# gem "decidim-initiatives", "0.25.0"
# gem "decidim-templates", "0.25.0"

gem 'sidekiq'

gem "bootsnap", "~> 1.3"

gem "puma", ">= 5.0.0"

gem "faker", "~> 2.14"

gem "wicked_pdf", "~> 2.1"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri

  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem "letter_opener_web", "~> 1.3"
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 4.0"
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-shopify", require: false
  gem "rubocop-performance", require: false
end

gem "sentry-ruby", "~> 4.8.1"
gem "sentry-rails", "~> 4.8.1"
gem "sentry-sidekiq", "~> 4.8.1"
gem "dotenv"
gem "dotenv-rails", groups: [:development, :test]
