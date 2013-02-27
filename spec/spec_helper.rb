ENV['RACK_ENV'] = 'test'

# Load the app
require_relative '../lib/server'

require 'bundler'
require 'rspec'
require 'rack/test'
require 'faraday'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

@api = Faraday.new do |conn|
  conn.adapter :rack, MemcachedManager::App.new
end
