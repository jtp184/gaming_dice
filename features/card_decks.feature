Feature: Card decks can store multiple cards

Scenario: Card decks can be initialized
	Given I create a card deck
	When I check the draw pile
	Then the pile has all of the cards

Scenario: Drawing a from a deck moves cards out of the draw pile
	Given I create a card deck
	And I draw a hand of 5 cards
	When I check the draw pile
	Then the pile does not have all of the cards

Scenario: Drawing a from a deck moves cards into the in play pile
	Given I create a card deck
	And I draw a hand of 5 cards
	When I check the in play pile
	Then the pile has 5 cards

Scenario: Cards can be manually discarded
	Given I create a card deck
	And I draw a hand of 5 cards
	But I discard one of the cards
	When I check the discard pile
	Then the pile has 1 card

Scenario: A Deck reshuffles if asked to draw more cards than are in the pile
	Given I create a card deck
	And I draw a hand of 53 cards
	And I draw a hand of 5 cards
	When I check the draw pile
	Then the pile has 49 cards
