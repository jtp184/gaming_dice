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
  def d(faces = 1)
    if self == 1
      GamingDice::Dice.new(faces: faces)
    else
      GamingDice::DicePool.new(
        Array.new(self) { GamingDice::Dice.new(faces: faces) }
      )
    end
  end

  # Creates a bundle of d4s
  def d4
    if self == 1
      GamingDice::Dice.new(faces: 4)
    else
      GamingDice::DicePool.new(
        Array.new(self) { GamingDice::Dice.new(faces: 4) }
      )
    end
  end

  # Creates a bundle of d6s
  def d6
    if self == 1
      GamingDice::Dice.new(faces: 6)
    else
      GamingDice::DicePool.new(
        Array.new(self) { GamingDice::Dice.new(faces: 6) }
      )
    end
  end

  # Creates a bundle of d8s
  def d8
    if self == 1
      GamingDice::Dice.new(faces: 8)
    else
      GamingDice::DicePool.new(
        Array.new(self) { GamingDice::Dice.new(faces: 8) }
      )
    end
  end

  # Creates a bundle of d10s
  def d10
    if self == 1
      GamingDice::Dice.new(faces: 10)
    else
      GamingDice::DicePool.new(
        Array.new(self) { GamingDice::Dice.new(faces: 10) }
      )
    end
  end

  # Creates a bundle of d12s
  def d12
    if self == 1
      GamingDice::Dice.new(faces: 12)
    else
      GamingDice::DicePool.new(
        Array.new(self) { GamingDice::Dice.new(faces: 12) }
      )
    end
  end

  # Creates a bundle of d20s
  def d20
    if self == 1
      GamingDice::Dice.new(faces: 20)
    else
      GamingDice::DicePool.new(
        Array.new(self) { GamingDice::Dice.new(faces: 20) }
      )
    end
  end
end
