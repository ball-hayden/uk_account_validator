module UkAccountValidator
  module Validators
    class BaseValidator
      NUMBER_INDEX = {
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

        @sort_code = apply_exception_5_substitutions(sort_code) if @modulus_weight.exception == '5'
      end

      def applying_exceptions(test_digits)
        apply_exception_3(test_digits)  if @modulus_weight.exception == '3'
        apply_exception_6(test_digits)  if @modulus_weight.exception == '6'
        apply_exception_7(test_digits)  if @modulus_weight.exception == '7'
        apply_exception_8(test_digits)  if @modulus_weight.exception == '8'
        apply_exception_10(test_digits) if @modulus_weight.exception == '10'

        total = yield

        total += 27 if @modulus_weight.exception == '1'

        total
      end

      def zero_all
        @modulus_weight = ModulusWeight.new(
          @modulus_weight.sort_code_start,
          @modulus_weight.sort_code_end,
          @modulus_weight.modulus,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          @modulus_weight.exception
        )
      end

      def zero_u_b
        @modulus_weight = ModulusWeight.new(
          @modulus_weight.sort_code_start,
          @modulus_weight.sort_code_end,
          @modulus_weight.modulus,
          0, 0, 0, 0, 0, 0, 0, 0,
          @modulus_weight.c, @modulus_weight.d, @modulus_weight.e,
          @modulus_weight.f, @modulus_weight.g, @modulus_weight.h,
          @modulus_weight.exception
        )
      end

      def apply_exception_3(test_digits)
        c = test_digits[NUMBER_INDEX[:c]]
        zero_all if c == 6 || c == 9
      end

      def apply_exception_4(total, test_digits)
        check_sum = [test_digits[NUMBER_INDEX[:g]], test_digits[NUMBER_INDEX[:h]]].join
        check_sum = check_sum.to_i

        total % modulus == check_sum
      end

      def apply_exception_5_substitutions(sort_code)
        substitutions = UkAccountValidator.read_sort_code_substitution

        if substitutions.keys.include?(sort_code)
          sort_code = substitutions[sort_code]
        end

        return sort_code
      end

      def apply_exception_5(total, test_digits, check_digit)
        check_sum    = total % modulus
        expected_sum = test_digits[NUMBER_INDEX[check_digit]].to_i

        return false if check_sum == 1 && check_digit == :g
        return true  if check_sum == 0 && expected_sum == 0

        return (modulus - check_sum) == expected_sum
      end

      # If a = 4, 5, 6, 7 or 8, and g and h are the same
      def apply_exception_6(test_digits)
        a = test_digits[NUMBER_INDEX[:a]]
        g = test_digits[NUMBER_INDEX[:g]]
        h = test_digits[NUMBER_INDEX[:h]]

        zero_all if (a == 4 || a == 5 || a == 6 || a == 7 || a == 8) && g == h
      end

      def apply_exception_7(test_digits)
        return unless test_digits[NUMBER_INDEX[:g]] == 9

        zero_u_b
      end

      def apply_exception_8(test_digits)
        test_string = '090126' + @account_number

        test_digits.replace(test_string.split(//).map(&:to_i))
      end

      def apply_exception_10(test_digits)
        # if ab = 09 or 99 and g=9, zeroise weighting positions u-b.
        a = test_digits[NUMBER_INDEX[:a]]
        b = test_digits[NUMBER_INDEX[:b]]

        return unless (a == 0 && b == 9) ||
          (a == 9 && b == 9 && test_digits[NUMBER_INDEX[:g]] == 9)

        zero_u_b
      end
    end
  end
end
