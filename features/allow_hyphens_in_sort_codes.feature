Feature: Allow hyphens in sort codes
  Background:
    Given I create a new checker

  Scenario: A user supplies a valid sort code
    Given I have a sort code 089999
    And I have an account number 66374958

    Then the combination is valid

  Scenario: A user supplies a valid sort code separated by hyphens
    Given I have a sort code 08-99-99
    And I have an account number 66374958

    Then the combination is valid

  Scenario: A user supplies a valid sort code separated by spaces
    Given I have a sort code 08 99 99
    And I have an account number 66374958

    Then the combination is valid

  Scenario: A user supplies an invalid sort code separated by hyphens
    Given I have a sort code 08-99-99-
    And I have an account number 66374958

    Then the combination is invalid
