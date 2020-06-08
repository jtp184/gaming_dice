module GamingDice
  # Handles extracting dice values from strings
  class StringParser
    # Simpler regex to confirm presence
    FINDER = /(?:(?:(?:(?:\d+|a\s)d(?:\d+)(?:e?))(?:\s(?:[+&wb]))?)|(?:-?\d+))/i.freeze

    # Grouped regex for meaning extraction
    MATCHER = /
    (?:
      (?:
        (?:
          (?<count>\d+|a\s)
          d
          (?<faces>\d+)
          (?<explodes>e)?
          )
        (?:
          \s
          (?<continuant>[+&wb])
          )
        ?
        )
      |
      (?<constant>-?\d+)
      )
    /ix.freeze

    # Mapping of continuants to symbols
    CONTINUANTS = {
      '&' => :each,
      '+' => :sum,
      'w' => :worst,
      'b' => :best
    }.freeze

    # Converts the capture groups to their proper formats
    FILTER = {
      constant: ->(v) { v.nil? ? v : v.to_i },
      count: ->(v) { v.to_s.include?('a') ? 1 : v.to_i },
      faces: ->(v) { v.to_i },
      explodes: ->(v) { !v.nil? },
      continuant: ->(v) { CONTINUANTS[v] },
    }.freeze

    class << self
      # Entry function, performs a scan of inputs, then parses them as dice
      def call(input)
        parse_dice(scan(input))
      end

      # Takes in the +groups+ yielded from the StringParser and converts
      # them into dice and dice pools
      def parse_dice(groups)
        groups.map do |terms|
          dice = terms.map do |term|
            dice_cast(term)
          end

          next dice.first if dice.one?

          DicePool.new(dice, terms.first[:continuant] || :sum)
        end
      end

      # Tokenizes and casts the capture values
      def scan(input)
        tokenize(input).map do |groups|
          groups.map do |term|
            cast_capture_values(term)
          end
        end
      end

      private

      # Casts an individual hash +term+ into its representation as either a
      # ConstantValue, Dice, or DicePool
      def dice_cast(term)
        if term[:constant]
          ConstantValue.new(term)
        elsif term[:count] == 1
          Dice.new(term)
        else
          DicePool.new(
            Array.new(term[:count], term).map! { |d| Dice.new(d) }
          )
        end
      end

      # Converts captured values to their proper datatypes
      def cast_capture_values(input)
        input.map do |ky, vl|
          [ky, FILTER[ky].call(vl)]
        end.to_h
      end

      # Converts input strings into hash values for object instantiation
      def tokenize(input)
        input.split(', ').map do |group|
          group.scan(FINDER).map do |term|
            term.match(MATCHER).named_captures.transform_keys(&:to_sym)
          end
        end
      end
    end
  end
end
