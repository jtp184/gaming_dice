Given(/create a dice/i) do
  @dice = FactoryBot.build(:dice)
end

Given(/input the dice string "(.*)"/) do |string|
  @dice = GamingDice.call(string)
end

Given(/input (?:the)? dice strings/i) do |strings|
  @dice = strings.raw.flatten.map { |s| GamingDice.call(s) }.flatten
end

Then(/each creates a valid dice/i) do
  @dice.all? { |d| d.is_a? GamingDice::Dice }
end

Given(/make the dice explode/i) do
  @dice = FactoryBot.build(:dice, :explodes)
end

Then(/dice does explode/i) do
  expect(@dice.explodes?).to be true
end

Given(/give the dice(?: a )?bonus/i) do
  @dice = FactoryBot.build(:dice, :bonus)
end

Then(/dice has a bonus/i) do
  expect(@dice.bonus).to be > 0
end

Then(/receive an array of (?:rollables|dice|dice pools)/i) do
  precon = @dice.all? { |d| d.respond_to?(:roll) }

  expect(precon).to be(true)
end

Then(/result is an integer/) do
  @result.is_a?(Integer)
end

Then(/result is an array of integers/) do
  @result.is_a?(Array) && @result.all? { |r| r.is_a?(Integer) }
end
