require 'cucumber'
require 'capybara/cucumber'
require 'faraday'
require_relative '../../lib/server'

Capybara.app = MemcachedManager::App

Conn = Faraday.new do |conn|
  conn.adapter :rack, MemcachedManager::App
end
