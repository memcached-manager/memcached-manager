Feature: API methods
  Scenario: Show memcached keys
    Given there's some memcached keys avaiable
    When I visit "/list_keys".json
    Then I should receive a json response with those keys
