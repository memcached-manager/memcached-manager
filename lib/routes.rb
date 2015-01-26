require_relative 'webapp'
require_relative 'api'

MemcachedManager::Routes = Rack::URLMap.new({
  "/api" => MemcachedManager::API.new,
  "/" => MemcachedManager::Webapp.new
})
