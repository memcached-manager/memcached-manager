@webapp
@javascript
Feature: Create memcached pair
  Scenario: Success
    When I visit "#/new"
    And fill in "Key" with "foo"
    And fill in "Value" with "bar"
    And click "Create"
    Then "foo" key should have the "bar" value in memcached
