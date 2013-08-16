@webapp
@javascript
Feature: Delete memcached pair
  Scenario: Success
    Given a key named "foo" with the content "bar" exists
    When I visit "#/"
    And click on the X inside a div
    Then "foo" key shouldn't exist in memcached



