Feature: Dice can be rolled and return sensible results

Scenario: Dice with explosion can roll higher than their faces
	Given I create a dice
	But I make the dice explode
	When I roll it many times
	Then the result can be higher than the faces

Scenario: Dice with a bonus cannot be lower than that bonus
	Given I create a dice
	But I give the dice a bonus
	When I roll it many times
	Then the result is always greater than the bonus

Scenario: Dice compared with numbers
	Given I create a dice
	When I compare the dice to an integer
	Then I receive a comparator result