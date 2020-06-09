Feature: Dice can be persisted as objects and have sensible roll results

Scenario: Dice can be created with different string formats
	Given I input the dice strings
		| 1d6 |
		| 2d10 |
		| 1d8 + 1 |
		| 1d12e, 1d6 |
		| 1d100 |
	Then each creates a valid dice

Scenario: Dice can be created with exploding
	Given I create a dice
	And I make the dice explode
	Then the dice does explode

Scenario: Dice rolling can be done directly on the class, for a single dice
	Given I roll the dice string "1d6"
	Then the result is an integer

Scenario: Dice rolling can be done directly on the class, for multiple dice
	Given I roll the dice string "3d10"
	Then the result is an array of integers

Scenario: Comma separated values return multiple dice objects
	Given I input the dice strings
		| 1d6, 1d8 |
		| 1d12, 1d3 |
		|  1d100, 1d6 |
	Then I receive an array of dice for each

Scenario: Dice with explosion can roll higher than their faces
	Given I create a dice
	But I make the dice explode
	When I roll it many times
	Then the result can be higher than the faces

Scenario: Dice compared with numbers
	Given I create a dice
	When I compare the dice to an integer
	Then I receive a comparator result

Scenario: Dice know how to represent themselves as strings
	Given I create a dice
	When I print the dice
	Then the result should be a simple string
