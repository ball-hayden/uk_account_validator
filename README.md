UkAccountValidator
==================

[![Build Status](https://travis-ci.org/ball-hayden/uk_account_validator.svg?branch=master)](https://travis-ci.org/ball-hayden/uk_account_validator)

This gem validates uk account numbers against their sort codes in accordance with VocaLink's modulus checking specification, which can be downloaded from [here](https://www.vocalink.com/customer-support/modulus-checking/).

Note that this gem ensures the sort code and account number are valid, not that they exist.

NB the resource text files valacdos.txt and scsubtab.txt are produced and released by VocaLink.

Requires Ruby > 2.0.0

Modulus weight table data can be found [here](https://www.vocalink.com/customer-support/modulus-checking/). (Last verified data was downloaded 2017-10-09).

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

Contributing
------------

1.	Fork it ( https://github.com/ball-hayden/uk_account_validator/fork )
2.	Create your feature branch (`git checkout -b my-new-feature`\)
3.	Commit your changes (`git commit -am 'Add some feature'`\)
4.	Push to the branch (`git push origin my-new-feature`\)
5.	Create a new Pull Request
