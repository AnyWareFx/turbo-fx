Feature: PropertyModel Feature
  As a Turbo-Fx user
  I can define PropertyModels
  So that I can define a Schema


  Scenario: Validate - Valid Value
    Given I have a PropertyModel with dataType: "EMAIL"
    When  I execute the "validate" method with the value "dave.jackson@anywarefx.com"
    Then  the response is equal to the "errorMessage" property
    And   the "errorMessage" property is empty


  Scenario: Validate - Invalid Value
    Given I have a PropertyModel with dataType: "EMAIL"
    When  I execute the "validate" method with the value "Dave"
    Then  the response is equal to the "errorMessage" property
    And   the "errorMessage" property equals "invalid email address"
