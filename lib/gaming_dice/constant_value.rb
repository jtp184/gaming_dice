module GamingDice
  # Constant values for flat bonuses
  class ConstantValue
    # Underlying value
    attr_accessor :value

    # Set up value +val+
    def initialize(val)
      @value = val
    end

    # Always returns a constant value
    def roll
      value
    end
  end
end
