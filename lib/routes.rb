MemcachedManager::Routes = Rack::URLMap.new({
  "/api" => MemcachedManager::API.new,
  "/" => MemcachedManager::Webapp.new
})
