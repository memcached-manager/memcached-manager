@api
Feature: Create memcached pair
  Scenario: Success
    When I post some data to "/keys.json" in the API
    Then I should receive a json response that it was saved successfully
    And it should be saved in memcached
