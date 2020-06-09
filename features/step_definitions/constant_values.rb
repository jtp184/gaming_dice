Given(/i create a constant value/i) do
  @dice = GamingDice::ConstantValue.new(rand(10))
end

Then(/result is always the same/i) do
  expect(@result.uniq.one?).to be(true)
end
