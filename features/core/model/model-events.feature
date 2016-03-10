Feature: Model Events Feature
  As a Turbo-Fx user
  I can Observe a Model
  So that I can react to property changes


  Scenario: Property Changed Event
    Given I have a Model
    And   I observe the "changed" event
    When  I set the "firstName" property to "Dave"
    Then  I will receive the "changed" event
    And   the "firstName" property value will equal "Dave"


  Scenario: Property Change Cancelled
    Given I have a Model
    And   I observe the "changed" event
    And   I cancel the "changing" event
    When  I set the "firstName" property to "Dave"
    Then  I will not receive the "changed" event
    And   the "firstName" property value will not equal "Dave"
