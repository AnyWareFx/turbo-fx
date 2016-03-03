Feature: Message Bus Feature
  As a Turbo-Fx user
  I can Publish and Subscribe to Messages
  So that I can decouple classes


  Scenario: Immutable Messages
    Given I have "view" channel, "template" topic "rendered" Message model
    When  I try to add a "data" property
    And   I try to set the "channel" property to "cucumber"
    Then  the model will not have the "data" property
    And   the "channel" property value will not equal "cucumber"


  Scenario: Bus Subscription
    Given I have a Message Bus
    When  I subscribe to "*" channel, "*" topic and "*" messages
    And   I publish a "data" channel, "person" topic "created" message
    And   I publish a "notification" channel, "person" topic "added" message
    And   I publish a "view" channel, "form" topic "cancelled" message
    And   I publish a "view" channel, "template" topic "loaded" message
    And   I publish a "view" channel, "template" topic "rendered" message
    Then  I will receive all bus messages


  Scenario: Channel Subscription
    Given I have a Message Bus
    When  I subscribe to "view" channel, "*" topic and "*" messages
    And   I publish a "data" channel, "person" topic "created" message
    And   I publish a "notification" channel, "person" topic "added" message
    And   I publish a "view" channel, "form" topic "cancelled" message
    And   I publish a "view" channel, "template" topic "loaded" message
    And   I publish a "view" channel, "template" topic "rendered" message
    Then  I will receive all "view" channel messages


  Scenario: Topic Subscription
    Given I have a Message Bus
    When  I subscribe to "view" channel, "template" topic and "*" messages
    And   I publish a "data" channel, "person" topic "created" message
    And   I publish a "notification" channel, "person" topic "added" message
    And   I publish a "view" channel, "form" topic "cancelled" message
    And   I publish a "view" channel, "template" topic "loaded" message
    And   I publish a "view" channel, "template" topic "rendered" message
    Then  I will receive all "view" channel and "template" topic messages


  Scenario: Kind Subscription
    Given I have a Message Bus
    When  I subscribe to "view" channel, "template" topic and "rendered" messages
    And   I publish a "data" channel, "person" topic "created" message
    And   I publish a "notification" channel, "person" topic "added" message
    And   I publish a "view" channel, "form" topic "cancelled" message
    And   I publish a "view" channel, "template" topic "loaded" message
    And   I publish a "view" channel, "template" topic "rendered" message
    Then  I will receive "view" channel, "template" topic "rendered" messages
