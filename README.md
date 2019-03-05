# GamingDice

GamingDice allows you to use polyhedral dice with simple string conversions inline in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gaming_dice'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gaming_dice

## Basic Usage

The basic way to use this gem is through the .call method

```ruby
GamingDice.('1d6') # => [#<GamingDice::Dice:0x007... @bonus=0, @count=1, @explodes=false, @faces=6>]
```

Passing in a decodable string results in a collection of dice. All of these are valid strings:

```
1d6
3d10+3
a d20
1d12e, 1d6e
```

You can also use the .roll function if you just want results

```ruby
GamingDice.roll('1d6') # => 4
GamingDice.roll('1d12e, 1d6e') # => [15, 3]
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

2.d6 # => #<GamingDice::Dice:0x0a3... @bonus=0, @count=2, @explodes=false, @faces=6>
1.d(100).roll # => 87
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
# 	Ace of Spades
# 	3 of Clubs
# 	4 of Diamonds
# 	9 of Spades
# 	10 of Hearts
# 	Queen of Spades
# 	Black Joker
```