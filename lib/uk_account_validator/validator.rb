module UkAccountValidator
  class Validator
    attr_accessor :account_number, :sort_code

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
      exceptions = []

      results = modulus_weights.map do |modulus_weight|
        exceptions << modulus_weight.exception
        validator(modulus_weight.modulus).new(account_number, sort_code, modulus_weight).valid?
      end

      # Exceptions 10 and 11
      return results.any? if exceptions.include?('10') && exceptions.include?('11')

      results.all?
    end
  end
end
