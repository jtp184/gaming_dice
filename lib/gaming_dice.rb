require 'gaming_dice/version'
require 'gaming_dice/string_parser'
require 'gaming_dice/dice'
require 'gaming_dice/dice_pool'
require 'gaming_dice/constant_value'
require 'gaming_dice/card'
require 'gaming_dice/card_deck'

# Used for polyhedral dice and their rolls.
module GamingDice
  # Syntactic sugar. Aliases to StringParser.call and passes the +var+
  def self.call(var)
    type, res = StringParser.call(var)

    case type
    when :dice
      Dice.create(res)
    when :card
      Card.new(res)
    end
  end

  # Syntactic sugar. Aliases to Dice.roll and passes the +var+
  def self.roll(var)
    Dice.roll(var)
  end

  # Syntactic sugar. Aliases to Card.draw
  def self.draw(arg = nil)
    if arg
      Card.draw_a(arg)
    else
      Card.draw
    end
  end
end
