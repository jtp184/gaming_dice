module GamingDice
	# :nodoc:
	# Represents the cards found in a standard 52 card Playing Card deck, plus Jokers.
	# Has behavioral support for value, suit, and color comparison.
	class Card
		include Comparable

		# For comparing the suits in reverse-alphabetical order
		SUIT_ORDERING = {
			spades: 0,
			hearts: 1,
			diamonds: 2,
			clubs: 3,
		}

		# The numerical value of the card as an integer
		attr_reader :value
		# The suit as one of the symbols in SUIT_ORDERING
		attr_reader :suit

		# Feeds in +value+ and +suit+ from +args+
		def initialize(args={})
			@value = args.fetch(:value)
			@suit = args.fetch(:suit)
		end

		# Randomly creates a possible card
		def self.draw
			val = rand(1..14)
			sui = case val
				    when 1..13
				    	SUIT_ORDERING.keys.sample
				    when 14
				    	[:hearts, :clubs].sample
				    end
			new(value: val, suit: sui)
		end

		# Pulls a specific card by using a shorthand notation of "<value><suit>"
		def self.draw_a(card)
			arg = /(\d+|k|q|j|f)(s|h|d|c|b|r)/.match(card).captures
			val = case arg[0]
				    when /\d+/
				    	arg[0].to_i
				    when 'j'
				    	11
				    when 'q'
				    	12
				    when 'k'
				    	13
				    when 'f'
				    	14
				    end

			sui = case arg[1]
						when 's'
							:spades
						when 'h', 'r'
							:hearts
						when 'd'
							:diamonds
						when 'c', 'b'
							:clubs
						end

			new(value: val, suit: sui)
		end

		# Takes the +hex+ couplet and derives its matching Card
		def self.parse_hex_couplet(hex)
			hc = hex.chars.map { |a| a.to_i(16) }
			new(suit: SUIT_ORDERING.key(hc[0]), value: hc[1])
		end

		# Emits the card's suit and value as a 2-character hexadecimal string.
		# The first place is the suit's ordering, and the second is the value.
		def hex_couplet
			[SUIT_ORDERING[suit], value].map { |h| h.to_s(16) }.join
		end

		# True if #color returns :red
		def red?
			color == :red
		end

		# True if #color returns :black
		def black?
			color == :black
		end

		# Uses +suit+ to determine if it's red or black.
		def color
			case suit
			when :hearts, :diamonds
				:red
			when :clubs, :spades
				:black
			end
		end

		# Compares to +other+ by value, tiebroken with suit
		def <=>(other)
			v = value <=> other.value
			v.zero? ? s = SUIT_ORDERING[suit] <=> SUIT_ORDERING[other.suit] : v
		end

		# Returns the next Card object
		def next
			if value < 13
				self.class.new(value: value + 1, suit: suit)
			elsif value == 13 && suit != :clubs
				nindex = SUIT_ORDERING[suit] + 1
				self.class.new(value: 1, suit: SUIT_ORDERING.key(nindex))
			elsif value == 13 && suit == :clubs
				self.class.new(value: 14, suit: :hearts)
			elsif value == 14 && suit == :hearts
				self.class.new(value: 14, suit: :clubs)
			elsif value == 14 && suit == :clubs
				raise IndexError, 'No Higher Card than the Black Joker'
			end
		end

		alias_method :succ, :next

		# Returns the previous Card object
		def prev
			if value == 1 && suit == :spades
				raise IndexError, 'No Lower Card than the Ace of Spades'
			elsif value <= 13 && value > 1
				self.class.new(value: value - 1, suit: suit)
			elsif value == 1
				nindex = SUIT_ORDERING[suit] - 1
				self.class.new(value: 13, suit: SUIT_ORDERING.key(nindex))
			elsif value == 14 && suit == :clubs
				self.class.new(value: 14, suit: :hearts)
			elsif value == 14 && suit == :hearts
				self.class.new(value: 13, suit: :clubs)
			end
		end

		alias_method :pred, :prev

		# Returns a text representation from the attributes
		def to_s
			if value != 14
				"#{value_string} of #{suit.to_s.capitalize}"
			else
				"#{color.to_s.capitalize} #{value_string}"
			end
		end

		# Returns the value
		def to_i
			value
		end

		# Implicitly returns the same as #to_s
		def to_str
			to_s
		end

		private

		# Uses the value to return a textual representation.
		# Converts values outside of (2..10) to face card names.
		def value_string
			case value
			when 1
				'Ace'
			when 2..10
				value.to_s
			when 11
				'Jack'
			when 12
				'Queen'
			when 13
				'King'
			when 14
				'Joker'
			else
				'Trump'
			end
		end
	end
end