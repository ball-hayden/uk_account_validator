Feature: Two Modulus Checks

  Background:
  Given I create a new checker

  Scenario Outline: Valid Codes
    Given I have a sort code <sortcode>
    And I have an account number <accountnumber>

    Then the combination is valid

  Examples:
    | test | description                                  | sortcode | accountnumber |
    | 3    | Pass modulus 11 and double alternate checks. | 202959   | 63748472      |

  Scenario Outline: Invalid Codes
    Given I have a sort code <sortcode>
    And I have an account number <accountnumber>

    Then the combination is invalid

  Examples:
    | test | description                                            | sortcode | accountnumber |
    | 27   | Pass modulus 11 check and fail double alternate check. | 203099   | 66831036      |
    | 28   | Fail modulus 11 check and pass double alternate check. | 203099   | 58716970      |
