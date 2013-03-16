Feature: Flush memcached key
  Scenario: Flushing a key
    Given I visit the page of a key
    When I click the "Flush key" button
    Then I shouldn't see the key in the listing.
