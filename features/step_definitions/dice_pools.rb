Then("each creates a dice pool") do
  @dice.all? { |d| d.is_a? GamingDice::DicePool }
end

Then(/result is a(?: valid)? dice pool/) do
  @result.is_a?(GamingDice::DicePool)
end

Then(/receive discrete/) do
  @dice.all?(&:discrete?) == true
end

Then(/receive non-discrete/) do
  @dice.all?(&:discrete?) == false
end
