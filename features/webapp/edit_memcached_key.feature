Feature: Edit memcached key
  Scenario: Editing a key
    Given I visit the page of a key
    When I fill in "value" with "123"
    And I press "Update"
    Then I should see the value of the new key updated
