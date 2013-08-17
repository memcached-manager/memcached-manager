Then /^I should see "(.*?)" and "(.*?)" keys in the listing$/ do |key1, key2|
  page.should have_content(key1)
  page.should have_content(key2)
end
