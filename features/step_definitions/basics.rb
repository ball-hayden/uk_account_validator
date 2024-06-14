Given(/^I create a new checker$/) do
  @checker = UkAccountValidator::Validator.new
end

Given(/^I have a sort code (.+)$/) do |sort_code|
  @checker.sort_code = sort_code
end

Given(/^I have an account number (\S+)$/) do |acc_number|
  @checker.account_number = acc_number
end

Then(/^the modulus is (\S+)$/) do |modulus|
  expect(@checker.modulus_weights.first.modulus).to eq modulus
end

Then(/^the combination is valid$/) do
  expect(@checker.valid?).to be true
end

Then(/^the combination is invalid$/) do
  expect(@checker.valid?).to be false
end
