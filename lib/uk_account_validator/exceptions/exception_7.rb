# Perform the check as specified, except if g = 9 zeroise weighting positions
# u-b.
class Exception7 < BaseException
  def replace_weight(test_digits)
    return modulus_weight unless test_digits[NUMBER_INDEX[:g]] == 9

    return zero_u_b
  end
end
