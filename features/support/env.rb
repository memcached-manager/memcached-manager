require 'cucumber'
require 'capybara/cucumber'
require_relative '../../lib/memcached-manager'

Capybara.app = MemcachedManager::App
