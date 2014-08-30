Feature: Modulus Weight Table

Scenario: Finding appropriate modulus weight
  Given I have a modulus weight table loaded from data/valacdos.txt

  Then the modulus for sort code 010004 is MOD11
  And the modulus for sort code 010005 is MOD11
  And the modulus for sort code 016714 is MOD11
  And the modulus for sort code 016715 is MOD11

Scenario: Sort code doesn't exist
  Given I have a modulus weight table loaded from data/valacdos.txt

  Then the modulus for sort code 020000 cannot be found
