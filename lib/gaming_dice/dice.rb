module GamingDice
  # The core class. Models a die, with various properties.
  class Dice
    include Comparable
    # The number of faces this dice has. Controls how high it can roll.
    attr_accessor :faces

    # Whether the dice explodes, i.e. re-rolls and adds
    # the result if it critically succeeds.
    attr_accessor :explodes

    # Specified in +params+ are values for :faces and :explodes
    # , used to set the instance variables of the same name.
    # If left unspecified they default to zero and false.
    def initialize(**params)
      @faces = params.fetch(:faces) { 0 }
      @explodes = params.fetch(:explodes) { false }
    end

    class << self
      # The roll class method takes in a string +input+, and returns
      # the roll results. If there's only once dice, it will return just one
      # Integer as a result. Otherwise, it returns an array of results.
      def roll(input)
        _type, dices = StringParser.call(input)
        res = create(dices).map(&:roll)

        res.one? ? res.first : res
      end

      # Creates dice from the +groups+ returned by the string parser
      def create(groups)
        groups.map do |terms|
          dice = terms.map { |term| dice_cast(term) }

          next dice.first if dice.one?

          DicePool.new(dice, terms.first[:continuant] || :sum)
        end
      end

      private

      # Casts an individual hash +term+ into its representation as either a
      # ConstantValue, Dice, or DicePool
      def dice_cast(term)
        if term[:constant]
          ConstantValue.new(term[:constant])
        elsif term[:count] == 1
          Dice.new(term)
        else
          DicePool.new(
            Array.new(term[:count], term).map! { |d| Dice.new(d) },
            term[:continuant] || :sum
          )
        end
      end
    end

    # Calculates rolling the dice. Accounts for explosion, and flat bonuses.
    # Returns an Integer.
    def result
      result_roll = 0

      1.times do
        this_roll = rand(1..faces)
        result_roll += this_roll

        redo if explodes && this_roll == faces
      end

      result_roll
    end

    alias roll result

    # Syntactic sugar for Dice#explodes
    def explodes?
      explodes
    end

    def to_s # :nodoc:
      "d#{faces}#{explodes? ? '!' : ''}"
    end

    # Slightly unusual behavior. When the comparator methods are called,
    # the Integer() method is called on self and +other+.
    # This dice thus uses a randomly generated roll to compare.
    # This way you can do things like <td>1.d6 > 10</td>
    def <=>(other)
      Integer(self) <=> Integer(other)
    end

    # Implicit conversion method returns a roll result, allowing you to compare
    # the results of rolling a dice against a target number or other dice.
    def to_int
      roll
    end

    def to_str # :nodoc:
      to_s
    end
  end
end
