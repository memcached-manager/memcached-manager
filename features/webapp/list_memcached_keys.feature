Feature: List memcached keys
  Scenario: Visiting home
    Given I visit "/"
    Then I should see a bunch of memcached keys
    And I should see the option to flush all keys
    And I should see the option to flush a specific key
    And I should see the option to edit a specific key
