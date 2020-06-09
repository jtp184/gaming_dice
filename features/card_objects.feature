Feature: Playing cards can be persisted as objects

Scenario: Can draw a card directly from the module
Given I draw a card directly
Then I have drawn a card

Scenario: Can draw a specific card directly from the module
	Given I draw a card directly
	But I draw a specific card
	Then I have drawn the card I meant to

Scenario: Cards know how to represent themselves as strings
	Given I have the card "Ace of Spades"
	When I get the string representation of the card
	Then the result is the string "Ace of Spades"

Scenario: Cards in excess of real values still instantiate
	Given I have the following cards
		| Value | Suit |
		| 15    | s    | 
		| 20    | h    | 
		| 27    | d    | 
		| 100   | c    |
	And I send each card the message 'itself'
	Then the resulting cards are named
		| Trump of Spades |
		| Trump of Hearts |
		| Trump of Diamonds |
		| Trump of Clubs |

Scenario: Cards know their suit
	Given I have the following cards
		| Value | Suit |
		| 1     | s    |
		| 3     | h    |
		| 8     | d    |
		| 13    | c    |
	When I ask for the suit of my cards
	Then I receive suits named
		| Spades   |
		| Hearts   |
		| Diamonds |
		| Clubs    |

Scenario: Cards know their color
	Given I have the following cards
		| Value | Suit|
		| 2     | h   |
		| 3     | c   |
	When I ask for the color of my cards
	Then I receive colors named
		| red   |
		| black |

Scenario: Cards know their value
	Given I have the following cards
		| Value | Suit |
		| 2     | h    |
		| 3     | s    |
		| 11    | c    |
		| 14    | d    |
	And I ask for the value of my cards
	Then I receive the values
		| 2  |
		| 3  |
		| 11 |
		| 14 |

Scenario: Creating by shorthand
	Given I input the shorthand strings
		| 1s  |
		| kr  |
		| 11c |
		| fh  |
		| qd  |
		| jb  |
	Then I receive cards named
		| Ace of Spades     |
		| King of Hearts    |
		| Jack of Clubs     |
		| Red Joker         |
		| Queen of Diamonds |
		| Jack of Clubs     |

Scenario: Creating by hex couplet
	Given I input the hex strings
		| 0a |
		| 12 |
		| 39 |
		| 2b |
	Then I should receive cards named
		| Ten of Spades     |
		| Two of Hearts      |
		| Nine of Clubs       |
		| Jack of Diamonds |

Scenario: Returning a hex couplet
	Given I have a card
	When I ask for the hex couplet of my card
	Then I should receive a hex couplet string

Scenario: Cards are sorted in proper order, lowest to highest
	Given I have a high card
	And I have a low card
	When I sort the cards
	Then the low card should be on top

Scenario: A Card can return its next card
	Given I have the following cards
		| Value | Suit |
		| 2     | s    |
		| 5     | h    |
		| 10    | d    |
		| 12    | c    |
	And I send each card the message "next"
	Then the resulting cards are named
		| Three of Spades      |
		| Six of Hearts      |
		| Jack of Diamonds |
		| King of Clubs    | 

Scenario: A Card can return its previous card
	Given I have the following cards
		| Value | Suit |
		| 5     | s    |
		| 8     | h    |
		| 12    | d    |
		| 13    | c    |
	And I send each card the message "prev"
	Then the resulting cards are named
		| Four of Spades       |
		| Seven of Hearts       |
		| Jack of Diamonds  |
		| Queen of Clubs    |

Scenario: A Card can return its next card even when it elevates suit
	Given I have the following cards
		| Value | Suit |
		| 13    | s    |
		| 13    | h    |
		| 13    | d    |
	And I send each card the message "next"
	When I ask for the suit of my cards
	Then I receive suits named
		| hearts   |
		| diamonds |
		| clubs    |

Scenario: A Card can return its previous card even when it demotes suit
	Given I have the following cards
		| Value | Suit |
		| 1     | c    |
		| 1     | d    |
		| 1     | h    |
	And I send each card the message "prev"
	When I ask for the suit of my cards
	Then I receive suits named
		| diamonds |
		| hearts   |
		| spades   |

Scenario: A Card can return its next card when it is one of the top 3 cards
	Given I have the following cards
		| Value | Suit |
		| 13    | c    |
		| 14    | h    |
	And I send each card the message "next"
	Then the resulting cards are named
		| Red Joker   |
		| Black Joker |

Scenario: A Card can return its previous card when it is one of the top 3 cards
	Given I have the following cards
		| Value | Suit |
		| 14    | c    |
		| 14    | h    |
	And I send each card the message "prev"
	Then the resulting cards are named
		| Red Joker   |
		| King of Clubs |

Scenario: A Card raises an exception if it's lower than the lowest card
	Given I have the card "Ace of Spades"
	And I send the message "prev" to the card
	Then an exception should be raised

Scenario: A Card raises an exception if it's higher than the highest card
	Given I have the card "Black Joker"
	And I send the message "next" to the card
	Then an exception should be raised

