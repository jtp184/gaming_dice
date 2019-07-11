Feature: Playing cards can be persisted as objects

Scenario: Cards know their suit
	Given I have the following cards
		| Value | Suit |
		| 1     | s    |
		| 3     | h    |
		| 8     | d    |
		| 13    | c    |
	When I ask for the suit of my cards
	Then I receive suits named
		| Spades |
		| Hearts |
		| Diamonds |
		| Clubs |

Scenario: Cards know their color
	Given I have the following cards
		| Value | Suit|
		| 2 | h |
		| 3 | c |
	When I ask for the color of my cards
	Then I receive colors named
		| red |
		| black |

Scenario: Creating by shorthand
	Given I input the shorthand strings
		| 1s |
		| kr |
		| 11c |
		| fh |
		| qd |
		| jb |
	Then I receive cards named
		| Ace of Spades |
		| King of Hearts |
		| Jack of Clubs |
		| Red Joker |
		| Queen of Diamonds |
		| Jack of Clubs |

Scenario: Creating by hex couplet
	Given I input the hex strings
		| 0a |
		| 12 |
		| 39 |
		| 2b |
	Then I should receive cards named
		| 10 of Spades |
		| 2 of Hearts |
		| 9 of Clubs |
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