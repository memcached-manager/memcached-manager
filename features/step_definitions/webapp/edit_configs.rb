Then(/^I should see those configs in "(.*?)"$/) do |route|
  response = API.get(route)
  response = JSON.parse(response.body)

  expect(response['host']).to eq 'localhost'
  expect(response['port']).to eq '11211'
end
