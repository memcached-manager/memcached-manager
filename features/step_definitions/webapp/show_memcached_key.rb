Then /^I should be able to see the "(.*?)" key with the "(.*?)" value$/ do |key, value|
  page.should have_content(key)
  page.should have_content(value)
end
