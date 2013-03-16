Feature: API methods
  Scenario: Get API stats
    Given there's some memcached keys avaiable
    When I visit "/list_keys".json
    Then I should receive a json response with those keys
