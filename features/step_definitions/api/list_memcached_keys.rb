# encoding: utf-8

Given /^there's some memcached keys avaiable$/ do
  Memcached.set('foo', 'bar')
  Memcached.set('foo1', 'bar')
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

When(/^I visit "(.*?)" in the API with a limit parameter$/) do |route|
  @response = JSON.parse(API.get("api/#{route}?limit=2").body)
end

Then(/^I should receive a json response with those keys filtered by the limit parameter$/) do
  @response.size.should be 2
end
