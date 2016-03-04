Feature: PropertyModel Feature
  As a Turbo-Fx user
  I can define PropertyModels
  So that I can define a Schema


  Scenario Outline: Validate Examples
    Given I have a PropertyModel with type "<type>"
    When  I execute the "validate" method with the value "<value>"
    Then  the "errorMessage" property equals "<message>"

    Examples:
      | type         | value                      | message               |
      | EMAIL        | dave.jackson@anywarefx.com |                       |
      | NUMERIC      | 72915                      |                       |
      | DATE         | 7/29/15                    |                       |
      | EMAIL        | dave.jackson               | invalid email address |
      | NUMERIC      | 7.29                       | requires numbers only |
      | DATE         | 7.32                       | invalid date          |
