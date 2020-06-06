require 'forwardable'

module GamingDice
  # Holds multiple dice as one
  class DicePool
    extend Forwardable

    # The Dice objects managed by this pool
    attr_accessor :dice
    # Determines whether the dice should be handled seperately or together
    attr_accessor :discrete

    def_delegators :@dice, :each, :count, :map

    # Uses the +initarg+ to populate the pool
    def initialize(initarg = nil, discr = false)
      if initarg.is_a?(String)
        @dice = Dice.call(initarg).flatten
      elsif initarg.is_a?(Array)
        @dice = initarg
      elsif initarg.is_a?(Dice)
        @dice = Array(initarg)
      end

      @discrete = discr
    end

    # Rolls all members of dice
    def roll
      discrete? ? roll_all : total
    end

    # Returns individual roll results per dice in the pool
    def roll_all
      dice.map(&:roll)
    end

    # Rolls and then sums the rolls
    def total
      roll_all.reduce(&:+)
    end

    # Predicate method for the discrete attribute
    def discrete?
      !!discrete
    end

    # Slightly unusual behavior. When the comparator methods are called,
    # the Integer() method is called on self and +other+.
    # This dice thus uses a randomly generated roll to compare.
    def <=>(other)
      Integer(self) <=> Integer(other)
    end

    # Implicit conversion method returns a roll result, allowing you to compare
    # the results of rolling a dice against a target number or other dice.
    def to_int
      roll
    end
  end
end
