Feature: DataModel Feature
  As a Turbo-Fx user
  I can define a DataModel
  So that I can initialize instances of a Schema


  Background:
    Given I have a Schema
    And   I add a PropertyModel with name: "email" and dataType: "EMAIL"
    And   I add a PropertyModel with name: "date" and dataType: "DATE"


  Scenario: Initialize with Strict Schema
    And   I set the "strict" property to "true"
    When  I initialize a DataModel with the Schema
    And   I add a "subject" property
    Then  the model will have the "email" property
    And   the model will have the "date" property
    But   the model will not have the "subject" property


  Scenario: Initialize with non Strict Schema
    And   I set the "strict" property to "false"
    When  I initialize a DataModel with the Schema
    And   I add a "subject" property
    Then  the model will have the "subject" property


  Scenario: Invoke 'validate' method
    And   I initialize a DataModel with the Schema
    And   I set the "date" property to "7/32/15"
    And   I set the "email" property to "dave.jackson"
    When  I execute the "validate" method with the value ""
    Then  the JSON response is equal to "errorResponse"


  Scenario: Invoke 'isValid' method
    And   I initialize a DataModel with the Schema
    And   I set the "date" property to "7/32/15"
    And   I set the "email" property to "dave.jackson"
    When  I execute the "isValid" method with the value ""
    Then  the response is equal to "false"
