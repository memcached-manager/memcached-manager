@api
@wip
Feature: List memcached keys
  Scenario: Success
    Given there's some memcached keys avaiable
    When I visit "/keys.json" in the API
    Then I should receive a json response with those keys
  Scenario: Request with limit param
    Given there's some memcached keys avaiable
    When I visit "/keys.json" in the API with a limit parameter
    Then I should receive a json response with those keys filtered by the limit parameter
