module UkAccountValidator
  module Validators
    # Perform validation for sort codes with MOD10
    class StandardModulus < BaseValidator
      def modulus
        fail NotImplementedError
      end

      def valid?
        test_string = @sort_code + @account_number

        test_digits = test_string.split(//).map(&:to_i)

        total = WEIGHT_INDEXES.each_pair.reduce(0) do |t, pair|
          weight, index = pair

          t + @modulus_weight.send(weight) * test_digits[index]
        end

        total % modulus == 0
      end
    end
  end
end
