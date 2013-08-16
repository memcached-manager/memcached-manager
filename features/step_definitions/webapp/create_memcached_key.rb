When /^click on the X inside a div$/ do
  within(".key-actions") do
    find('.icon-remove').click
  end
  sleep 5
end

Then /^"(.*?)" key shouldn't exist in memcached$/ do |key|
  Memcached.get(key).should be nil
end
