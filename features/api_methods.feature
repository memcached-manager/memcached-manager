Feature: API methods
  Scenario: Get API stats
    Given I visit "/keys.json"
    Then I should receive a json response with the actual keys
