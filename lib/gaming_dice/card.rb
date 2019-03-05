module GamingDice
	# :nodoc:
	# Represents the cards found in a standard 52 card Playing Card deck.
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
			new(value: rand(1..14), suit: SUIT_ORDERING.keys.sample)
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

		# Implicitly returns the value
		def to_int
			value
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
				'Fool'
			end
		end
	end
end