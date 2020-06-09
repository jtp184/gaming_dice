Given(/create a card deck/i) do
  @deck = GamingDice::CardDeck.new
end

When(/check the (.*) pile/) do |pile|
  @pile = case pile
          when 'in play'
            :in_play
          when 'discard'
            :discard_pile
          when 'draw'
            :draw_pile
          end

  @result = @deck.send(@pile)
end

Then(/pile has all of the cards/i) do
  expect(@result.count).to eql(54)
end

Given(/draw a hand of (\d+) cards/i) do |int|
  @deck.draw_hand(int.to_i)
end

Then(/pile does not have all of the cards/i) do
  expect(@result.count).not_to eql(54)
end

Then(/pile has (\d+) cards?/i) do |count|
  expect(@result.count).to eql(count.to_i)
end

Given(/discard one of the cards/i) do
  @deck.discard(@deck.in_play.first)
end
