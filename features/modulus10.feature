Feature: Modulus 10 Checking

  Background:
    Given I create a new checker

  Scenario: 1) Pass modulus 10 check
    Given I have a sort code 089999
    And I have an account number 66374958

    Then the modulus is MOD10
    And the combination is valid

  Scenario: 29) Fail modulus 10 check
    Given I have a sort code 089999
    And I have an account number 66374959

    Then the modulus is MOD10
    And the combination is invalid
