module UkAccountValidator
  module Validators
    class BaseValidator
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
    end
  end
end
