Given(/create a dice/i) do
	@dice = GamingDice.('1d6').first
end

Given(/input (?:the)? dice strings/i) do |strings|
	@dice = strings.raw.flatten.map { |s| GamingDice.(s) }
end

Then(/each creates a valid dice/i) do
	@dice.all? { |d| d.is_a? GamingDice::Dice }
end

Given(/give the dice multiple count/i) do
	@dice = GamingDice.('2d6').first
end

Then(/dice has multiple count/i) do
	expect(@dice.count).to be > 1
end

Given(/make the dice explode/i) do
  @dice.instance_variable_set(:@explodes, true)
end

Then(/dice does explode/i) do
	expect(@dice.explodes?).to be true
end

Given(/give the dice(?: a )?bonus/i) do
  @dice.instance_variable_set(:@bonus, 1)
end

Then(/dice has a bonus/i) do
	expect(@dice.bonus).to be > 0
end