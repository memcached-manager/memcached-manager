Feature: Search memcached key
  Scenario: Searching a key
    Given I type something in "search"
    When I press enter
    Then It should find keys with that I had previously typed
