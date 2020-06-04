Given(/create a dice/i) do
  @dice = FactoryBot.build(:dice)
end

Given(/input (?:the)? dice strings/i) do |strings|
  @dice = strings.raw.flatten.map { |s| GamingDice.call(s) }
end

Then(/each creates a valid dice/i) do
  @dice.all? { |d| d.is_a? GamingDice::Dice }
end

Given(/give the dice multiple count/i) do
  @dice = FactoryBot.build(:dice, :multiple_count)
end

Then(/dice has multiple count/i) do
  expect(@dice.count).to be > 1
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

Then(/receive an array of dice/i) do
  precon = @dice.all? do |a|
    a.is_a?(Array) && a.all? { |d| d.is_a?(GamingDice::Dice) }
  end

  expect(precon).to be true
end
