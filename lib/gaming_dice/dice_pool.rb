require "forwardable"

module GamingDice
  # Holds multiple dice as one
  class DicePool
    extend Forwardable

    # The Dice objects managed by this pool
    attr_accessor :dice

    def_delegators :@dice, :each, :count, :map

    # Uses the +initarg+ to populate the pool
    def initialize(initarg = nil)
      if initarg.is_a?(String)
        @dice = Dice.call(initarg).flatten
      elsif initarg.is_a?(Array)
        @dice = initarg
      elsif initarg.is_a?(Dice)
        @dice = Array(initarg)
      end
    end

    # Rolls all members of dice
    def roll
      dice.map(&:roll)
    end

    # Rolls and then sums the rolls
    def total
      roll.reduce(&:+)
    end
  end
end
