@webapp
@javascript
Feature: Show memcached key
  Scenario: Success
    Given a key named "foo" with the content "bar" exists
    When I visit "#/key/foo"
    Then I should be able to see the "foo" key with the "bar" value
