Given /^I visit "(.*?)"$/ do |arg1|
  @response = JSON.parse(Conn.get('/').body)
end

Then /^I should receive a json response with the actual keys$/ do
  @response.keys.first.should == "xpto"
  @response.values.first.should == 1
end
