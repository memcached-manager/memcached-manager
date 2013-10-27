# Sinatra modules
require './lib/webapp'
require './lib/api'

MemcachedManager::App = Rack::URLMap.new({
  "/api" => MemcachedManager::API.new,
  "/" => MemcachedManager::Webapp.new
})

run MemcachedManager
