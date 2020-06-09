require 'forwardable'

module GamingDice
  # Holds multiple dice as one
  class DicePool
    extend Forwardable

    # Possible options for rule to use for returning results
    RULES = %i[each sum worst best].freeze

    # The Dice objects managed by this pool
    attr_accessor :dice
    # Determines the rule for roll results
    attr_reader :rule

    def_delegators :@dice, :each, :count, :map, :<<, :empty?, :one?

    # Uses the +initarg+ to populate the pool
    def initialize(initarg = nil, rul = :sum)
      if initarg.is_a?(NilClass)
        @dice = []
      elsif initarg.is_a?(Array)
        @dice = initarg
      elsif initarg.is_a?(Dice)
        @dice = Array(initarg)
      end

      @rule = rul
    end

    # Sets the rule to +nu_rule+ if it exists
    def rule=(nu_rule)
      unless RULES.include?(nu_rule)
        str = %("#{nu_rule}")
        str << ' is not one of '
        str << RULES.map(&:inspect).join(', ')

        raise ArgumentError, str
      end

      @rule = nu_rule
    end

    # Returns the roll result depending on the rule
    def roll
      case rule
      when :each
        roll_all
      when :sum
        total
      when :worst
        take_worst
      when :best
        take_best
      end
    end

    # Returns individual roll results per dice in the pool. Used with :each
    def roll_all
      dice.map(&:roll)
    end

    # Rolls and then sums the rolls. Used with the :sum rule
    def total
      roll_all.reduce(&:+)
    end

    # Returns the best result of all dice rolls. Used with the :best rule
    def take_best
      roll_all.max
    end

    # Returns the worst result of all dice rolls Used with the :worst rule
    def take_worst
      roll_all.min
    end

    # Implicit conversion method returns a roll result, allowing you to compare
    # the results of rolling these dice against a target number or other dice.
    def to_int
      raise ArgumentError, 'Would return an Array' unless returns_one?

      roll
    end

    # True if a single integer result will be returned by this pool
    def returns_one?
      rule != :each
    end
  end
end
