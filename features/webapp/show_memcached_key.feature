Feature: Show memcached key
  Scenario: Visiting show
    Given I visit the page of a key
    Then I should see the key
    And I should see the option to flush it
    And I should see the option do edit it

