# GamingDice ![travis_ci](https://travis-ci.com/jtp184/gaming_dice.svg?branch=master)

GamingDice allows you to use polyhedral dice with simple string conversions inline in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gaming_dice', github: 'jtp184/gaming_dice'
```

## Documentation

Read the docs on [GitHub Pages](https://jtp184.github.io/gaming_dice/)

## Usage

### Dice

The basic way to use this gem is through the .call method

```ruby
GamingDice.('1d6') # => [#<GamingDice::Dice:0x0... @explodes=false, @faces=6>]
```

Passing in a decodable string results in dice or dice pools. All of these are valid strings:

```
1d6
a d20
3d6 + 1d4
3d10 + 3
1d20 & 3d10
1d12e b 1d6e
1d20 w 1d20
```

You can also use the .roll function if you just want results

```ruby
GamingDice.roll('1d6') # => 3
GamingDice.roll('1d6 + 2') # => 6
GamingDice.roll('1d8 + 3d6') # => 16 (total)
GamingDice.roll('1d6 & 1d8') # => [3, 5] (each)
GamingDice.roll('1d20 b 1d20') # => 14 (best)
GamingDice.roll('1d6 w 1d6') # => 2 (worst)

# Combine terms
GamingDice.roll('1d12e, 1d6e') # => [14, 3]
GamingDice.roll('1d20, 1d4 + 1d6') # => [5, 7]
GamingDice.roll('1d100, 1d10 & 3d6') # => [98, [8, 8]]
GamingDice.roll('1d10, 1d4 b 1d4, a d12, 3d6 + 4') # => [8, 4, 7, 20]

```

### Cards

GamingDice also has the ability to handle standard 52 card decks and the cards within them. Useful for game systems like Savage Worlds which use these for initiative.

```ruby
# Draw a single card
GamingDice.draw.to_s # => "Six of Spades"

# Draw with shorthand or hex notation
GamingDice.draw_a('2c').to_s # => "Two of Clubs"
GamingDice.draw_a('1h').to_s # => "Ace of Hearts"
GamingDice.draw_a('11d').to_s # => "Jack of Diamonds"
GamingDice.draw_a('13s').to_s # => "King of Spades"

GamingDice.draw_a('a1').to_s # => "Ace of Spades"
GamingDice.draw_a('cc').to_s # => "Queen of Diamonds"
GamingDice.draw_a('be').to_s # => "Red Joker"
GamingDice.draw_a('d7').to_s # => "Seven of Clubs"


# Cards are sortable
%w[3c 10h 9s 14c 1s 4d 12s].map { |c| GamingDice.draw(c) }.sort.map(&:to_s)
# =>
# [
#   "Ace of Spades",
#   "3 of Clubs",
#   "4 of Diamonds",
#   "9 of Spades",
#   "10 of Hearts",
#   "Queen of Spades",
#   "Black Joker"
# ]

```

```ruby
# A Deck starts out shuffled and full
deck = GamingDice::CardDeck.new

# Draw cards into your hand this way. #draw_hand discards in play cards before
# drawing more
deck.draw_hand(5)
# =>
# [
#   #<GamingDice::Card:0x0... @value=9, @suit=:clubs>,
#   #<GamingDice::Card:0x0... @value=10, @suit=:clubs>,
#   #<GamingDice::Card:0x0... @value=6, @suit=:clubs>,
#   #<GamingDice::Card:0x0... @value=11, @suit=:hearts>,
#   #<GamingDice::Card:0x0... @value=6, @suit=:hearts>
# ]

# Discard a single card directly
deck.discard(deck.in_play.first) # => [#<GamingDice::Card:0x00007ff8e21cc8d8 @suit=:clubs, @value=9>]

# Draw more and discard all in play
deck.draw_hand(5)
# => 
# [
#   #<GamingDice::Card:0x0... @value=13, @suit=:spades>,
#   #<GamingDice::Card:0x0... @value=6, @suit=:spades>,
#   #<GamingDice::Card:0x0... @value=9, @suit=:spades>,
#   #<GamingDice::Card:0x0... @value=1, @suit=:hearts>,
#   #<GamingDice::Card:0x0... @value=4, @suit=:diamonds>
# ]

# Get counts for the piles
deck.discard_pile.count # => 5
deck.draw_pile.count # => 44
deck.in_play.count # => 5

# Draw a single card without discarding
deck.draw

# Counts keep track!
deck.discard_pile.count # => 5
deck.draw_pile.count # => 43
deck.in_play.count # => 6

# Draw multiple cards without discarding

deck.draw(4)
deck.discard_pile.count # => 5
deck.draw_pile.count # => 39
deck.in_play.count # => 10

```

## DSL

If these functions are more integral to your code, you can take advantage of monkey patches on Integer that are included in the gem.

```ruby
require 'gaming_dice/patches'

1.d6 # => #<GamingDice::Dice:0x0... @explodes=false, @faces=6>
1.d(100).roll # => 87
3.d10 # => #<GamingDice::DicePool:0x0... @dice=[<GamingDice::Dice:0x0... @faces=10>...], @rule=:sum>
1.of_spades.to_s # => 'Ace of Spades'

[
  3.of_clubs,
  10.of_hearts,
  9.of_spades,
  14.of_clubs,
  1.of_spades,
  4.of_diamonds,
  12.of_spades
].sort 
```
