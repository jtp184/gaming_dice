require 'gaming_dice/version'
require 'gaming_dice/dice'

# Used for polyhedral dice and their rolls.
module GamingDice
  # Syntactic sugar. Aliases to Dice#call and passes the +var+
  def self.call(var)
    Dice.call(var)
  end

  # Syntactic sugar. Aliases to Dice#roll and passes the +var+
  def self.roll(var)
    Dice.roll(var)
  end
end
