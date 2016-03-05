Feature: Schema Feature
  As a Turbo-Fx user
  I can define a Data Schema
  So that I can validate model properties


  Background:
    Given I have a Schema
    And   I add a PropertyModel with name: "email" and dataType: "EMAIL"
    And   I add a PropertyModel with name: "date" and dataType: "DATE"


  Scenario Outline: Validate Examples
    When I execute the "<method>" method with the value "<value>"
    Then the JSON response is equal to <response>

    Examples:
      | method   | value                                                  | response      |
      | validate | {email: 'dave.jackson@anywarefx.com', date: '7/29/15'} | emptyResponse |
      | validate | {email: 'dave.jackson', date: '7/32/15'}               | errorResponse |
