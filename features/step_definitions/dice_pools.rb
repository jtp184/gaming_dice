Then('each creates a dice pool') do
  expect(@dice.all? { |d| d.is_a? GamingDice::DicePool }).to be(true)
end

Then(/result is a(?: valid)? dice pool/) do
  expect(@result).to be_a(GamingDice::DicePool)
end

Then(/pool rule .* (?:['"](\w+)['"])/) do |rule|
  expect(@dice.first.rule).to eq(rule.to_sym)
end
