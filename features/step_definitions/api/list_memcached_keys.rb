# encoding: utf-8

Given /^there's some memcached keys avaiable$/ do
  Memcached.set('foo', 'bar')
  Memcached.set('ineed', 'togetalife')
end

When /^I visit "(.*?)" in the API$/ do |route|
  @response = JSON.parse(API.get("api/#{route}").body)
end

Then /^I should receive a json response with those keys$/ do
  @response.should_not equal nil
  @response.last.values.should include 'foo'
  @response.first.values.should include 'ineed'
end
