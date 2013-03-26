# Sinatra modules
require './lib/webapp'
require './lib/api'

run Rack::URLMap.new({
  "/api" => MemcachedManager::API.new,
  "/" => MemcachedManager::Webapp.new
})
