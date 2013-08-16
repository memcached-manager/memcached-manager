@webapp
@javascript
Feature: Edit memcached pair
  Scenario: Success
    Given a key named "foo" with the content "bar" exists
    When I visit "#/edit/foo"
    And fill in "Value" with "baz"
    And click "Edit"
    Then "foo" key should have the "baz" value in memcached
