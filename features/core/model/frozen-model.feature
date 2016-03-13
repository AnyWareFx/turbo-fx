Feature: Frozen Model Feature
  As a Turbo-Fx user
  I can Freeze a Model
  So that no property values can be changed


  Scenario: Set a Property on a Frozen Model
    Given I have a Model
    And   I set the "frozen" property to "true"
    When  I set the "firstName" property to "Dave"
    Then  the "firstName" property value will not equal "Dave"
