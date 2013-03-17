Given /^there's the "(.*?)" memcached key avaiable$/ do |key|
  @key = key
  Memcached.set(@key, 'John Doe')
end

Then /^I should receive a json response with this key$/ do
  @response.class.should eql Hash
  @response["key"].should include 'name'
  @response["value"].should include 'John Doe'
end
