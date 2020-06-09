@patches

Feature: Monkey patches on the Integer class for dice

Scenario: Four-sided Dice, one count
	Given I have the number one
	And I send the message "d4" to the integer
	Then I receive a dice with 4 faces

Scenario: Six-sided Dice, one count
	Given I have the number one
	And I send the message "d6" to the integer
	Then I receive a dice with 6 faces

Scenario: Eight-sided Dice, one count
	Given I have the number one
	And I send the message "d8" to the integer
	Then I receive a dice with 8 faces

Scenario: Ten-sided Dice, one count
	Given I have the number one
	And I send the message "d10" to the integer
	Then I receive a dice with 10 faces

Scenario: Twelve-sided Dice, one count
	Given I have the number one
	And I send the message "d12" to the integer
	Then I receive a dice with 12 faces

Scenario: Twenty-sided Dice, one count
	Given I have the number one
	And I send the message "d20" to the integer
	Then I receive a dice with 20 faces

Scenario: n-sided Dice, one count
	Given I have the number one
	And I send it the message "d" with an integer argument
	Then I receive a dice with the right number of faces

Scenario: Four-sided Dice, multiple
	Given I have a number
	And I send the message "d4" to the integer
	Then I receive a dice pool of 4 sided dice

Scenario: Six-sided Dice, multiple
	Given I have a number
	And I send the message "d6" to the integer
	Then I receive a dice pool of 6 sided dice

Scenario: Eight-sided Dice, multiple
	Given I have a number
	And I send the message "d8" to the integer
	Then I receive a dice pool of 8 sided dice

Scenario: Ten-sided Dice, multiple
	Given I have a number
	And I send the message "d10" to the integer
	Then I receive a dice pool of 10 sided dice

Scenario: Twelve-sided Dice, multiple
	Given I have a number
	And I send the message "d12" to the integer
	Then I receive a dice pool of 12 sided dice

Scenario: Twenty-sided Dice, multiple
	Given I have a number
	And I send the message "d20" to the integer
	Then I receive a dice pool of 20 sided dice

Scenario: n-sided Dice, multiple
	Given I have a number
	And I send it the message "d" with an integer argument
	Then I receive a dice pool of dice with the right number of faces
