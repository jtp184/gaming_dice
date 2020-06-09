Feature: Constant Values can be mixed in with random dice

Scenario: A Constant Value only ever rolls its value
	Given I create a constant value
	When I roll it many times
	Then the result is always the same
