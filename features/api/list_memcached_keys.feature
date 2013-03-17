Feature: API methods
  Scenario: List memcached keys
    Given there's some memcached keys avaiable
    When I visit "/keys.json" in the API
    Then I should receive a json response with those keys
