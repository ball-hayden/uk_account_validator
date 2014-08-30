module UkAccountValidator
  module Validators
    # Perform validation for sort codes with MOD10
    class DoubleAlternate < BaseValidator
      def valid?
        test_string = @sort_code + @account_number

        test_digits = test_string.split(//).map(&:to_i)

        # Apply weights
        test_digits = WEIGHT_INDEXES.map do |weight, index|
          @modulus_weight.send(weight) * test_digits[index]
        end

        # Split into individual digits by concating then splitting again.
        test_digits = test_digits.join.split(//).map(&:to_i)

        # Now sum
        total = test_digits.inject(:+)

        total % 10 == 0
      end
    end
  end
end
