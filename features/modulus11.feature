Feature: Modulus 11 Checking

  Background:
    Given I create a new checker

  Scenario: 2) Pass modulus 11 check
    Given I have a sort code 107999
    And I have an account number 88837491

    Then the modulus is MOD11
    And the combination is valid

  Scenario: 30) Fail modulus 11 check
    Given I have a sort code 107999
    And I have an account number 88837493

    Then the modulus is MOD11
    And the combination is invalid