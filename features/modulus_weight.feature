Feature: Modulus Weight

  Scenario: Reading Weights
    Given I have the following weight data:
      """
      070116 070116 MOD11    0    0    7    6    5    8    9    4    5    6    7    8    9   -1  12
      """

    Then the weight's sort_code_start is 070116
    And the weight's sort_code_end is 070116
    And the weight's modulus is MOD11
    And the weight's u is 0
    And the weight's v is 0
    And the weight's w is 7
    And the weight's x is 6
    And the weight's y is 5
    And the weight's z is 8
    And the weight's a is 9
    And the weight's b is 4
    And the weight's c is 5
    And the weight's d is 6
    And the weight's e is 7
    And the weight's f is 8
    And the weight's g is 9
    And the weight's h is -1
    And the weight's exception is 12
