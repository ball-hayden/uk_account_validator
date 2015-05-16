UkAccountValidator
==================

[![Build Status](https://travis-ci.org/ball-hayden/uk_account_validator/master.svg)](https://travis-ci.org/ball-hayden/uk_account_validator)

This gem validates uk account numbers against their sort codes in accordance with VocaLink's specification available at:

http://www.vocalink.com/media/700427/vocalink_-_validating_account_numbers_v3.20.pdf

Installation
------------

Add this line to your application's Gemfile:

```
gem 'uk_account_validator'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install uk_account_validator
```

Usage
-----

```
UkAccountValidator::Validator.new(account_number, sort_code).valid?
```

or

```
validator = UkAccountValidator::Validator.new
validator.account_number = account_number
validator.sort_code      = sort_code
validator.valid?
```

Contributing
------------

1.	Fork it ( https://github.com/[my-github-username]/uk_account_check/fork )
2.	Create your feature branch (`git checkout -b my-new-feature`\)
3.	Commit your changes (`git commit -am 'Add some feature'`\)
4.	Push to the branch (`git push origin my-new-feature`\)
5.	Create a new Pull Request
