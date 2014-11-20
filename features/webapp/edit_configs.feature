@webapp
@javascript
Feature: Edit configs of memcached
  Scenario: Success
    When I visit "#/config"
    And fill in "Host" with "127.0.0.1"
    And fill in "Port" with "11211"
    And click "Edit"
    Then I should see those configs in "/api/config.json"
