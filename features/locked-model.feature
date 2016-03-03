Feature: Locked Model Feature
  As a Turbo-Fx user
  I can Lock a Model
  So that no new properties can be added


  Scenario: Add a New Property to an Unlocked Model
    Given I have an unlocked Person model
    When  I try to add a "salutation" property
    Then  the model will have the "salutation" property


  Scenario: Add a New Property to a Locked Model
    Given I have a locked Person model
    When  I try to add a "salutation" property
    Then  the model will not have the "salutation" property
