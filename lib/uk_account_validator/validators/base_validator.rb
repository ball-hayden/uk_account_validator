module UkAccountValidator
  module Validators
    class BaseValidator
      include NumberIndices

      attr_reader :account_number, :sort_code, :modulus_weight, :exception

      def initialize(account_number, sort_code, modulus_weight, exception)
        @account_number = account_number
        @sort_code      = sort_code
        @modulus_weight = modulus_weight
        @exception      = exception

        @sort_code = exception.apply_sort_code_substitutions
      end

      def applying_exceptions(test_digits)
        @modulus_weight = exception.replace_weight(test_digits)

        total = yield

        total = exception.after_calculate_total(total, test_digits)

        total
      end
    end
  end
end
