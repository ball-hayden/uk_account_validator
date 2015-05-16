# Perform the double alternate check except:
#   Add 27 to the total (ie before you divide by 10)
# This effectively places a financial institution number (580149) before the
# sorting code and account number which is subject to the alternate doubling as
# well.
class Exception1 < BaseException
  def after_calculate_total(total, _test_digits)
    return total + 27
  end
end
