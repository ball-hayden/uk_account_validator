# If c=6 or c=9 the double alternate check does not need to be carried out
class Exception3 < BaseException
  def replace_weight(test_digits)
    c = test_digits[NUMBER_INDEX[:c]]

    return zero_all if c == 6 || c == 9

    return modulus_weight
  end
end
