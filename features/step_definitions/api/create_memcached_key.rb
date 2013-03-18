When /^I post some data to "(.*?)" in the API$/ do |route|
  @data = { key: 'all.i.want.to.do', value: 'is.bang.bang.bang' }
  @response = API.post do |req|
    req.url "api/#{route}"
    req.params = @data
  end
end

Then /^I should receive a json response that it was saved successfully$/ do
  @response.status.should be 200
  response_json = JSON.parse(@response.body)
  response_json.class.should eql Hash
  response_json.keys.should include 'saved'
  response_json['saved'].should == true
end

Then /^it should be saved in memcached$/ do
  key = Memcached.get(@data[:key])
  key.should == @data[:value]
end
