Feature: Account number and sort code must be in recognised format
  Background:
    Given I create a new checker

  Scenario: Account number contains letters
    Given I have a sort code 089999
    And I have an account number abcdefgh

    Then the combination is invalid

  Scenario: Account number must be at least 6 digits
    Given I have a sort code 089999
    And I have an account number 66374

    Then the combination is invalid

  Scenario: Account number may not be more than 10 digits
    Given I have a sort code 089999
    And I have an account number 66374958663

    Then the combination is invalid

  Scenario: The sort code may not be less than 6 digits
    Given I have a sort code 08999
    And I have an account number 66374958

    Then the combination is invalid

  Scenario: The sort code may not be more than 6 digits
    Given I have a sort code 0899999
    And I have an account number 66374958

    Then the combination is invalid
