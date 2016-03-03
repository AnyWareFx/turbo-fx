Feature: Frozen Model Feature
  As a Turbo-Fx user
  I can Publish and Subscribe to Messages
  So that I can decouple classes


  Scenario: Immutable Messages
    Given I have a Message
    When  I try to add a "data" property
    And   I try to set the "channel" property to "view"
    Then  the model will not have the "data" property
    And   the "channel" property value will not equal "view"
