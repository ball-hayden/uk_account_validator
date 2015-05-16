# Only occurs for some standard modulus 11 checks, when there is a 2 in the
# exception column for the first check for a sorting code and a 9 in the
# exception column for the second check for the same sorting code. This is used
# specifically for Lloyds euro accounts.
#
# Perform the standard check, except:
#  * If a <> 0 and g <> 9, substitute the weight specified in the modulus weight
#    table with:
#      u v w x y z a b c d e  f g h
#      0 0 1 2 5 3 6 4 8 7 10 9 3 1
#
#  * If a <> 0 and g = 9, substitute the weight specified in the modulus weight
#    table with:
#      u v w x y z a b c d e f g h
#      0 0 0 0 0 0 0 0 8 7 10 9 3 1
#
# If the first row with exception 2 passes the standard modulus 11 check, you do
# not need to carry out the second check (ie it is deemed to be a valid sterling
# account).
#
# All Lloyds euro accounts are held at sorting code 30-96-34, however customers
# may perceive that their euro account is held at the branch where sterling
# accounts are held and thus quote a sorting code other than 30-96-34. The
# combination of the "sterling" sorting code and "euro" account number will
# cause the first standard modulus 11 check to fail. In such cases, carry out
# the second modulus 11 check, substituting the sorting code with 309634 and the
# appropriate weighting. If this check passes it is deemed to be a valid euro
# account.

class Exception29 < BaseException
  def self.allow_any?
    true
  end

  def apply_sort_code_substitutions
    return '309634' if check_number == 2

    return sort_code
  end

  def replace_weight(test_digits)
    return modulus_weight if test_digits[NUMBER_INDEX[:a]] == 0
    return substitute_modulus_weight if check_number == 2

    if test_digits[NUMBER_INDEX[:g]] != 9
      return UkAccountValidator::ModulusWeight.new(
        modulus_weight.sort_code_start,
        modulus_weight.sort_code_end,
        modulus_weight.modulus,
        0, 0, 1, 2, 5, 3, 6, 4, 8, 7, 10, 9, 3, 1,
        modulus_weight.exception
      )
    else
      return UkAccountValidator::ModulusWeight.new(
        modulus_weight.sort_code_start,
        modulus_weight.sort_code_end,
        modulus_weight.modulus,
        0, 0, 0, 0, 0, 0, 0, 0, 8, 7, 10, 9, 3, 1,
        modulus_weight.exception
      )
    end
  end

  # Returns the modulus weight for 309634
  def substitute_modulus_weight
    UkAccountValidator.modulus_weights_table.find('309634').first
  end
end
