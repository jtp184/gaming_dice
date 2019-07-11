@patches

Feature: Monkey patches on the Integer class for dice

Scenario: Four-sided Dice
	Given I have an integer
	And I send the message "d4" to the integer
	Then I receive a dice with 4 faces

Scenario: Six-sided Dice
	Given I have an integer
	And I send the message "d6" to the integer
	Then I receive a dice with 6 faces

Scenario: Eight-sided Dice
	Given I have an integer
	And I send the message "d8" to the integer
	Then I receive a dice with 8 faces

Scenario: Ten-sided Dice
	Given I have an integer
	And I send the message "d10" to the integer
	Then I receive a dice with 10 faces

Scenario: Twelve-sided Dice
	Given I have an integer
	And I send the message "d12" to the integer
	Then I receive a dice with 12 faces

Scenario: Twenty-sided Dice
	Given I have an integer
	And I send the message "d20" to the integer
	Then I receive a dice with 20 faces

Scenario: n-sided Dice
	Given I have an integer
	And I send it the message "d" with an integer argument
	Then I receive a dice with the right number of faces
