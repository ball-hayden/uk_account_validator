Given(/^I have the following weight data:$/) do |weight_data|
  @weight = UkAccountValidator::ModulusWeight.new(weight_data)
end

Then(/^the weight's (\S+) is (\S+)$/) do |arg, value|
  expect(@weight.send(arg).to_s).to eq value
end
