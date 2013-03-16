Feature: Show memcached stats
  Scenario: Visiting show stats
    Given I visit "/stats"
    Then I should see some statistics about memcached
