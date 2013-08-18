@webapp
@javascript
Feature: Show memcached stats
  Scenario: Success
    When I visit "#/"
    Then I should see memcached stats
