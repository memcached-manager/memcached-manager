Then /^I should see memcached stats$/ do
  page.should have_content('Stats')
  page.should have_content("#{MemcachedConfigs[:host]}")
  page.should have_content("#{MemcachedConfigs[:port]}")
end
