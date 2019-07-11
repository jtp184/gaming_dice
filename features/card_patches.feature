Feature: Monkey patches on the Integer class for cards

Background: 
	Given I have included the monkey patches

Scenario: Hearts card
	Given I have an integer
	And I send the message "of_hearts" to the integer
	When I ask for the suit of the card
	Then I should receive suits named
		| Hearts |

Scenario: Spades card
	Given I have an integer
	And I send the message "of_spades" to the integer
	When I ask for the suit of the card
	Then I should receive suits named
		| Spades |

Scenario: Diamonds card
	Given I have an integer
	And I send the message "of_diamonds" to the integer
	When I ask for the suit of the card
	Then I should receive suits named
		| Diamonds |

Scenario: Clubs card
	Given I have an integer
	And I send the message "of_clubs" to the integer
	When I ask for the suit of the card
	Then I should receive suits named
		| Clubs |

