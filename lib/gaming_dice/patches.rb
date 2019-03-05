class Integer
	# :nodoc:
	# Creates a heart suited card from the integer value
	def of_hearts
		GamingDice::Card.new(value: self, suit: :hearts)
	end

	# Creates a heart suited card from the integer value
	def of_clubs
		GamingDice::Card.new(value: self, suit: :clubs)
	end

	# Creates a heart suited card from the integer value
	def of_spades
		GamingDice::Card.new(value: self, suit: :spades)
	end

	# Creates a heart suited card from the integer value
	def of_diamonds
		GamingDice::Card.new(value: self, suit: :diamonds)
	end

	# Creates a bundle of dice with +faces+ and count of self
	def d(faces=1)
		GamingDice::Dice.new(count: self, faces: faces)
	end

	# Creates a bundle of d4s
	def d4
		GamingDice::Dice.new(count: self, faces: 4)
	end

	# Creates a bundle of d6s
	def d6
		GamingDice::Dice.new(count: self, faces: 6)
	end

	# Creates a bundle of d8s
	def d8
		GamingDice::Dice.new(count: self, faces: 8)
	end

	# Creates a bundle of d10s
	def d10
		GamingDice::Dice.new(count: self, faces: 10)
	end

	# Creates a bundle of d12s
	def d12
		GamingDice::Dice.new(count: self, faces: 12)
	end

	# Creates a bundle of d20s
	def d20
		GamingDice::Dice.new(count: self, faces: 20)
	end
end