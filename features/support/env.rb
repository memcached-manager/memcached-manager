require 'cucumber'
require 'capybara/cucumber'
require 'faraday'
require 'dalli'
require_relative '../../lib/server'

Capybara.app = MemcachedManager::App
API          = Faraday.new {|conn| conn.adapter :rack, MemcachedManager::App }

