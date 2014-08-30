module UkAccountValidator
  class Validator
    attr_accessor :account_number, :sort_code

    def modulus_weight
      @modulus_weight ||= UkAccountValidator.modulus_weights_table.find(sort_code)
    end

    def modulus
      modulus_weight.modulus
    end

    def validator
      case modulus
      when 'MOD10'
        Validators::Modulus10
      when 'MOD11'
        Validators::Modulus11
      else
        fail NotImplementedError
      end
    end

    def valid?
      validator.new(account_number, sort_code, modulus_weight).valid?
    end
  end
end
