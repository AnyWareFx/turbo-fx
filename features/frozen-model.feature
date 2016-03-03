Feature: Frozen Model Feature
  As a Turbo-Fx user
  I can Freeze a Model
  So that no property values can be changed


  Scenario: Set a Property on an Unfrozen Model
    Given I have an unfrozen Person model
    When  I try to set the "firstName" property to "Dave"
    Then  the "firstName" property value will equal "Dave"


  Scenario: Set a Property on a Frozen Model
    Given I have a frozen Person model
    When  I try to set the "firstName" property to "Dave"
    Then  the "firstName" property value will not equal "Dave"
