Feature: Model Events Feature
  As a Turbo-Fx user
  I can Observe a Model
  So that I can react to property changes


  Scenario: Property Changed
    Given I have a Person model
    When  I try to set the 'firstName' property to 'Dave'
    Then  I will observe the 'changed' event
    And   the property will have the new value


  Scenario: Property Change Cancelled
    Given I have a Person model
    When  I try to set the 'firstName' property to 'Dave'
    And   I cancel the 'changing' event
    Then  I will not observe the 'changed' event
    And   the property will not have the new value
