When /^I visit "(.*?)" in the API with the delete method$/ do |route|
  API.delete("api/#{route}")
end

Then /^this key shouldn't exist\.$/ do
  Memcached.get('username').should eql nil
end
