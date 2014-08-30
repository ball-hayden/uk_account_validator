Feature: Exceptions

  Background:
    Given I create a new checker

  Scenario Outline: Valid Codes
    Given I have a sort code <sortcode>
    And I have an account number <accountnumber>

    Then the combination is valid

  Examples:
    | test | description                                                                                                      | sortcode | accountnumber |
    | 4    | Exception 10 & 11 where first check passes and second check fails.                                               | 871427   | 46238510      |
    | 5    | Exception 10 & 11 where first check fails and second check passes.                                               | 872427   | 46238510      |
    | 6    | Exception 10 where in the account number ab=09 and the g=9. The first check passes and second check fails.       | 871427   | 09123496      |
    | 7    | Exception 10 where in the account number ab=99 and the g=9. The first check passes and the second check fails.   | 871427   | 99123496      |
    | 8    | Exception 3, and the sorting code is the start of a range. As c=6 the second check should be ignored.            | 820000   | 73688637      |
    | 9    | Exception 3, and the sorting code is the end of a range. As c=9 the second check should be ignored.              | 827999   | 73988638      |
    | 10   | Exception 3. As c!=6 or 9 perform both checks pass.                                                              | 827101   | 28748352      |
    | 11   | Exception 4 where the remainder is equal to the checkdigit.                                                      | 134020   | 63849203      |
    | 12   | Exception 1 - ensures that 27 has been added to the accumulated total and passes double alternate modulus check. | 118765   | 64371389      |
    | 13   | Exception 6 where the account fails standard check but is a foreign currency account.                            | 200915   | 41011166      |
    | 14   | Exception 5 where the check passes.                                                                              | 938611   | 07806039      |
    | 15   | Exception 5 where the check passes with substitution.                                                            | 938600   | 42368003      |
    | 16   | Exception 5 where both checks produce a remainder of 0 and pass.                                                 | 938063   | 55065200      |
