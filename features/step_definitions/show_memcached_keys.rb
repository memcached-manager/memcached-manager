Given /^there's some memcached keys avaiable$/ do
  Memcached.set('foo', 'bar')
  Memcached.set('ineed', 'togetalife')
end

When /^I visit "(.*?)"\.json$/ do |route|
  # Had to do it in order to BDD, may erase it l8r
  begin 
    @response = JSON.parse(API.get("#{route}.json").body)
  rescue
  end
end

Then /^I should receive a json response with those keys$/ do
  @response.should_not equal nil
  @response.last.values.should include 'foo'
  @response.first.values.should include 'ineed'
end
