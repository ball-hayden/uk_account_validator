module UkAccountValidator
  class Validator
    attr_accessor :account_number, :sort_code

    def initialize(account_number = nil, sort_code = nil)
      @account_number = account_number
      @sort_code      = sort_code
    end

    def modulus_weights
      @modulus_weights ||= UkAccountValidator.modulus_weights_table.find(sort_code)
    end

    def validator(modulus)
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
      exceptions = modulus_weights.map(&:exception)

      results = modulus_weights.each_with_index.map do |modulus_weight, i|
        if i == 1 && exceptions.include?('2') && exceptions.include?('9')
          next Validator.new(account_number, '309634').valid?
        end

        validator(modulus_weight.modulus).new(account_number, sort_code, modulus_weight, exceptions).valid?
      end

      return results.any? if exceptions.include?('10') && exceptions.include?('11')
      return results.any? if exceptions.include?('2') && exceptions.include?('9')

      results.all?
    end
  end
end
