Then('each creates a dice pool') do
  expect(@dice.all? { |d| d.is_a? GamingDice::DicePool }).to be(true)
end

Then(/result is a(?: valid)? dice pool/) do
  expect(@result).to be_a(GamingDice::DicePool)
end

Then(/pool rule .* (?:['"](\w+)['"])/) do |rule|
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
