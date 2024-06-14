module UkAccountValidator
  class Validator

    attr_accessor :account_number,
                  :sort_code

    def initialize(account_number = nil, sort_code = nil)
      @account_number = account_number.to_s.strip
      @sort_code      = parse_sort_code(sort_code)
    end

    def sort_code=(sort_code)
      @sort_code = parse_sort_code(sort_code)
    end

    def account_number=(account_number)
      @account_number = account_number.to_s.strip
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
      !"#{@sort_code}-#{@account_number}".match(/^[0-9]{6}-[0-9]{6,10}$/).nil?
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

    def parse_sort_code(sort_code)
      return sort_code.to_s if sort_code.to_s.strip.match(/^[0-9]{2}[- ]?[0-9]{2}[- ]?[0-9]{2}$/).nil?
      
      sort_code.gsub(/[- ]/, '') 
    end
  end
end
