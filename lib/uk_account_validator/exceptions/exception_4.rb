# Perform the standard modulus 11 check.
# After you have finished the check, ensure that the remainder is the same as
# the two-digit checkdigit;
# the checkdigit for exception 4 is gh from the original account number.
class Exception4 < BaseException
  def override_test?
    true
  end

  def test(modulus, total, test_digits, _test)
    check_sum = [test_digits[NUMBER_INDEX[:g]], test_digits[NUMBER_INDEX[:h]]].join
    check_sum = check_sum.to_i

    total % modulus == check_sum
  end
end
