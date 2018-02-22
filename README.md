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

## Usage

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
