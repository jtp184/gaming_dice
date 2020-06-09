module GamingDice
  # Holds the status of a deck of cards for rule-adherance
  class CardDeck
    # The pile of cards that are yet to be drawn
    attr_reader :draw_pile
    # The pile of cards that have most recently been drawn
    attr_reader :in_play
    # Cards that have been drawn and discarded
    attr_reader :discard_pile

    # Sets up initial values for the arrays
    def initialize
      @discard_pile = []
      @in_play = []
      @draw_pile = StringParser.all_hex_couplets.map do |hex|
        Card.draw_a(hex)
      end

      shuffle
    end

    # Draws a hand of cards with +count+ cards, discarding the previous hand
    def draw_hand(count = 1)
      discard_pile.unshift(in_play.shift) until in_play.empty?

      if count <= draw_pile.length
        count.times { draw }
      else
        remain = count - draw_pile.length

        draw_pile.length.times { draw }
        shuffle
        remain.times { draw }
      end

      in_play
    end

    # Draws a single card from the draw_pile to the in_play pile if possible
    def draw
      in_play.unshift(draw_pile.shift) unless draw_pile.empty?
    end

    # Moves all cards from the discard_pile to the draw_pile and then shuffles
    def shuffle
      draw_pile.unshift(discard_pile.shift) until discard_pile.empty?

      draw_pile.shuffle!
    end

    # Moves a +card+ from in_play to the discard_pile
    def discard(card)
      discard_pile.unshift(in_play.delete(card))
    end
  end
end
