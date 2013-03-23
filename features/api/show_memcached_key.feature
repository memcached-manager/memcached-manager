@api
Feature: Show memcached keys
  Scenario: Success
    Given there's the "username" memcached key avaiable
    When I visit "/keys/username.json" in the API
    Then I should receive a json response with this key
