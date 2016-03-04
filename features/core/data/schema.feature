Feature: Schema Feature
  As a Turbo-Fx user
  I can define a Data Schema
  So that I can validate model properties


  Scenario: Validate - Valid Property
    Given I have a ContactPoint DataModel
    When  I try to set the "email" property to "dave.jackson@anywarefx.com"
    And   I execute the "validate" method
    Then  the response is equal to the "validationErrors" property
    And   the "validationErrors" property is empty


  Scenario: Validate - Invalid Property
    Given I have a ContactPoint DataModel
    When  I try to set the "email" property to "Dave"
    And   I execute the "validate" method
    Then  the response is equal to the "validationErrors" property
    And   the "validationErrors" property contains "Invalid email address"


  Scenario: isValid - Valid Property
    Given I have a ContactPoint DataModel
    When  I try to set the "email" property to "dave.jackson@anywarefx.com"
    And   I execute the "isValid" method
    Then  the response is equal to "true"
    And   the "validationErrors" property is empty


  Scenario: isValid - Invalid Property
    Given I have a ContactPoint DataModel
    When  I try to set the "email" property to "Dave"
    And   I execute the "isValid" method
    Then  the response is equal to "false"
    And   the "validationErrors" property contains "Invalid email address"
