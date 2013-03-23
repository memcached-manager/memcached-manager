@api
@wip
Feature: Set memcached info
  Scenario: Success
    When I post configs to "/config.json" in the API
    Then the memcached config should be set
