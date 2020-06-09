Feature: Multiple dice can be collected in a Dice Pool

Scenario: Dice Pools can be created with a dice argument
	Given I create a dice pool
	But I use a dice argument to the dice pool
	When I check the resulting dice pool
	Then the result is a valid dice pool

Scenario: Dice pools can be created empty
	Given I create a dice pool
	But I give no arguments when creating the dice pool
	When I check the resulting dice pool
	Then the result is a valid dice pool
	And the resulting dice pool is empty

Scenario: Dice Pools can be created from multiple count
	Given I input the dice strings
		| 3d6   |
		| 10d10 |
		| 2d20  |
	Then each creates a dice pool

Scenario: Dice Pools can be created from combining terms
	Given I input the dice strings
		| 1d12e & 1d6e |
		| 1d10 & 4d6   |
		| 1d4 + 1d8    |
	Then each creates a dice pool

Scenario: Dice pools with '&'
	Given I input the dice string "1d20 & 3d10"
	Then the pool rule is 'each'
	And after I roll the pool
	Then the result is an array of integers

Scenario: Dice pools with '+'
	Given I input the dice string "1d10 + 1d4 + 3"
	Then the pool rule is 'sum'
	And after I roll the pool
	Then the result is an integer

Scenario: Dice pools with 'b'
	Given I input the dice string "1d12e b 1d6e"
	Then the pool rule is 'best'
	And after I roll the pool
	Then the result is an integer

Scenario: Dice pools with 'w'
	Given I input the dice string "1d20 w 1d20"
	Then the pool rule is 'worst'
	And after I roll the pool
	Then the result is an integer

Scenario: Dice pools can change rules later
	Given I input the dice string "2d20"
	But I change the pool rule to 'each'
	Then the pool rule is 'each'

Scenario: Dice pools can only change to an existant rule
	Given I input the dice string "10d4"
	But I change the pool rule to 'something_that_doesnt_exist'
	Then an exception should be raised

Scenario: Dice pools can cast to integer when discrete
	Given I input the dice string '1d4 b 1d4 b 1d4'
	When I ask for the integer representation
	Then the result is an integer

Scenario: Dice pools raise exception when they can't be cast to int
	Given I input the dice string "1d8 & 1d10 & 1d12"
	When I ask for the integer representation
	Then an exception should be raised