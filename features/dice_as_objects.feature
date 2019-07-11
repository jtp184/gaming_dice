Feature: Dice can be persisted as objects

Scenario: Dice can be created with different string formats
	Given I input the dice strings
		| 1d6 |
		| 2d10 |
		| 1d8+1 |
		| 1d12e, 1d6 |
		| 1d100 |
	Then each creates a valid dice

Scenario: Dice can be created with a count
	Given I create a dice
	And I give the dice multiple count
	Then the dice has multiple count

Scenario: Dice can be created with exploding
	Given I create a dice
	And I make the dice explode
	Then the dice does explode

Scenario: Dice can have a flat bonus
	Given I create a dice
	And I give the dice a bonus
	Then the dice has a bonus