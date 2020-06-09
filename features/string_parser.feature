Feature: String parsing for dice and cards

Scenario: Trying to parse an unintelligible string raises an exception
	Given I input the dice string "This isn't a dice"
	Then an exception should be raised