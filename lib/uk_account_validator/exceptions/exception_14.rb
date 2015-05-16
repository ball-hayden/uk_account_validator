# Perform the modulus 11 check as normal:
#  * If the check passes (that is, there is no remainder), then the account
#    number should be considered valid. Do not perform the second check.
#  * If the first check fails, then the second check must be performed as
#    specified below.
#
# Second check:
#  * If the 8th digit of the account number (reading from left to right) is not
#    0, 1 or 9 then the account number fails the second check and is not a valid
#    Coutts account number
#  * If the 8th digit is 0, 1 or 9, then remove the digit from the account
#    number and insert a 0 as the 1st digit for check purposes only
#  * Perform the modulus 11 check on the modified account number using the same
#    weightings as specified in the table (that is, 0 0 0 0 0 0 8 7 6 5 4 3 2 1):
#    - If there is no remainder, then the account number should be considered
#      valid
#    - If there is a remainder, then the account number fails the second check
#      and is not a valid Coutts account number
class Exception14 < BaseException
  def self.allow_any?
    true
  end

  def apply_account_number_substitutions
    return account_number unless %w(0 1 9).include?(account_number[7])

    account_number.slice!(7)
    return '0' + account_number
  end
end
