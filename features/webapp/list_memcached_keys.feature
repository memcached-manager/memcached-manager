@webapp
@javascript
Feature: List memcached pair
  Scenario: Success
    Given a key named "foo" with the content "bar" exists
    And a key named "fu" with the content "bar" exists
    When I visit "#/"
    Then I should see "foo" and "fu" keys in the listing
