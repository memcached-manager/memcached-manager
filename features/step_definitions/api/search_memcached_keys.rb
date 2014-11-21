Then(/^I should receive a json response with the "(.*?)" and "(.*?)" keys$/) do |key1, key2|
  keys = @response.map{|p| p['key']}
  expect(keys.size).to be 2
  expect(keys).to include key1
  expect(keys).to include key2
end
