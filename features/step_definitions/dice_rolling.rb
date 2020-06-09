When(/roll it$/) do
  @result = @dice.first.roll
end

When(/roll them$/) do
  @result = @dice.map(&:roll)
end

When(/roll it many times/i) do
  @result = Array.new(100) { @dice.roll }
end

Then(/result can be higher than the faces/i) do
  expect(@result.any? { |r| r > @dice.faces }).to be true
end

When(/compare the dice to an integer/i) do
  @result = @dice <=> rand(10)
end

Then(/receive a comparator result/i) do
  expect(@result).to be_between(-1, 1)
end
