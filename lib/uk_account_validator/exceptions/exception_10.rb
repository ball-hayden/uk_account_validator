# For the exception 10 check, if ab = 09 or ab = 99 and g = 9, zeroise weighting
# positions u-b.
class Exception10 < BaseException
  def self.allow_any?
    true
  end

  def replace_weight(test_digits)
    # if ab = 09 or 99 and g=9, zeroise weighting positions u-b.
    a = test_digits[NUMBER_INDEX[:a]]
    b = test_digits[NUMBER_INDEX[:b]]

    return zero_u_b if (a == 0 && b == 9) ||
      (a == 9 && b == 9 && test_digits[NUMBER_INDEX[:g]] == 9)

    return modulus_weight
  end
end
