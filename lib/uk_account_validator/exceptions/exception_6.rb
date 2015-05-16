# Indicates that these sorting codes may contain foreign currency accounts which
# cannot be checked.
# Perform the first and second checks, except:
#   If a = 4, 5, 6, 7 or 8, and g and h are the same, the accounts are for a
#   foreign currency and the checks cannot be used.
class Exception6 < BaseException
  def replace_weight(test_digits)
    a = test_digits[NUMBER_INDEX[:a]]
    g = test_digits[NUMBER_INDEX[:g]]
    h = test_digits[NUMBER_INDEX[:h]]

    return zero_all if (a == 4 || a == 5 || a == 6 || a == 7 || a == 8) && g == h

    return modulus_weight
  end
end
