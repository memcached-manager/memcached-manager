require './lib/server'

run Rack::URLMap.new({
  "/api" => MemcachedManager::API.new,
  "/" => MemcachedManager::Webapp.new
})
