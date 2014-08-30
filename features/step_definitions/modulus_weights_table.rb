Given(/^I have a modulus weight table loaded from (.+?)$/) do |file_path|
  @table = UkAccountValidator::ModulusWeightsTable.new(
    File.join(File.dirname(__FILE__), '../..', file_path)
  )
end

Then(/^the modulus for sort code (\d+) is (\S+)$/) do |sort_code, mod|
  expect(@table.find(sort_code).modulus).to eq mod
end

Then(/^the modulus for sort code (\d+) cannot be found$/) do |sort_code|
  expect { @table.find(sort_code) }.to raise_exception UkAccountValidator::ModulusWeightsTable::SortCodeNotFound
end
