module GamingDice
  # Handles extracting dice values from strings
  class StringParser
    # Simpler regex to confirm presence
    DICE_FINDER = /(?:(?:(?:(?:\d+|a\s)d(?:\d+)(?:e?))(?:\s(?:[+&wb]))?)|(?:-?\d+\b))/i.freeze

    # Grouped regex for meaning extraction
    DICE_MATCHER = /
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
      (?<constant>-?\d+\b)
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
      continuant: ->(v) { CONTINUANTS[v] }
    }.freeze

    # Detect hex couplets
    HEX_FINDER = /^[abcd][1-9a-e]$/i.freeze

    # Detects simple string card declarations
    CARD_STRING = /^(\d+|k|q|j|f)(s|h|d|c|b|r)$/i.freeze

    class << self
      # Entry function, performs a scan of inputs, then parses them as dice
      def call(input)
        case input
        when HEX_FINDER
          [:card, parse_hex_couplet(input)]
        when CARD_STRING
          [:card, parse_card_string(input)]
        when DICE_FINDER
          [:dice, parse_dice(input)]
        else
          raise ArgumentError, %("#{input}" could not be parsed)
        end
      end

      # Takes in the +input+ yielded from the StringParser and converts
      # them into dice and dice pool structures
      def parse_dice(input)
        tokenize(input).map do |groups|
          groups.map do |term|
            cast_capture_values(term)
          end
        end
      end

      # Takes the +hex+ couplet and derives its matching Card attributes
      def parse_hex_couplet(hex)
        hc = [
          hex.chars[0].to_i(16) - 10,
          hex.chars[1].to_i(16)
        ]

        { suit: Card::SUIT_ORDERING.key(hc[0]), value: hc[1], type: :card }
      end

      # Takes the card +str+ and extracts its value and suit
      def parse_card_string(str)
        card = CARD_STRING.match(str).captures
        { value: cast_card_value(card[0]), suit: cast_card_suit(card[1]) }
      end

      # Returns all hex couplets, Ace-King in all suits plus a
      # joker of hearts and of clubs
      def all_hex_couplets
        return @all_hex_couplets if @all_hex_couplets

        prefixes = %w[a b c d]
        suffixes = (1..13).to_a.map { |s| s.to_s(16) }

        @all_hex_couplets = prefixes.map { |pf| suffixes.map { |sf| pf + sf } }
                                    .flatten
                                    .append('be')
                                    .append('de')
                                    .sort
      end

      private

      # Casts the suit +arg+ into a suit symbol
      def cast_card_suit(arg)
        case arg
        when 's'
          :spades
        when 'h', 'r'
          :hearts
        when 'd'
          :diamonds
        when 'c', 'b'
          :clubs
        end
      end

      # Casts the value +arg+ into a numerical value
      def cast_card_value(arg)
        return @cast_card_value[arg] if @cast_card_value

        vals = Hash.new { |h, v| h[v] = v.to_i }

        vals['j'] = 11
        vals['q'] = 12
        vals['k'] = 13
        vals['f'] = 14

        @cast_card_value = vals
        @cast_card_value[arg]
      end

      # Converts captured values to their proper datatypes
      def cast_capture_values(input)
        input.map do |ky, vl|
          [ky, FILTER[ky].call(vl)]
        end.to_h
      end

      # Converts +input+ strings into hash values for object instantiation
      def tokenize(input)
        input.split(', ').map do |group|
          group.scan(DICE_FINDER).map do |term|
            term.match(DICE_MATCHER).named_captures.transform_keys(&:to_sym)
          end
        end
      end
    end
  end
end
