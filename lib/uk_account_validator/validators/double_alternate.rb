module UkAccountValidator
  module Validators
    # Perform validation for sort codes with MOD10
    class DoubleAlternate < BaseValidator
      def valid?
        test_string = @sort_code + @account_number

        test_digits = test_string.split(//).map(&:to_i)

        total = applying_exceptions(test_digits) do
          # Apply weights
          test_digits = NUMBER_INDEX.map do |weight, index|
            @modulus_weight.send(weight) * test_digits[index]
          end

          # Split into individual digits by concating then splitting again.
          test_digits = test_digits.join.split(//).map(&:to_i)

          # Now sum
          test_digits.inject(:+)
        end

        return exception4(total, test_digits) if @modulus_weight.exception == '4'

        total % 10 == 0
      end
    end
  end
end
