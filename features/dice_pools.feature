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

Scenario: Dice pools with '&'
	Given I input the dice string "1d20 & 3d10"
	Then the pool rule should be 'each'
	And the result is an array of integers

Scenario: Dice pools with '+'
	Given I input the dice string "1d10 + 1d4 + 3"
	Then the pool rule should be 'sum'
	And the result is an integer

Scenario: Dice pools with 'b'
	Given I input the dice string "1d12e b 1d6e"
	Then the pool rule should be 'best'
	And the result is an integer

Scenario: Dice pools with 'w'
	Given I input the dice string "1d20 w 1d20"
	Then the pool rule should be 'worst'
	And the result is an integer
