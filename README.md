# GamingDice ![travis_ci](https://travis-ci.com/jtp184/gaming_dice.svg?branch=master)

GamingDice allows you to use polyhedral dice with simple string conversions inline in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gaming_dice', github: 'jtp184/gaming_dice'
```

## Documentation

Read the docs on [GitHub Pages](https://jtp184.github.io/gaming_dice/)

## Basic Usage

The basic way to use this gem is through the .call method

```ruby
GamingDice.('1d6') # => [#<GamingDice::Dice:0x007... @explodes=false, @faces=6>]
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
GamingDice.roll('1d12e, 1d6e') # => [14, 3]
GamingDice.roll('1d100, 1d10 & 3d6') # => [98, [8, 8]]
GamingDice.roll('1d8 + 3d6') # => 16
```

GamingDice also has the ability to handle standard 52 card decks. Useful for game systems like Savage Worlds which use these for initiative.

```ruby
GamingDice.draw # => #<GamingDice::Card:0x7f8... @suit=:hearts, @value=9>
GamingDice.draw.to_s # => 4 of Hearts
GamingDice::Card.new(value: 13, suit: :clubs).to_s # => King of Clubs
```

## DSL

If these functions are more integral to your code, you can take advantage of monkey patches on Integer that are included in the gem.

```ruby
require 'gaming_dice/patches'

1.d6 # => #<GamingDice::Dice:0x0a3... @explodes=false, @faces=6>
1.d(100).roll # => 87
3.d10 # => #<GamingDice::DicePool:0x0b1... @dice=[<GamingDice::Dice:0x0e1... @faces=10>...], @rule=:sum>
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

# =>
#   Ace of Spades
#   3 of Clubs
#   4 of Diamonds
#   9 of Spades
#   10 of Hearts
#   Queen of Spades
#   Black Joker
```
