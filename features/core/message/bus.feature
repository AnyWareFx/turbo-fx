Feature: Message Bus Feature
  As a Turbo-Fx user
  I can Publish and Subscribe to Messages
  So that I can decouple classes


  Scenario: Immutable Messages
    Given I have a Message model with channel: "view", topic: "template" and kind: "rendered"
    When  I add a "data" property
    And   I set the "channel" property to "cucumber"
    Then  the model will not have the "data" property
    And   the "channel" property value will not equal "cucumber"


  Scenario: Bus Subscription
    Given I have a Message Bus
    And   I subscribe to messages with channel: "*", topic: "*" and kind: "*"
    When  I publish a message with channel: "data", topic: "person" and kind: "created"
    And   I publish a message with channel: "notification", topic: "person" and kind: "added"
    And   I publish a message with channel: "view", topic: "form" and kind: "cancelled"
    And   I publish a message with channel: "view", topic: "template" and kind: "loaded"
    And   I publish a message with channel: "view", topic: "template" and kind: "rendered"
    Then  I will receive all bus messages


  Scenario Outline: Channel Subscription
    Given I have a Message Bus
    And   I subscribe to messages with channel: "view", topic: "*" and kind: "*"
    When  I publish a message with channel: "<channel>", topic: "<topic>" and kind: "<kind>"
    Then  I will receive all messages with channel: "view"

    Examples:
      | channel      | topic    | kind      |
      | data         | person   | created   |
      | notification | person   | added     |
      | view         | form     | cancelled |
      | view         | template | loaded    |
      | view         | template | rendered  |


  Scenario Outline: Topic Subscription
    Given I have a Message Bus
    And   I subscribe to messages with channel: "view", topic: "template" and kind: "*"
    When  I publish a message with channel: "<channel>", topic: "<topic>" and kind: "<kind>"
    Then  I will receive all messages with channel: "view" and topic: "template"

    Examples:
      | channel      | topic    | kind      |
      | data         | person   | created   |
      | notification | person   | added     |
      | view         | form     | cancelled |
      | view         | template | loaded    |
      | view         | template | rendered  |


  Scenario Outline: Kind Subscription
    Given I have a Message Bus
    And   I subscribe to messages with channel: "view", topic: "template" and kind: "rendered"
    When  I publish a message with channel: "<channel>", topic: "<topic>" and kind: "<kind>"
    Then  I will receive all messages with channel: "view", topic: "template" and kind: "rendered"

    Examples:
      | channel      | topic    | kind      |
      | data         | person   | created   |
      | notification | person   | added     |
      | view         | form     | cancelled |
      | view         | template | loaded    |
      | view         | template | rendered  |
