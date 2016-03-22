Feature: PouchDBDataSource Feature
  As a Turbo-Fx user
  I can use a DataSource
  So that I can persist JavaScript Objects


  Background:
    Given I have a Schema
    And   I add a PropertyModel with name: "firstName" and dataType: "STRING"
    And   I add an indexed PropertyModel with name: "lastName" and dataType: "STRING"
    And   I have a DataSource
    And   I migrate the Schema against the DataSource with config: "people"
    And   I connect to the DataSource with config: "people"


  Scenario: Insert JavaScript Object
    When  I insert an object
    Then  the object will have a new revision


# NOTE - resetting rev = null, so 'new revision' indicates object was found
  Scenario: Lookup JavaScript Object
    When  I lookup an object
    Then  the object will have a new revision


  Scenario: Update JavaScript Object
    When  I update an object
    Then  the object will have a new revision


  Scenario: Query JavaScript Object
    When  I query the DataSource
    Then  I receive the result set


  Scenario: Destroy JavaScript Object
    When  I destroy an object
    Then  the object will have a new revision
