# encoding: utf-8

When(/^I post the command "(.*?)" to "(.*?)" in the API$/) do |command, route|
  @response = API.post do |req|
    req.url "api/#{route}"
    req.params = {command: command}
  end
end

Then(/^it should be run on memcached and give a response$/) do
  expect(JSON.parse(@response.body)['response']).to match(/ineed/)
end
