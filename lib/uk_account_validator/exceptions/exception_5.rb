# Perform the first check (standard modulus check) except:
#  * If the sorting code appears in SCSUBTAB.txt, substitute it for the
#    "substitute with" column (for check purposes only).
#    If the sorting code is not found, use the original sorting code.
#
# For the standard check with exception 5 the checkdigit is g from the original
# account number.
#  * After dividing the result by 11:
#    - if the remainder = 0 and g = 0 the account number is valid
#    - if the remainder = 1 the account number is invalid
#    - for all other remainders, take the remainder away from 11. If the number
#      you get is the same as g then the account number is valid.
#
# Perform the second double alternate check, and for the double alternate check
# with exception 5 the checkdigit is h from the original account number, except:
#  * After dividing the result by 10:
#    - if the remainder = 0 and h = 0 the account number is valid
#    - for all other remainders, take the remainder away from 10. If the number
#      you get is the same as h then the account number is valid.
class Exception5 < BaseException
  def apply_sort_code_substitutions
    substitutions = UkAccountValidator.read_sort_code_substitution

    return substitutions[sort_code] if substitutions.keys.include?(sort_code)

    return sort_code
  end

  def override_test?
    true
  end

  def test(modulus, total, test_digits, test)
    if test == :double_alternate
      check_digit = :h
    else
      check_digit = :g
    end

    check_sum    = total % modulus
    expected_sum = test_digits[NUMBER_INDEX[check_digit]].to_i

    return false if check_sum == 1 && check_digit == :g
    return true  if check_sum == 0 && expected_sum == 0

    return (modulus - check_sum) == expected_sum
  end
end
