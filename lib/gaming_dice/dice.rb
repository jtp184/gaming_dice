module GamingDice
  class Dice
    # Simpler regex to confirm presence
    DICE_REGEX = /(?:(?:a\s|\d+)d(?:\d+)(?:e)?(?:\+\d+|-\d+)?)\s?(?:&|\+)*/i.freeze

    # Grouped regex for meaning extraction
    DICE_REGEX_GROUPED = /
      (?:
        (?:
          (?<count>a\s|\d+) # count
          d
          (?<faces>\d+) # sides
          (?<explodes>e)? # explode
          (?<bonus>\+\d+|-\d+)? # flat bonus
        )
        \s?(?<continuant>&|\+)* # continuant
      )
    /ix.freeze

    class << self
      # Passes the value to be parsed by the parser. This is an entry function
      # and can take in a string +input+ to convert into one or more Dice.
      def call(input)
        parse_dice(input)
      end

      # The roll class method either takes in a string, or an array of dice as
      # +input+, and returns the roll results. If there's only once dice,
      # it will return just one Integer as a result. Otherwise, it returns
      # an array of results for each dice.
      def roll(input)
        res = parse_dice(input).map(&:roll)
        res.one? ? res.first : res
      end

      # Takes in a string, or an array of dice as +input+,
      # and returns the single best result of all dice rolls
      def take_best(input)
        parse_dice(input).map(&:roll).min
      end

      # Takes in a string, or an array of dice as +input+,
      # and returns the worst result of all dice rolls
      def take_worst(input)
        parse_dice(input).map(&:roll).max
      end

      private

      # Disambiguation function, if +input+ is dice or an array of dice
      # (or anything which responds to #roll) it uses them. Otherwise, tries
      # to convert the +input+ to a string and run #parse_dice_string on it
      def parse_dice(input)
        return Array(input) if Array(input).all? { |i| i.respond_to?(:roll) }

        parse_dice_string(input.to_str)
      end

      # Uses a regular expression to parse each dice statement
      # and construct a dice object out of them.
      def parse_dice_string(input)
        input.split(', ').each_with_object([]) do |terms, results|
          dices = terms.scan(DICE_REGEX).map { |sc| cast_dice_components(sc) }

          results << if dices.one? && dices.first[:count] == 1
                       Dice.new(dices.first)
                     elsif dices.one?
                       pool = Array.new(dices.first[:count], dices.first)
                       pool.map! { |d| Dice.new(d) }
                       DicePool.new(pool)
                     else
                       dice_objects = dices.map do |d|
                         if d[:count] == 1
                           Dice.new(d)
                         else
                           DicePool.new(Array.new(d[:count]) { Dice.new(d) })
                         end
                       end

                       discrete = dices.all? { |d| d[:continuant] != :plus }
                       DicePool.new(dice_objects, discrete)
                     end
        end
      end

      # Takes the +input+ string and converts it to an options hash
      def cast_dice_components(input)
        scanned = input.match(DICE_REGEX_GROUPED)
                       .named_captures
                       .transform_keys(&:to_sym)

        scanned[:count] = 1 if scanned[:count].include?('a')
        scanned[:count] = scanned[:count].to_i

        %i[faces bonus].each { |i| scanned[i] = scanned[i].to_i }

        scanned[:explodes] = !scanned[:explodes].nil?
        scanned[:continuant] = case scanned[:continuant]
                               when '&'
                                 :and
                               when '+'
                                 :plus
                               when nil
                                 :end
                               end

        scanned
      end
    end
  end

  # The core class. Models a die, with various properties.
  class Dice
    include Comparable
    # The number of faces this dice has. Controls how high it can roll.
    attr_accessor :faces

    # Any flat bonus the dice has, added at the end.
    attr_accessor :bonus

    # Whether the dice explodes, i.e. re-rolls and adds
    # the result if it critically succeeds.
    attr_accessor :explodes

    # Specified in +params+ are values for :count, :faces, :bonus, and :explodes
    # , used to set the instance variables of the same name.
    # If left unspecified they default to zeros and false.
    def initialize(**params)
      @faces = params.fetch(:faces) { 0 }
      @bonus = params.fetch(:bonus) { 0 }
      @explodes = params.fetch(:explodes) { false }
    end

    # Calculates rolling the dice. Accounts for explosion, and flat bonuses.
    # Returns an Integer.
    def result
      end_result = 0

      1.times do
        this_roll = rand(1..faces)
        end_result += this_roll
        redo if explodes && this_roll == faces
      end

      end_result += bonus
    end

    alias roll result

    # Syntactic sugar for Dice#explodes
    def explodes?
      explodes
    end

    def to_s # :nodoc:
      dice_string = "d#{faces}#{explodes? ? '!' : ''}"

      if bonus.positive?
        dice_string << "+#{bonus}"
      elsif bonus.negative?
        dice_string << bonus.to_s
      end

      dice_string
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
