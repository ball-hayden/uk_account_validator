module UkAccountValidator
  class Validator

    attr_writer   :sort_code
    attr_accessor :account_number

    def initialize(account_number = nil, sort_code = nil)
      @account_number = account_number
      @sort_code      = sort_code
    end

    def sort_code
      @sort_code.gsub('-', '')
    end

    def modulus_weights
      @modulus_weights ||= UkAccountValidator.modulus_weights_table.find(sort_code)
    end

    def modulus_validator(modulus)
      case modulus
      when 'MOD10'
        Validators::Modulus10
      when 'MOD11'
        Validators::Modulus11
      when 'DBLAL'
        Validators::DoubleAlternate
      else
        fail NotImplementedError
      end
    end

    def valid?
      return false unless valid_format?

      exceptions = modulus_weights.map(&:exception)
      exception_class = self.exception_class(exceptions)

      results = modulus_weights.each_with_index.map do |modulus_weight, i|
        exception = exception_class.new(modulus_weight, account_number, sort_code, i + 1)

        @account_number = exception.apply_account_number_substitutions

        modulus_validator(modulus_weight.modulus).new(
          account_number, sort_code, modulus_weight, exception
        ).valid?
      end

      return results.any? if exception_class.allow_any?

      results.all?
    end

    def valid_format?
      return false if account_number =~ /\D/
      return false if account_number.length < 6
      return false if account_number.length > 10
      return false if sort_code.length != 6

      return true
    end

    def exception_class(exception_strings)
      case
      when exception_strings.include?('1')
        Exception1
      when exception_strings.include?('2') && exception_strings.include?('9')
        Exception29
      when exception_strings.include?('3')
        Exception3
      when exception_strings.include?('4')
        Exception4
      when exception_strings.include?('5')
        Exception5
      when exception_strings.include?('6')
        Exception6
      when exception_strings.include?('7')
        Exception7
      when exception_strings.include?('8')
        Exception8
      when exception_strings.include?('10') && exception_strings.include?('11')
        Exception10
      when exception_strings.include?('12') && exception_strings.include?('13')
        Exception12
      when exception_strings.include?('14')
        Exception14
      else
        BaseException
      end
    end
  end
end
