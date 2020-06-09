Given(/i have a card/i) do
  @card = GamingDice::Card.draw
end

Given(/i have the following cards/i) do |table|
  cards = table.raw
  cards.shift
  @card = cards.map(&:join).map { |c| GamingDice::Card.draw_a(c) }
end

Given(/send the message (?:['"](.*)['"]) to the card/i) do |msg|
  begin
    @result = @card.send(msg.to_sym)
  rescue StandardError => e
    @exception = e
  end
end

Given(/send each card the message (?:['"](.*)['"])/i) do |msg|
  begin
    @result = @card.map { |c| c.send(msg.to_sym) }
  rescue StandardError => e
    @exception = e
  end
end

Then(/exception.*raised/) do
  expect(@exception).not_to be_nil
end

Given(/have the card (?:['"](.*)['"])/i) do |card_name|
  all_cards = GamingDice::StringParser.all_hex_couplets
                                      .map { |c| GamingDice::Card.draw_hex(c) }

  @card = all_cards.find { |c| c.to_s == card_name }
end

Then(/resulting card should be (?:['"](.*)['"])/) do |card_name|
  expect(@result.to_s).to eql(card_name)
end

Then(/resulting cards are named/i) do |card_names|
  expect(@result.map(&:to_s)).to eql(card_names.raw.flatten)
end

Given(/input the shorthand strings/i) do |table|
  strs = table.raw.flatten
  @card = strs.map { |s| GamingDice::Card.draw_a(s) }
end

Given(/input the hex strings/i) do |table|
  strs = table.raw.flatten
  @card = strs.map { |s| GamingDice::Card.draw_hex(s) }
end

Given(/have a high card/i) do
  @card ||= []
  @high_card = GamingDice::Card.new(value: 13, suit: :clubs)
  @card << @high_card
end

Given(/have a low card/i) do
  @card ||= []
  @low_card = GamingDice::Card.new(value: 1, suit: :spades)
  @card << @low_card
end

Then(/receive cards named/i) do |table|
  names = table.raw.flatten
  expect(@card.map(&:to_s)).to eq names
end

When(/ask for the suit of my cards/i) do
  pickr = @result || @card
  @result = pickr.map(&:suit)
end

When(/ask for the value of my cards/i) do
  pickr = @result || @card
  @result = pickr.map(&:value)
end

When(/ask for the suit of the card/i) do
  pickr = @result || @card
  @result = pickr.suit
end

When(/ask for the hex couplet of my card/i) do
  @result = @card.hex_couplet
end

Then(/receive a? ?hex couplet string/i) do
  expect(@result).to match(/(:?[a-f]|[0-9]){2}/i)
end

Then(/receive suits named/i) do |table|
  suits = table.raw.flatten.map(&:downcase).map(&:to_sym)
  case @result.is_a? Array
  when true
    expect(@result).to eq(suits)
  when false
    expect(@result).to eq(suits.first)
  end
end

Then(/receive the values/i) do |table|
  values = table.raw.flatten.map(&:downcase).map(&:to_i)
  case @result.is_a? Array
  when true
    expect(@result).to eq(values)
  when false
    expect(@result).to eq(values.first)
  end
end

When(/ask for the color of my cards/i) do
  @result = @card.map do |card|
    [
      card.color,
      card.red?,
      card.black?
    ]
  end
end

Then(/i receive colors named/i) do |table|
  colors = table.raw.flatten.map(&:downcase).map(&:to_sym)

  @result.partition(&:first).each do |col|
    case col[0]
    when :red
      expect(col[1]).to be(true)
      expect(col[1]).to be(false)
    when :black
      expect(col[2]).to be(true)
      expect(col[2]).to be(false)
    end
  end

  expect(@result.map(&:first)).to eq(colors)
end

When(/sort the cards/i) do
  @result = @card.sort
end

Then(/low card should be on top/i) do
  expect(@result.first).to eq(@low_card)
end
