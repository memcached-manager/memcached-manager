# Sinatra
require 'sinatra/base'
require 'sinatra/contrib'
require 'json'

# Sinatra modules
require './lib/webapp'
require './lib/api'

# Project files
require './lib/extensions'

run Rack::URLMap.new({
  "/api" => MemcachedManager::API.new,
  "/" => MemcachedManager::Webapp.new
})
