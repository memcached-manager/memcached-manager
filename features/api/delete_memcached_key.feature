@wip
Feature: Delete memcached key
  Scenario: Success
    Given there's the "username" memcached key avaiable
    When I visit "/keys/username.json" in the API with the delete method
    Then this key shouldn't exist.
