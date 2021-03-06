Feature: Undo/Redo Feature
  As a Turbo-Fx user
  I can use commands to set properties
  So that I can undo and redo changes


  Scenario: Set Property
    Given I have a Model
    When  I execute a command to set the "firstName" property to "Dave"
    Then  the "firstName" property value will equal "Dave"


  Scenario: Undo Changes
    Given I have a Model
    And   I execute a command to set the "firstName" property to "Dave"
    When  I undo the command
    Then  the "firstName" property value will not equal "Dave"


  Scenario: Redo Changes
    Given I have a Model
    And   I execute a command to set the "firstName" property to "Dave"
    And   I undo the command
    When  I redo the command
    Then  the "firstName" property value will equal "Dave"
