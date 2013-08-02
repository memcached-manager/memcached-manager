@api
Feature: Show memcached stats
  Scenario: Success
    When I visit "/stats.json" in the API
    Then I should receive a json response with the memcached's current stats
