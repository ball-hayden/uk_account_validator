require 'uk_account_validator/backports/array_bsearch_index'

require 'uk_account_validator/number_indices.rb'
require 'uk_account_validator/validator.rb'
require 'uk_account_validator/modulus_weight.rb'
require 'uk_account_validator/modulus_weights_table.rb'

require 'uk_account_validator/validators/base_validator.rb'
require 'uk_account_validator/validators/standard_modulus.rb'
require 'uk_account_validator/validators/modulus10.rb'
require 'uk_account_validator/validators/modulus11.rb'
require 'uk_account_validator/validators/double_alternate.rb'

require 'uk_account_validator/exceptions/base_exception.rb'
require 'uk_account_validator/exceptions/exception_1.rb'
require 'uk_account_validator/exceptions/exception_2_9.rb'
require 'uk_account_validator/exceptions/exception_3.rb'
require 'uk_account_validator/exceptions/exception_4.rb'
require 'uk_account_validator/exceptions/exception_5.rb'
require 'uk_account_validator/exceptions/exception_6.rb'
require 'uk_account_validator/exceptions/exception_7.rb'
require 'uk_account_validator/exceptions/exception_8.rb'
require 'uk_account_validator/exceptions/exception_10.rb'
require 'uk_account_validator/exceptions/exception_12.rb'
require 'uk_account_validator/exceptions/exception_14.rb'

module UkAccountValidator
  def self.modulus_weights_table
    @modulus_weights_table ||= read_modulus_weights_table
  end

  def self.sort_code_substitution
    @sort_code_substitution ||= read_sort_code_substitution
  end

  private

  def self.modulus_weights_table_file
    File.join(File.dirname(__FILE__), '../data/valacdos.txt')
  end

  def self.read_modulus_weights_table
    ModulusWeightsTable.new(modulus_weights_table_file)
  end

  def self.sort_code_substitution_file
    File.join(File.dirname(__FILE__), '../data/scsubtab.txt')
  end

  def self.read_sort_code_substitution
    @substitutions ||= Hash[
      File.readlines(UkAccountValidator.sort_code_substitution_file).map do |line|
        line.split(' ')
      end
    ]
  end
end
