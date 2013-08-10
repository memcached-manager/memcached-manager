@webapp
@javascript
Feature: Create memcached pair
  Scenario: Success
    When I visit "#/new"
    And fill in "Key" with "foo"
    And fill in "Value" with "bar"
    And click "create"
    Then it should exist in memcached
