module UkAccountValidator
  module Validators
    # Perform validation for sort codes with MOD10
    class StandardModulus
      WEIGHT_INDEXES = {
        u: 0,
        v: 1,
        w: 2,
        x: 3,
        y: 4,
        z: 5,
        a: 6,
        b: 7,
        c: 8,
        d: 9,
        e: 10,
        f: 11,
        g: 12,
        h: 13
      }

      def initialize(account_number, sort_code, modulus_weight)
        @account_number = account_number
        @sort_code = sort_code
        @modulus_weight = modulus_weight
      end

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
