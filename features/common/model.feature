Feature: Model Feature
  As a Turbo-Fx user
  I can Construct a Model
  So that I can Manage Properties...


  Scenario: Add a New Property to an Unlocked Model
    Given I have a Model
    When  I add a "salutation" property
    Then  the model will have the "salutation" property


  Scenario: Set Property Value
    Given I have a Model
    When  I set the "firstName" property to "Dave"
    Then  the "firstName" property value will equal "Dave"
