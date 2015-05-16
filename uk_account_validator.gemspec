# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uk_account_validator/version'

Gem::Specification.new do |spec|
  spec.name          = 'uk_account_validator'
  spec.version       = UkAccountValidator::VERSION
  spec.authors       = ['Hayden Ball']
  spec.email         = ['hayden@haydenball.me.uk']
  spec.summary       = 'Validate UK Account Numbers and Sort Codes'
  spec.description   = spec.summary
  spec.homepage      = ''
  spec.license       = '2 Clause BSD'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']
end
