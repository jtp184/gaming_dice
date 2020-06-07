Feature: Multiple dice can be collected in a Dice Pool

Scenario: Dice Pools can be created from multiple count
	Given I input the dice strings
		| 3d6 |
		| 10d10 |
		| 2d20 |
	Then each creates a dice pool

Scenario: Dice Pools can be created from combining terms
	Given I input the dice strings
		| 1d12e & 1d6e |
		| 1d10 & 4d6 |
		| 1d4 + 1d8 |
	Then each creates a dice pool

Scenario: Dice pools can be discrete
	Given I input the dice string "1d20 & 1d10"
	Then I receive discrete dice pools

Scenario: Dice pools can be summative
	Given I input the dice string "1d6 + 1d100"
	Then I receive non-discrete dice pools

Scenario: Discrete rolling
	Given I input the dice strings
		| 1d10 & 1d10 |
		| 2d4e & 4d6 |
		| 1d100 & 1d2 |
	When I roll them
	Then the result is an array of integers

Scenario: Summative rolling
	Given I input the dice strings
		| 1d100 + 1d10+10 |
		| 10d6 + 1d12e |
		| 3d4 |
	When I roll them
	Then the result is an integer
