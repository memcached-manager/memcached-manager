Then /^I should receive a json response with the memcached's current stats$/ do
  @response.keys.should include("#{MemcachedConfigs[:host]}:#{MemcachedConfigs[:port]}")
end
