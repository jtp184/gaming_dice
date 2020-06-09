Given(/create a dice$/i) do
  @dice = FactoryBot.build(:dice)
end

Given(/input the dice string (?:["'](.*)["'])/) do |string|
  @dice = GamingDice.call(string)
end

Given(/input (?:the)? dice strings/i) do |strings|
  @dice = strings.raw.flatten.map { |s| GamingDice.call(s) }.flatten
end

Given(/roll the dice string (?:["'](.*)["'])/) do |string|
  @result = GamingDice.roll(string)
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

Then(/receive an array of (?:rollables|dice|dice pools)/i) do
  precon = @dice.all? { |d| d.respond_to?(:roll) }

  expect(precon).to be(true)
end

When(/print the dice/i) do
  @result = @dice.to_s
end

When(/ask for (?:the) integer representation/i) do
  begin
    @result = if @dice.one?
                @dice.first.to_int
              else
                @dice.map(&:to_int)
              end
  rescue StandardError => e
    @exception = e
  end
end

Then("the result should be a simple string") do
  @result.match?(/d\d+/)
end
