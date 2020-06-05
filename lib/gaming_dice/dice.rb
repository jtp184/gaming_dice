module GamingDice
  class Dice
    # The regex to match against
    DICE_STRING_REGEX = /
                            (
                              (
                                (a\s|\d+) # count
                                d
                                (\d+) # sides
                                (e)? # explode
                                (\+\d+|\-\d+)? # flat bonus
                              )
                              (\s\&\s|\s\+\s)* # continuant
                              )
                          /ix.freeze

    # Passes the value in to be parsed by the parser. This is an entry function
    # and can take in a string +input+ to convert into one or more dice objects.
    def self.call(input)
      parse_dice(input)
    end

    # The roll class method either takes in a string, or an array of dice as
    # +input+, and returns the roll results. If there's only once dice,
    # it will return just one Integer as a result. Otherwise, it returns
    # an array of results for each dice.
    def self.roll(input)
      res = parse_dice(input).map(&:roll)
      res.length == 1 ? res.first : res
    end

    # Takes in a string, or an array of dice as +input+, 
    # and returns the single best result of all dice rolls
    def self.take_best(input)
      parse_dice(input).map(&:roll).min
    end

    # Takes in a string, or an array of dice as +input+, 
    # and returns the worst result of all dice rolls
    def self.take_worst(input)
      parse_dice(input).map(&:roll).max
    end

    private

    # Disambiguation function, if +input+ is dice or an array of dice
    # (or anything which responds to #roll) it uses them. Otherwise, it
    # tries to convert the +input+ to a string and run #parse_dice_string on it
    def self.parse_dice(input)
      return Array(input) if Array(input).all? { |i| i.respond_to?(:roll) }

      parse_dice_string(input.to_str)
    end

    # Uses a regular expression to parse each dice statement
    # and construct a dice object out of them.
    def self.parse_dice_string(input)
      results = []

      individuals = input.split(', ').each do |terms|
        operators = []
        dices = []

        terms.scan(DICE_STRING_REGEX) do |sc|
          count = sc[2].include?('a') ? 1 : sc[2].to_i
          face = (sc[3].to_i || 0)
          explode = !sc[4].nil?
          flat = (sc[5].to_i || 0)
          op = (sc[6] || '&')

          operators << op
          dices << Dice.new(
            count: count,
            faces: face,
            bonus: flat,
            explodes: explode
          )
        end

        dices = dices.first if dices.length == 1
        results << dices if operators.any? { |op| op == '&' }
        results << dices.inject(:+) if operators.any? { |op| op == '+' }
      end

      results
    end
  end

  # The core class. Models a die, with various properties.
  class Dice
    include Comparable

    # The number of dice in this bundle. 
    # For rolling things like 3d6 as one entity instead of 3 x 1d6
    attr_accessor :count

    # The number of faces this dice has. Controls how high it can roll.
    attr_accessor :faces

    # Any flat bonus the dice has, added at the end.
    attr_accessor :bonus

    # Whether the dice explodes, i.e. re-rolls and adds 
    # the result if it critically succeeds.
    attr_accessor :explodes

    # Specified in +params+ are values for :count, :faces, :bonus, and :explodes
    #, used to set the instance variables of the same name. 
    # If left unspecified they default to zeros and false.
    def initialize(**params)
      @count = params.fetch(:count) { 0 }
      @faces = params.fetch(:faces) { 0 }
      @bonus = params.fetch(:bonus) { 0 }
      @explodes = params.fetch(:explodes) { false }
    end

    # Calculates rolling the dice. Accounts for explosion, and flat bonuses.
    # Returns an Integer.
    def result
      results = []
      result = 0
      count.times do
        this_roll = rand(1..faces)

        if explodes
          this_roll += roll if this_roll == faces
        end

        result += this_roll
      end
      result += bonus
      results << result
      results = results.flatten
      return results.first if results.length == 1

      results
    end

    alias roll result

    # Syntactic sugar for Dice#explodes
    def explodes?
      explodes
    end

    def to_s # :nodoc:
      ret = ''
      count.times { ret << "[#{faces}#{'!' if explodes}]" }
      ret << " #{bonus.negative? ? '-' : '+'}#{bonus.abs}" if bonus != 0
      ret
    end

    # Slightly unusual behavior. When the comparator methods are called,
    # the Integer() method is called on self and +other+.
    # This dice thus uses a randomly generated roll to compare.
    # This way you can do things like <td>Dice.('1d6').roll > 10</td>
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
