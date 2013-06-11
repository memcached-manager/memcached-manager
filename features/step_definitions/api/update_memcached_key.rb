When /^I put some data to "(.*?)" in the API$/ do |route|
  @data = { key: 'username', value: 'thiagofm' }
  @response = API.put do |req|
    req.url "api/#{route}"
    req.params = @data
  end
end

Then /^I should receive a json response that it was edited successfully$/ do
  @response.status.should be 200
  response_json = JSON.parse(@response.body)
  response_json.class.should eql Hash
  response_json.keys.should include 'key'
end

Then /^it should be updated in memcached$/ do
  Memcached.get(@key).should eql 'thiagofm'
end
