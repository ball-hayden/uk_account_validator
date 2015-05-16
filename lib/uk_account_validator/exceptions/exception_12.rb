# These are for Nationwide Flex accounts. Where there is a 12 in the exception
# column for the first check for a sorting code and a 13 in the exception column
# for the second check for the same sorting code, if either check is successful
# the account number is deemed valid.
class Exception12 < BaseException
  def self.allow_any?
    true
  end
end
