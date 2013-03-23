@api
@wip
Feature: Update memcached pair
  Scenario: Success
    Given there's the "username" memcached key avaiable
    When I put some data to "/keys.json" in the API
    Then I should receive a json response that it was edited successfully
    And it should be updated in memcached
