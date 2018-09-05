source "https://rubygems.org"
ruby "2.5.1"

gem "rails", "5.2.1"
gem "pg"
gem "puma", "~> 3.11"

# Extensions
gem "bootsnap", require: false
gem "pundit"
gem "sidekiq"
gem "metainspector"
gem "active_model_serializers"
gem "httparty"

# Services
gem "newrelic_rpm"

group :development, :test do
  gem "pry-byebug"
  gem "pry-doc"
  gem "pry-rails"
  gem "guard-rspec"
  gem "rb-fsevent"
  gem "rspec-rails"
  gem "timecop"
  gem "rubocop-rspec-focused", require: false
  gem "webmock", require: false
end

group :development do
  gem "annotate"
  gem "spring"
  gem "spring-commands-rspec"
  gem "listen"
  gem "letter_opener"
  gem "rails-erd"
  gem "web-console"
end
