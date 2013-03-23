require 'cucumber'
require 'capybara/cucumber'
require 'faraday'
require 'dalli'
require_relative '../../lib/server'

Capybara.app     = MemcachedManager::App
API              = Faraday.new {|conn| conn.adapter :rack, MemcachedManager::App }
MemcachedConfigs = { host: 'localhost', port: '11211' }
Memcached        = Dalli::Client.new("#{MemcachedConfigs[:host]}:#{MemcachedConfigs[:port]}")

