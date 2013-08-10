require 'cucumber'
require 'capybara/cucumber'
require 'faraday'
require 'dalli'
require 'rspec'
require 'rspec/expectations'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist

World(RSpec::Matchers)

# Files
Dir.glob("lib/**/*.rb").each do |file|
  require_relative "../../#{file}"
end

Capybara.app = Rack::Builder.parse_file(File.expand_path('../../../config.ru', __FILE__)).first

API = Faraday.new do |conn| conn.adapter :rack, Rack::URLMap.new({
    "/api" => MemcachedManager::API.new,
    "/" => MemcachedManager::Webapp.new
  })
end

MemcachedConfigs = { host: 'localhost', port: '11211' }
Memcached        = Dalli::Client.new("#{MemcachedConfigs[:host]}:#{MemcachedConfigs[:port]}")
