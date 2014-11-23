@api
Feature: Search memcached keys
  Scenario: Success
    Given there's some memcached keys avaiable
    When I visit "/keys.json?query=foo" in the API
    Then I should receive a json response with the "foo" and "foo1" keys
