When(/^I post the command "(.*?)" to "(.*?)" in the API$/) do |command, route|
  @response = API.post do |req|
    req.url "api/#{route}"
    req.params = {command: command}
  end
end

Then(/^it should be run on memcached and give a response$/) do
  expect(JSON.parse(@response.body)).to eq({"response"=>"VALUE ineed 1 20\n\u0004\bI\"\u000Ftogetalife\u0006:\u0006ET\nEND\n"})
end
