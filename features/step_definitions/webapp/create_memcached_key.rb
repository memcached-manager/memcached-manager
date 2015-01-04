When /^I visit "(.*?)"$/ do |route|
  visit route
end

When /^fill in "(.*?)" with "(.*?)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^click "(.*?)"$/ do |button|
  click_button button
end

Then /^"(.*?)" key should have the "(.*?)" value in memcached$/ do |key, value|
  sleep 5
  Memcached.get(key).should == value
end
