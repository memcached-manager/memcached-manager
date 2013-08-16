Given /^a key named "(.*?)" with the content "(.*?)" exists$/ do |key, value|
  Memcached.set(key, value)
end
