Feature: Dice can be persisted as objects

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

Scenario: Comma separated values return multiple dice objects
	Given I input the dice strings
		| 1d6, 1d8 |
		| 1d12, 1d3 |
		|  1d100, 1d6 |
	Then I receive an array of dice for each