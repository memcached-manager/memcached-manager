Feature: API methods
  Scenario: Get API stats
    Given I visit "/keys.json"
    And There's some memcached keys avaiable
    Then I should receive a json response with the actual keys
