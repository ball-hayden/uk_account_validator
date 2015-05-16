class BaseException
  include NumberIndices

  attr_reader :modulus_weight, :account_number, :sort_code, :check_number

  def initialize(modulus_weight, account_number, sort_code, check_number)
    @modulus_weight = modulus_weight
    @account_number = account_number
    @sort_code      = sort_code
    @check_number   = check_number
  end

  def self.allow_any?
    false
  end

  def override_test?
    false
  end

  # Returns the new modulus weight after applying the exception.
  def replace_weight(_test_digits)
    return modulus_weight
  end

  # Returns the new total after any adjustments
  def after_calculate_total(total, _test_digits)
    return total
  end

  def apply_account_number_substitutions
    return account_number
  end

  # Returns the new sort code after substitutions
  def apply_sort_code_substitutions
    return sort_code
  end

  # Useful functions

  # Zero all weights
  def zero_all
    UkAccountValidator::ModulusWeight.new(
      modulus_weight.sort_code_start,
      modulus_weight.sort_code_end,
      modulus_weight.modulus,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      modulus_weight.exception
    )
  end

  # Zero weights for u to b
  def zero_u_b
    UkAccountValidator::ModulusWeight.new(
      modulus_weight.sort_code_start,
      modulus_weight.sort_code_end,
      modulus_weight.modulus,
      0, 0, 0, 0, 0, 0, 0, 0,
      modulus_weight.c, modulus_weight.d, modulus_weight.e,
      modulus_weight.f, modulus_weight.g, modulus_weight.h,
      modulus_weight.exception
    )
  end
end
