Then('each creates a dice pool') do
  @dice.all? { |d| d.is_a? GamingDice::DicePool }
end

Then(/result is a(?: valid)? dice pool/) do
  @result.is_a?(GamingDice::DicePool)
end

Then(/pool rule .* (?:['"](\w+)['"])/) do |rule|
  @dice.first.rule == rule.to_sym
end
