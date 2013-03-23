When /^I post configs to "(.*?)" in the API$/ do |route|
  @data = { 'host' => 'i.am', 'port' => '1337' }
  @route = route

  API.post do |req|
    req.url "api/#{@route}"
    req.params = @data
  end
end

Then /^the memcached config should be set$/ do
  response = API.get("api/#{@route}")
  response_json = JSON.parse(response.body)

  response.status.should be 200
  response_json['host'].should eql @data['host']
  response_json['port'].should eql @data['port']

  # Workaround so the next feature don't use the current memcached configs
  @data = { 'host' => MemcachedConfigs[:host], 'port' => MemcachedConfigs[:port] }
  API.post do |req|
    req.url "api/#{@route}"
    req.params = @data
  end
end
