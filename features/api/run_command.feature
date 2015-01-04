@api
Feature: Run command
  Scenario: Success
    Given there's some memcached keys avaiable
    When I post the command "get ineed" to "/run.json" in the API
    Then it should be run on memcached and give a response
