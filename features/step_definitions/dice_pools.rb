Given(/create a dice pool/i) do
  @dice = GamingDice.('3d6')
end

Given(/resulting dice pool/i) do
  @result = @dice
end

When(/roll the pool/i) do
  @result = @dice.map(&:roll)
  @result.one? ? @result.first : @result
end

Given(/dice argument to the dice pool/i) do
  @dice = GamingDice::DicePool.new(GamingDice.('1d6').first)
end

Given(/change (?:the pool) rule to (?:['"](\w+)['"])/i) do |new_rule|
  begin
    @dice.map do |d|
      d.rule = new_rule.to_sym
    end
  rescue StandardError => e
    @exception = e
  end
end

Then('each creates a dice pool') do
  expect(@dice.all? { |d| d.is_a? GamingDice::DicePool }).to be(true)
end

Then(/result is a(?: valid)? dice pool/) do
  expect(@result).to be_a(GamingDice::DicePool)
end

Then(/pool rule is (?:['"](\w+)['"])/) do |rule|
  expect(@dice.first.rule).to eq(rule.to_sym)
end

Then(/receive a dice pool of (\d+) sided dice/i) do |faces|
  result_faces = @result.dice.map(&:faces).uniq

  expect(result_faces.count).to eql(1)
  expect(result_faces.first).to eql(faces.to_i)
end

Then(/receive a dice pool of dice with the right number of faces/) do
  result_faces = @result.dice.map(&:faces).uniq

  expect(result_faces.count).to eql(1)
  expect(result_faces.first).to eql(@int_arg)
end
