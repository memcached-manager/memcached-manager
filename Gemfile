source 'https://rubygems.org'

gem "sinatra"
gem "sinatra-contrib"
gem "dalli"

group :development do
  gem "jeweler", "~> 1.8.8"
end

group :test do
  gem "poltergeist"
  gem "rack-test", :require => "rack/test"
  gem "rspec"
  gem "mocha"
  gem "cucumber"
  gem "capybara", :require => false
  gem "faraday"
end

group :development, :test do
  gem 'jasmine', "= 1.3.2"
  gem "cucumber"
end
